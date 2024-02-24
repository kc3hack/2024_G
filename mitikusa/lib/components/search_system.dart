import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';

import '../api_key.dart';

class MitikusaSearch {
  final GooglePlace _googlePlace = GooglePlace(apiKey);

  Future<List<({LatLng latLng, String name})>> searchPlace(
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
      return placeList;
    } else {
      return [];
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
}
