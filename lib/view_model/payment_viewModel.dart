import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:myride/model/payment_model.dart';
import 'package:myride/repository/payment_repo.dart';

class PaymentViewModel extends ChangeNotifier {
  final _razorPayRepo = RazorPayRepo();

  List<PaymentModel> paymentList = [];

  Future<void> getPaymentHistory() async {
    try {
      final response = await _razorPayRepo.getHistory();

      log("RESPONSE payment history $response");
      if (response == null) return;

      paymentList = List<PaymentModel>.from(
        response.map(
          (m) => PaymentModel.fromJson(m),
        ),
      );
      paymentList.sort((A, B) {
        return B.createdAt.compareTo(A.createdAt);
      });
      notifyListeners();
    } catch (e) {
      log('Error cab-class $e');
    }
  }
}
