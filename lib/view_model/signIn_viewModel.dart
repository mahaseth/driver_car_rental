// ignore_for_file: use_build_context_synchronously, prefer_interpolation_to_compose_strings, file_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:myride/repository/signin_repo.dart';
import 'package:myride/utils/utils.dart';
import 'package:myride/view/for_car_owner/welocme_owner/welcome_owner.dart';
import 'package:myride/view/for_driver/driver-details/driver-details.dart';
import 'package:myride/view/for_driver/verify/otp.dart';
import 'package:myride/view_model/driverprofile_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInViewModel extends ChangeNotifier {
  final _signInRepo = SignInRepo();

  bool loading = false;

  // String phone = '9749880501';
  String phone = '';

  final _mobileNumberController = TextEditingController();

  get mobileNumberController => _mobileNumberController;

  static String token = '';

  registerDriver(BuildContext context) async {
    if (_mobileNumberController.text.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid Phone Number"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 1),
        ),
      );
    } else {
      loading = true;
      phone = _mobileNumberController.text;
      var bodyTosend = {
        "phone": _mobileNumberController.text //,"referrer":"AZUVQ"
      };
      log("PARAMS TO SEND $bodyTosend");
      try {
        final response = await _signInRepo.registerDriver(context, bodyTosend);
        log("RESPONSE $response");

        if (response['status']) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return OtpScreen(
                  phoneNumber: _mobileNumberController.text,
                );
              },
            ),
          );
        } else if (response['data'] == "Number already registered") {
          loginDriver(context);
        }
        loading = false;
        notifyListeners();
      } catch (e) {
        log('Erroer $e');
      }
    }
  }

  loginDriver(BuildContext context) async {
    if (_mobileNumberController.text.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid Phone Number"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 1),
        ),
      );
    } else {
      loading = true;
      var bodyTosend = {
        "phone": _mobileNumberController.text //,"referrer":"AZUVQ"
      };
      log("PARAMS TO SEND $bodyTosend");
      try {
        final response = await _signInRepo.loginDriver(context, bodyTosend);
        log("login response $response");

        if (response['status'] == true) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return OtpScreen(
                  phoneNumber: _mobileNumberController.text,
                );
              },
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response['data']),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 1),
            ),
          );
        }

        loading = false;
        notifyListeners();
      } catch (e) {
        log('Erroer $e');
      }
    }
  }

  loginOtpVerificationDriver(BuildContext context, otp) async {
    loading = true;
    var bodyTosend = {
      "phone": _mobileNumberController.text, //,"referrer":"AZUVQ"
      "otp": otp
    };
    log("PARAMS TO SEND $bodyTosend");
    try {
      final response = await _signInRepo.loginDriver(context, bodyTosend);
      log("OTP RESPONSE  $response");

      if (response['status'] == true) {
        debugPrint("Token : " + response['token']);
        token = response['token'];
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString("token", token);
        loading = false;
        notifyListeners();
        DriveProfileViewModel provider =
            Provider.of<DriveProfileViewModel>(context, listen: false);
        provider.getProfile(context);

        if (provider.currDriverProfile == null ||
            provider.currDriverProfile!.firstname == null ||
            provider.currDriverProfile!.firstname!.isEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const DriverDetailsScreen();
              },
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const WelcomeScreenOwner(),
            ),
          );
        }
      } else {
        Utils.showMyDialog("${response['data']}", context);
      }
    } catch (e) {
      log('Erroer $e');
    }
  }
}
