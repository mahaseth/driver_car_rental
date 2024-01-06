import 'package:flutter/foundation.dart';
import 'package:myride/view_model/signIn_viewModel.dart';

import '../services/api_services.dart';
import '../utils/utils.dart';

class AdminSupportRepo {
  final _networkService = NetworkApiService();

  sendAdminMessage(context, map) async {
    try {
      final response = await _networkService
          .postApiResponse(
              "http://13.200.69.54/cab-booking-api/message-support/",
              map,
              SignInViewModel.token)
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

  getAdminMessages(context) async {
    try {
      final response = await _networkService
          .getGetApiResponse(
              "http://13.200.69.54/cab-booking-api/message-support/",
              SignInViewModel.token)
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
