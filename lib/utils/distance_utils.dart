import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

const String mapKey = "AIzaSyCYwHNeqOW-oeSSex-b-vqUyZb3vWcWxVA";

double calculateDistance(LatLng from, LatLng to) {
  var lat1 = from.latitude;
  var lon1 = from.longitude;
  var lat2 = to.latitude;
  var lon2 = to.longitude;

  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  double distance = 12742 * asin(sqrt(a)) * 1000;
  return distance;
}

Future<LatLng> getCurrentLocation() async {
  Location currentLocation = Location();
  var location = await currentLocation.getLocation();
  return LatLng(location.latitude as double, location.longitude as double);
}
