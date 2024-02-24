import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';

import '../api_key.dart';

class MitikusaSearch {
  final GooglePlace _googlePlace = GooglePlace(apiKey);

  Future<({LatLng latLng, String name})> searchPlace(
      LatLng latLng, String type) async {
    late NearBySearchResponse? nearBySearchResponse;
    nearBySearchResponse = await _googlePlace.search.getNearBySearch(
      Location(lat: latLng.latitude, lng: latLng.longitude), //中心
      50000, //範囲
      keyword: '', //探すキーワード
      type: type,
      rankby: RankBy.Distance,
    );

    if (nearBySearchResponse != null) {
      // ここでGoogle Places APIのレスポンスを解析して、必要な情報を取得
      List<({LatLng latLng, String name})> placeList =
          _parseGooglePlacesResponse(nearBySearchResponse);

      ({LatLng latLng, String name}) place = _adjustMitikusa(latLng, placeList);
      return place;
    } else {
      return (latLng: const LatLng(0.0, 0.0), name: '');
    }
  }

  List<({LatLng latLng, String name})> _parseGooglePlacesResponse(
      NearBySearchResponse nearBySearchResponse) {
    List<({LatLng latLng, String name})> placeList = [];
    //NearBySearchResponseを解析経度を保存するList
    if (nearBySearchResponse.results != null) {
      //nullチェック
      for (SearchResult place in nearBySearchResponse.results!) {
        double lat = place.geometry?.location?.lat ?? 0.0;
        double lng = place.geometry?.location?.lng ?? 0.0;
        String name = place.name ?? 'error';
        placeList.add((latLng: LatLng(lat, lng), name: name));
      }
    }

    return placeList;
  }

  ({LatLng latLng, String name}) _adjustMitikusa(
      LatLng latLng, List<({LatLng latLng, String name})> placeList) {
    const double mitikusaDistance = 1000.0;
    List<({LatLng latLng, String name, double distanceFromMitikusa})> places =
        [];
    for (int i = 0; i < placeList.length; i++) {
      double distanceFromMiddle = Geolocator.distanceBetween(
        placeList[i].latLng.latitude,
        placeList[i].latLng.longitude,
        latLng.latitude,
        latLng.longitude,
      );
      places.add((
        latLng: LatLng(
          placeList[i].latLng.latitude,
          placeList[i].latLng.longitude,
        ),
        name: placeList[i].name,
        distanceFromMitikusa: (distanceFromMiddle - mitikusaDistance).abs()
      ));
    }

    places.sort(
      (a, b) => a.distanceFromMitikusa.compareTo(b.distanceFromMitikusa),
    );

    return (
      latLng: LatLng(
        places.first.latLng.latitude,
        places.first.latLng.longitude,
      ),
      name: places.first.name,
    );
  }
}
