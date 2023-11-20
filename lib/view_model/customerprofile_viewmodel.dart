// ignore_for_file: use_build_context_synchronously, prefer_interpolation_to_compose_strings, file_names, prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:myride/model/customer_model.dart';
import 'package:myride/repository/customer_repo.dart';

class CustomerProfile extends ChangeNotifier {
  final _customerProfileRepo = CustomerProfileRepo();

  CustomerProfileModel? currCustomerProfile;

  Future<void> getProfile(BuildContext context, int id) async {
    try {
      final response = await _customerProfileRepo.getProfile(context, id);
      log("RESPONSE GET $response");

      currCustomerProfile = CustomerProfileModel.fromJson(response);
      notifyListeners();
    } catch (e) {
      log('Erroer $e');
    }
  }
}
