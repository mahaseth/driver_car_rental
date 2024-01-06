import 'package:flutter/foundation.dart';
import 'package:myride/view_model/signIn_viewModel.dart';

import '../services/api_services.dart';
import '../utils/utils.dart';

class BankAccountRepo {
  final _networkService = NetworkApiService();

  saveBankDetail(context, map) async {
    try {
      final response = await _networkService
          .postApiResponse("http:/13.200.69.54/account/driver-bank-details/",
              map, SignInViewModel.token)
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

  deleteBankDetail(context, id) async {
    try {
      final response = await _networkService
          .deleteApiResponse(
              "http:/13.200.69.54/account/$id/driver-bank-delete/",
              SignInViewModel.token)
          .catchError((error, stackTrace) {
        debugPrint("Delete Succesfull $error");
        if (kDebugMode) {
          print(error.toString());
        }
      });
      return response;
    } catch (e) {
      rethrow;
    }
  }

  editBankDetail(context, map, id) async {
    try {
      final response = await _networkService
          .putApiResponse("http:/13.200.69.54/account/$id/driver-bank-delete/",
              map, SignInViewModel.token)
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

  getBankDetail(context) async {
    try {
      final response = await _networkService
          .getGetApiResponse("http:/13.200.69.54/account/driver-bank-details/",
              SignInViewModel.token)
          .catchError((error, stackTrace) {
        // Utils.showMyDialog(error.toString(), context);
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
