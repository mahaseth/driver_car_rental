import 'package:flutter/material.dart';
import 'package:myride/view_model/signIn_viewModel.dart';

import '../services/api_services.dart';

class RazorPayRepo {
  final _networkService = NetworkApiService();
  static String orderId = "";
  static String qrImage = "";
  static int transId = 1;

  createOrder(var bodyTosend) async {
    try {
      debugPrint(bodyTosend.toString());
      final response = await _networkService
          .postApiResponse("http://3.109.183.75/payment/driver-create-order/",
              bodyTosend, SignInViewModel.token)
          .catchError((error, stackTrace) {});
      debugPrint("Response Create order is :- $response");
      orderId = response['order_id'] ?? "";
      transId = response['driver_trans_id'] ?? 1;
      return response;
    } catch (e) {
      rethrow;
    }
  }

  verifySignature(var bodyTosend) async {
    try {
      final response = await _networkService
          .postApiResponse(
              "http://3.109.183.75/payment/driver-verify-signature/",
              bodyTosend,
              SignInViewModel.token)
          .catchError((error, stackTrace) {});

      debugPrint("Response Verify order is :- $response");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  getHistory() async {
    try {
      final response = await _networkService
          .getGetApiResponse(
              "http://3.109.183.75/payment/driver-payment-history/",
              SignInViewModel.token)
          .catchError(
        (error, stackTrace) {
          print("Error in getting payment history $error");
        },
      );
      //DriverProfile driverProfile = DriverProfile.fromJson(response);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  createQrCode(var bodyTosend) async {
    try {
      debugPrint(bodyTosend.toString());
      final response = await _networkService
          .postApiResponse("http://3.109.183.75/payment/create-trip-payment/",
              bodyTosend, SignInViewModel.token)
          .catchError((error, stackTrace) {});
      debugPrint("Response is :- $response");
      if (response != null) {
        orderId = response['order_id'] ?? response['qr_id'] ?? "";
        qrImage = response['image_url'] ?? "";
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }

  verifyQrCode(var bodyTosend) async {
    try {
      final response = await _networkService
          .postApiResponse("http://3.109.183.75/payment/verify-trip-signature/",
              bodyTosend, SignInViewModel.token)
          .catchError((error, stackTrace) {});
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
