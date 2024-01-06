import 'package:myride/view_model/signIn_viewModel.dart';

import '../services/api_services.dart';
import '../utils/utils.dart';

class DriverProfileRepo {
  final _networkService = NetworkApiService();

  makeProfile(context, var bodyTosend) async {
    try {
      print("Token ${SignInViewModel.token}");
      final response = await _networkService
          .patchApiResponse("http://13.200.69.54/account/driver-profile/",
              bodyTosend, SignInViewModel.token)
          .catchError((error, stackTrace) {
        Utils.showMyDialog(error.toString(), context);
      });
      return response;
    } catch (e) {
      rethrow;
    }
  }

  updateProfile(context, var bodyTosend) async {
    try {
      final response = await _networkService
          .patchApiResponse("http://13.200.69.54/account/driver-profile/",
              bodyTosend, SignInViewModel.token)
          .catchError((error, stackTrace) {
        Utils.showMyDialog(error.toString(), context);
      });
      return response;
    } catch (e) {
      rethrow;
    }
  }

  getProfile(context) async {
    try {
      final response = await _networkService
          .getGetApiResponse("http://13.200.69.54/account/driver-profile/",
              SignInViewModel.token)
          .catchError(
        (error, stackTrace) {
          Utils.showMyDialog(error.toString(), context);
        },
      );
      //DriverProfile driverProfile = DriverProfile.fromJson(response);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
