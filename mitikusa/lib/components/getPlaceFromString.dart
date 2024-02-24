import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart' hide Location;

Future<({LatLng latLng, String name})> getPlaceFromString(String value) async {
  final GooglePlace googlePlace =
      GooglePlace("AIzaSyDqTYadtGQTsBsOmwdr1XP20wp-cvPNvQ8");
  late AutocompletePrediction prediction;

  final AutocompleteResponse? autoCompleteResponse =
      await googlePlace.autocomplete.get(value);
  if (autoCompleteResponse != null &&
      autoCompleteResponse.predictions != null) {
    prediction = autoCompleteResponse.predictions!.first;
  }
// locationFromAddress()に検索結果のdescription.toString()を渡す
  List locations = await locationFromAddress(prediction.description!);

  return (
    latLng: LatLng(locations.first.latitude, locations.first.longitude),
    name: prediction.description!.split(' ').last,
  );
}
