import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:myride/model/trip_model.dart';
import 'package:myride/repository/trip_repo.dart';

class TripViewModel extends ChangeNotifier {
  final _tripRepo = TripRepo();

  List<TripModel> tripList = [];

  Future startTrip(BuildContext context, var bodyTosend) async {
    try {
      final response = await _tripRepo.startTrip(
        context,
        bodyTosend,
      );
      log("RESPONSE $response");
      notifyListeners();
    } catch (e) {
      log('Erroer $e');
    }
  }

  Future editTrip(BuildContext context, var bodyTosend) async {
    try {
      final response = await _tripRepo.startTrip(
        context,
        bodyTosend,
      );
      log("RESPONSE $response");
      notifyListeners();
    } catch (e) {
      log('Erroer $e');
    }
  }

  Future<void> getTrips(BuildContext context) async {
    try {
      final response = await _tripRepo.getTrips(context);
      log("RESPONSE GET $response");

      List<dynamic> jsonList = response as List;
      tripList =
          jsonList.map((jsonItem) => TripModel.fromJson(jsonItem)).toList();
      notifyListeners();
    } catch (e) {
      log('Erroer $e');
    }
  }
}
