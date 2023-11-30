// ignore_for_file: use_build_context_synchronously, prefer_interpolation_to_compose_strings, file_names, prefer_const_construcabTypeListors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:myride/model/vehicleinfo.dart';
import 'package:myride/repository/vehicleinfo_repo.dart';
import 'package:myride/view/for_driver/submit/submit.dart';

class VehicleInfoViewModel extends ChangeNotifier {
  final _vehicleInfoRepo = VehicleInfoRepo();

  bool loading = false;

  List<CabType> cabTypeList = [];
  List<VehicleMaker> vehicleMakerList = [];
  List<VehicleModel> vehicleModelList = [];
  List<CabClass> cabClassList = [];
  List<VehicleInfoo> vehicleList = [];

  CabType? vehicleType;
  VehicleMaker? vehicleMaker;
  VehicleModel? currVehicleModel;
  CabClass? currCabClass;
  VehicleInfoo? currentVehicle;

  late VehicleInfoo vi;

  cabType(BuildContext context) async {
    loading = true;
    try {
      final response = await _vehicleInfoRepo.cabType(context);
      log("RESPONSE $response");
      cabTypeList = List<CabType>.from(
        response.map(
          (m) => CabType.fromJson(m),
        ),
      );
      loading = false;
      notifyListeners();
    } catch (e) {
      log('Erroer $e');
    }
  }

  vehicleMakerCall(BuildContext context, int id) async {
    loading = true;
    try {
      final response = await _vehicleInfoRepo.vehicleMaker(context, id);
      log("RESPONSE $response");
      vehicleMakerList = List<VehicleMaker>.from(
        response.map(
          (m) => VehicleMaker.fromJson(m),
        ),
      );
      loading = false;
      notifyListeners();
    } catch (e) {
      log('Erroer $e');
    }
  }

  cabClass(BuildContext context, int id) async {
    loading = true;
    try {
      final response = await _vehicleInfoRepo.cabClass(context, id);
      log("RESPONSE $response");
      cabClassList = List<CabClass>.from(
        response.map(
          (m) => CabClass.fromJson(m),
        ),
      );
      loading = false;
      notifyListeners();
    } catch (e) {
      log('Erroer $e');
    }
  }

  vehicleModel(BuildContext context, int id) async {
    loading = true;
    try {
      final response = await _vehicleInfoRepo.vehicleModel(context, id);
      log("RESPONSE VehicleModel :- $response");
      vehicleModelList = List<VehicleModel>.from(
        response.map(
          (m) => VehicleModel.fromJson(m),
        ),
      );
      loading = false;
      notifyListeners();
    } catch (e) {
      log('Erroer $e');
    }
  }

  Future<List<VehicleInfoo>> vehicleListUser(BuildContext context) async {
    loading = true;
    try {
      final response = await _vehicleInfoRepo.vehicleFetchUser(context);
      log("RESPONSE Vehicle List :- $response");
      vehicleList = List<VehicleInfoo>.from(
        response.map(
          (m) => VehicleInfoo.fromJson(m),
        ),
      );
      currentVehicle = vehicleList[0];
      loading = false;
      notifyListeners();
    } catch (e) {
      log('Erroer Vehicle List $e');
    }
    return vehicleList;
  }

  submit(BuildContext context) async {
    loading = true;
    var bodytoSend = vi.toJson();
    try {
      final response = await _vehicleInfoRepo.submit(context, bodytoSend);
      Future.delayed(Duration(seconds: 2), () {
        loading = false;
        notifyListeners();
        print(response);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const SubmitScreen();
            },
          ),
        );
      });
    } catch (e) {
      log('Erroer $e');
    }
  }

  updateVehicle(BuildContext context, var bodyToSend, int id) async {
    loading = true;
    try {
      final response =
          await _vehicleInfoRepo.updateVehicle(context, bodyToSend, id);
      print("Updateing Vehicle $response");
      currentVehicle = VehicleInfoo.fromJson(response);
      notifyListeners();
    } catch (e) {
      log('Erroer $e');
    }
  }
}
