import 'package:myride/view_model/signIn_viewModel.dart';

import '../services/api_services.dart';
import '../utils/utils.dart';

class VehicleInfoRepo {
  final _networkService = NetworkApiService();

  cabType(context) async {
    try {
      final response = await _networkService
          .getGetApiResponse(
              "http://13.200.69.54/cab/cab-type/", SignInViewModel.token)
          .catchError((error, stackTrace) {
        Utils.showMyDialog(error.toString(), context);
      });
      return response;
    } catch (e) {
      rethrow;
    }
  }

  vehicleMaker(context, id) async {
    try {
      final response = await _networkService
          .getGetApiResponse("http://13.200.69.54/cab/$id/vehicle-maker/",
              SignInViewModel.token)
          .catchError((error, stackTrace) {
        Utils.showMyDialog(error.toString(), context);
      });
      return response;
    } catch (e) {
      rethrow;
    }
  }

  getVehicleDetail(context, id) async {
    try {
      final response = await _networkService
          .getGetApiResponse(
              "http://13.200.69.54/cab/$id/get-vehicle/", SignInViewModel.token)
          .catchError((error, stackTrace) {
        Utils.showMyDialog(error.toString(), context);
      });
      return response;
    } catch (e) {
      rethrow;
    }
  }

  cabClass(context, int id) async {
    try {
      final response = await _networkService
          .getGetApiResponse(
              "http://13.200.69.54/cab/$id/cab-class/", SignInViewModel.token)
          .catchError((error, stackTrace) {
        Utils.showMyDialog(error.toString(), context);
      });
      return response;
    } catch (e) {
      rethrow;
    }
  }

  vehicleModel(context, int id) async {
    try {
      final response = await _networkService
          .getGetApiResponse("http://13.200.69.54/cab/$id/vehicle-model/",
              SignInViewModel.token)
          .catchError((error, stackTrace) {
        Utils.showMyDialog(error.toString(), context);
      });
      return response;
    } catch (e) {
      rethrow;
    }
  }

  submit(context, bodysend) async {
    try {
      final response = await _networkService
          .postApiResponse("http://13.200.69.54/cab/details/", bodysend,
              SignInViewModel.token)
          .catchError((error, stackTrace) {
        Utils.showMyDialog(error.toString(), context);
      });
      return response;
    } catch (e) {
      rethrow;
    }
  }

  updateVehicle(context, bodysend, int id) async {
    try {
      final response = await _networkService
          .patchApiResponse("http://13.200.69.54/cab/$id/get-vehicle/",
              bodysend, SignInViewModel.token)
          .catchError((error, stackTrace) {
        print("$error");
        // Utils.showMyDialog(error.toString(), context);
      });
      return response;
    } catch (e) {
      rethrow;
    }
  }

  vehicleFetchUser(context) async {
    try {
      final response = await _networkService
          .getGetApiResponse(
              "http://13.200.69.54/cab/details/", SignInViewModel.token)
          .catchError((error, stackTrace) {
        Utils.showMyDialog(error.toString(), context);
      });
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
