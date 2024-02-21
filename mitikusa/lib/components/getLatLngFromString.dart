import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';

Future<LatLng> getLatLngFromString(String value) async {
  final GooglePlace googlePlace =
      GooglePlace("AIzaSyDqTYadtGQTsBsOmwdr1XP20wp-cvPNvQ8");
  List<AutocompletePrediction> predictions = [];

  final result = await googlePlace.autocomplete.get(value);
  if (result != null && result.predictions != null) {
    predictions = result.predictions!;
  }

  List? locations = await locationFromAddress(predictions[0]
      .description
      .toString()); // locationFromAddress()に検索結果のpredictions[index].description.toString()を渡す

  // 取得した経度と緯度を配列に格納
  return LatLng(locations.first.latitude, locations.first.longitude);
}
