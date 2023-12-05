import 'package:flutter/material.dart';
import 'package:myride/repository/payment_repo.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPayUtils {
  final _razorpay = Razorpay();

  void initRazorPay(int amt) {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    Map map = {"amount": amt * 100};
    RazorPayRepo().createOrder(map);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    debugPrint("Payment SuccessFul");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    debugPrint("Payment Fail");
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    debugPrint("Wallet Started");
    // Do something when an external wallet is selected
  }

  createOrder(int amt) {
    var options = {
      'key': 'rzp_test_8pj00tLFpPjkIL',
      'amount': amt * 100,
      'name': 'Cab Driver',
      'order_id': RazorPayRepo.orderId,
      'description': 'Recharge',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'}
    };
    _razorpay.open(options);
  }
}
