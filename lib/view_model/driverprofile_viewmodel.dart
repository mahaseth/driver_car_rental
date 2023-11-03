// ignore_for_file: use_build_context_synchronously, prefer_interpolation_to_compose_strings, file_names, prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:myride/model/driverprofile.dart';
import 'package:myride/repository/driverprofile_repo.dart';
import 'package:myride/view/for_driver/vehicle_info/vehicle_info.dart';

class DriveProfileViewModel extends ChangeNotifier {
  final _driverProfileRepo = DriverProfileRepo();

  bool loading = false;

  late DriverProfile driverProfile;
  DriverProfile? currdriverProfile;

  makeProfile(BuildContext context) async {
    loading = true;
    var bodyTosend = driverProfile.toJson();
    log("PARAMS TO SEND $bodyTosend");
    try {
      final response = await _driverProfileRepo.makeProfile(
        context,
        bodyTosend,
      );
      log("RESPONSE $response");
      Future.delayed(Duration(seconds: 2), () {
        loading = false;
        currdriverProfile = DriverProfile.fromJson(response);
        notifyListeners();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const VehicleInfo();
            },
          ),
        );
      });
    } catch (e) {
      log('Erroer $e');
    }
  }

  updateProfile(BuildContext context, bodyTosend) async {
    loading = true;
    log("PARAMS TO SEND $bodyTosend");
    try {
      final response = await _driverProfileRepo.updateProfile(
        context,
        bodyTosend,
      );
      log("RESPONSE Update $response");
      loading = false;
      currdriverProfile = DriverProfile.fromJson(response);
      notifyListeners();
    } catch (e) {
      log('Erroer $e');
    }
  }

  Future<void> getProfile(BuildContext context) async {
    loading = true;
    try {
      final response = await _driverProfileRepo.getProfile(context);
      log("RESPONSE $response");
      loading = false;
      currdriverProfile = DriverProfile.fromJson(response);
      notifyListeners();
    } catch (e) {
      log('Erroer $e');
    }
  }
}
