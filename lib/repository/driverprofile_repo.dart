import 'package:myride/view_model/signIn_viewModel.dart';
import 'package:provider/provider.dart';

import '../services/api_services.dart';
import '../utils/utils.dart';

class DriverProfileRepo {
  final _networkService = NetworkApiService();

  makeProfile(context, var bodyTosend) async {
    try {
      final response = await _networkService
          .putApiResponse(
              "http://3.109.183.75/account/driver-profile/",
              bodyTosend,
              Provider.of<SignInViewModel>(context, listen: false).token)
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
          .patchApiResponse(
              "http://3.109.183.75/account/driver-profile/",
              bodyTosend,
              Provider.of<SignInViewModel>(context, listen: false).token)
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
          .getGetApiResponse("http://3.109.183.75/account/driver-profile/",
              Provider.of<SignInViewModel>(context, listen: false).token)
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
