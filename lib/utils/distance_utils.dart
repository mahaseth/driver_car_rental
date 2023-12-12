import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

const String mapKey = "AIzaSyCYwHNeqOW-oeSSex-b-vqUyZb3vWcWxVA";

Future getDistance(LatLng from, LatLng to, Function callback) async {
  var startLatitude = from.latitude;
  var startLongitude = from.longitude;
  var endLatitude = to.latitude;
  var endLongitude = to.longitude;

  String Url =
      'https://maps.googleapis.com/maps/api/distancematrix/json?departure_time=now&destinations=$startLatitude,$startLongitude&origins=$endLatitude,$endLongitude&key=$mapKey';
  try {
    var response = await http.get(
      Uri.parse(Url),
    );
    if (response.statusCode == 200) {
      // debugPrint("Distance is :- ${response.body}");
      Map map = jsonDecode(response.body);
      var distance =
          map["rows"]?[0]?["elements"]?[0]?["distance"]?["text"] ?? "0.0 Km";

      var time =
          map["rows"]?[0]?["elements"]?[0]?["duration"]?["text"] ?? "0 Min.";

      if (distance == "0.0 Km") {
        double calDistance = calculateDistance(from, to);
        debugPrint(calDistance.toString());
        distance = "${calDistance.toStringAsFixed(2)} Km";
        var calTime = calDistance / 40;
        calTime = calTime * 60;
        time = "${calTime.toStringAsFixed(2)} Min.";
      }
      debugPrint(distance.toString());
      debugPrint(time.toString());
      callback(distance, time);
    }
  } catch (e) {
    print(e);
  }
}

double calculateDistance(LatLng from, LatLng to) {
  var lat1 = from.latitude;
  var lon1 = from.longitude;
  var lat2 = to.latitude;
  var lon2 = to.longitude;

  debugPrint("$lat1, $lon1, $lat2, $lon2");
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  double distance = 12742 * asin(sqrt(a));
  return distance;
}

Future<LatLng> getCurrentLocation() async {
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  return LatLng(position.latitude, position.longitude);
}
