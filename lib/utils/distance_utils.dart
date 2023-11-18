import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

const String mapKey = "AIzaSyCYwHNeqOW-oeSSex-b-vqUyZb3vWcWxVA";

Future getDistance(LatLng from, LatLng to, Function callback) async {
  var startLatitude = from.latitude;
  var startLongitude = from.longitude;
  var endLatitude = to.latitude;
  var endLongitude = to.longitude;

  String url =
      'https://maps.googleapis.com/maps/api/distancematrix/json?departure_time=now&destinations=$startLatitude,$startLongitude&origins=$endLatitude,$endLongitude&key=$mapKey';
  try {
    var response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      // debugPrint("Distance is :- ${response.body}");
      Map map = jsonDecode(response.body);
      var distance =
          map["rows"]?[0]?["elements"]?[0]?["distance"]?["text"] ?? "0.0 Km";

      var time =
          map["rows"]?[0]?["elements"]?[0]?["duration"]?["text"] ?? "0 Min.";
      debugPrint(distance.toString());
      debugPrint(time.toString());
      callback(distance, time);
    }
  } catch (e) {
    print(e);
  }
}

Future<LatLng> getCurrentLocation() async {
  Location currentLocation = Location();
  var location = await currentLocation.getLocation();
  return LatLng(location.latitude as double, location.longitude as double);
}
