import 'package:flutter/foundation.dart';
import 'package:myride/view_model/signIn_viewModel.dart';
import 'package:provider/provider.dart';

import '../services/api_services.dart';
import '../utils/utils.dart';

class SignInRepo {
  final _networkService = NetworkApiService();

  registerDriver(context, var bodyTosend) async {
    try {
      final response = await _networkService
          .postApiResponse(
              "http://3.109.183.75/account/driver-register/", bodyTosend, "")
          .catchError((error, stackTrace) {
        Utils.showMyDialog(error.toString(), context);
        if (kDebugMode) {
          print(error.toString());
        }
      });
      return response;
    } catch (e) {
      rethrow;
    }
  }

  loginDriver(context, var bodyTosend) async {
    try {
      final response = await _networkService
          .postApiResponse(
              "http://3.109.183.75/account/driver-login/", bodyTosend, "")
          .catchError((error, stackTrace) {
        Utils.showMyDialog(error.toString(), context);
        if (kDebugMode) {
          print(error.toString());
        }
      });

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
