import 'package:flutter/material.dart';
import 'package:myride/view_model/signIn_viewModel.dart';

import '../services/api_services.dart';

class RazorPayRepo {
  final _networkService = NetworkApiService();
  static String orderId = "";

  createOrder(var bodyTosend) async {
    try {
      debugPrint(bodyTosend.toString());
      final response = await _networkService
          .postApiResponse("http://3.109.183.75/payment/create-order/",
              bodyTosend, SignInViewModel.token)
          .catchError((error, stackTrace) {});
      debugPrint("Response is :- $response");
      orderId = response['order_id'] ?? "";
      return response;
    } catch (e) {
      rethrow;
    }
  }

  verifySignature(var bodyTosend) async {
    try {
      final response = await _networkService
          .postApiResponse("http://3.109.183.75/payment/verify_signature/",
              bodyTosend, SignInViewModel.token)
          .catchError((error, stackTrace) {});
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
