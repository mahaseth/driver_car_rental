import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:myride/model/trip_model.dart';
import 'package:myride/repository/trip_repo.dart';

class TripViewModel extends ChangeNotifier {
  final _tripRepo = TripRepo();

  List<TripModel> activeTripList = [];
  List<TripModel> completedTripList = [];
  List<TripModel> scheduledTripList = [];
  TripModel? currentTrip;

  // Future startTrip(BuildContext context, var bodyTosend) async {
  //   try {
  //     final response = await _tripRepo.startTrip(
  //       context,
  //       bodyTosend,
  //     );
  //     log("RESPONSE Trip $response");
  //     currentTrip = TripModel.fromJson(response);
  //     notifyListeners();
  //   } catch (e) {
  //     log('Erroer $e');
  //   }
  // }

  Future editTrip(BuildContext context, var bodyTosend, int id) async {
    try {
      final response = await _tripRepo.editTrip(
        context,
        bodyTosend,
        id,
      );
      log("RESPONSE $response");
      notifyListeners();
    } catch (e) {
      log('Error for editTrip $e');
    }
  }

  Future<void> getCurrentTrip(BuildContext context, int id) async {
    try {
      final response = await _tripRepo.getCurrentTrip(context, id);
      log("Trip RESPONSE");

      currentTrip = TripModel.fromJson(response);
      notifyListeners();
    } catch (e) {
      log('Error in trip response $e');
    }
  }

  Future<void> getTrips(BuildContext context) async {
    try {
      final response = await _tripRepo.getTrips(context);
      log("Trip RESPONSE");

      List<dynamic> jsonList = response as List;
      List<TripModel> tripList =
          jsonList.map((jsonItem) => TripModel.fromJson(jsonItem)).toList();
      for (var values in tripList) {
        if (values.status == "COMPLETED") {
          completedTripList.add(values);
        } else {
          activeTripList.add(values);
        }
      }
      notifyListeners();
    } catch (e) {
      log('Error in trip response $e');
    }
  }
}
