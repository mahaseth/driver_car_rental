import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:myride/model/customer_model.dart';
import 'package:myride/repository/customer_repo.dart';

class CustomerProfile extends ChangeNotifier {
  final _customerProfileRepo = CustomerProfileRepo();

  CustomerProfileModel? customerProfile;

  Future<void> getProfile(BuildContext context, int id) async {
    try {
      final response = await _customerProfileRepo.getProfile(context, id);
      log("RESPONSE GET $response");

      customerProfile = CustomerProfileModel.fromJson(response);
      notifyListeners();
    } catch (e) {
      log('Erroer $e');
    }
  }
}
