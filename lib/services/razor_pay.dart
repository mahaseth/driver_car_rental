import 'package:flutter/material.dart';
import 'package:myride/repository/payment_repo.dart';
import 'package:myride/view_model/driverprofile_viewmodel.dart';
import 'package:myride/view_model/payment_viewModel.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPayUtils {
  final _razorpay = Razorpay();
  static BuildContext? context;

  Future initRazorPay(int amt, int id, BuildContext getContext) async {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    Map map = {"amount": amt * 100};
    context = getContext;
    await RazorPayRepo().createOrder(map);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    debugPrint(
        "Payment SuccessFul ${response.paymentId} ${response.orderId} ${response.signature}");
    Map map = {
      "razorpay_payment_id": response.paymentId,
      "razorpay_order_id": response.orderId,
      "razorpay_signature": response.signature,
      "driver_trans_id": RazorPayRepo.transId,
    };

    await RazorPayRepo().verifySignature(map);
    DriveProfileViewModel driverProvider =
        Provider.of<DriveProfileViewModel>(context!, listen: false);

    driverProvider.getProfile(context!);
    PaymentViewModel paymentViewModel =
        Provider.of<PaymentViewModel>(context!, listen: false);
    paymentViewModel.getPaymentHistory();
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
