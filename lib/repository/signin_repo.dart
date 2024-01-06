import 'package:flutter/foundation.dart';

import '../services/api_services.dart';
import '../utils/utils.dart';

class SignInRepo {
  final _networkService = NetworkApiService();

  registerDriver(context, var bodyTosend) async {
    try {
      final response = await _networkService
          .postApiResponse(
              "http://13.200.69.54/account/driver-register/", bodyTosend, "")
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
              "http://13.200.69.54/account/driver-login/", bodyTosend, "")
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
