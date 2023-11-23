import 'package:myride/view_model/signIn_viewModel.dart';

import '../services/api_services.dart';
import '../utils/utils.dart';

class TripRepo {
  final _networkService = NetworkApiService();

  startTrip(context, var bodyTosend) async {
    try {
      final response = await _networkService
          .postApiResponse("http://3.109.183.75/trip/driver-trip/", bodyTosend,
              SignInViewModel.token)
          .catchError((error, stackTrace) {
        Utils.showMyDialog(error.toString(), context);
      });
      return response;
    } catch (e) {
      rethrow;
    }
  }

  editTrip(context, var bodyTosend, id) async {
    try {
      final response = await _networkService
          .patchApiResponse("http://3.109.183.75/trip/$id/driver-trip/",
              bodyTosend, SignInViewModel.token)
          .catchError((error, stackTrace) {
        Utils.showMyDialog(error.toString(), context);
      });
      return response;
    } catch (e) {
      rethrow;
    }
  }

  getTrips(context) async {
    try {
      final response = await _networkService
          .getGetApiResponse(
              "http://3.109.183.75/trip/driver-trip/", SignInViewModel.token)
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

  getCurrentTrip(context, id) async {
    try {
      final response = await _networkService
          .getGetApiResponse("http://3.109.183.75/trip/$id/driver-trip/",
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
