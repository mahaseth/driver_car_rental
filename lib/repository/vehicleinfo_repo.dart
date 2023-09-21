import 'package:myride/view_model/signIn_viewModel.dart';
import 'package:provider/provider.dart';

import '../services/api_services.dart';
import '../utils/utils.dart';

class VehicleInfoRepo {
  final _networkService = NetworkApiService();

  cabType(context) async {
    try {
      final response = await _networkService
          .getGetApiResponse("http://3.109.183.75/cab/cab-type/",
              Provider.of<SignInViewModel>(context, listen: false).token)
          .catchError((error, stackTrace) {
        Utils.showMyDialog(error.toString(), context);
      });
      return response;
    } catch (e) {
      rethrow;
    }
  }

  vehicleMaker(context) async {
    try {
      final response = await _networkService
          .getGetApiResponse("http://3.109.183.75/cab/vehicle-maker/",
              Provider.of<SignInViewModel>(context, listen: false).token)
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
          .getGetApiResponse("http://3.109.183.75/cab/$id/cab-class/",
              Provider.of<SignInViewModel>(context, listen: false).token)
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
          .getGetApiResponse("http://3.109.183.75/cab/$id/vehicle-model/",
              Provider.of<SignInViewModel>(context, listen: false).token)
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
          .postApiResponse("http://3.109.183.75/cab/details/", bodysend,
              Provider.of<SignInViewModel>(context, listen: false).token)
          .catchError((error, stackTrace) {
        Utils.showMyDialog(error.toString(), context);
      });
      return response;
    } catch (e) {
      rethrow;
    }
  }

  updateVehicle(context, bodysend) async {
    try {
      final response = await _networkService
          .patchApiResponse("http://3.109.183.75/cab/details/", bodysend,
              Provider.of<SignInViewModel>(context, listen: false).token)
          .catchError((error, stackTrace) {
        Utils.showMyDialog(error.toString(), context);
      });
      return response;
    } catch (e) {
      rethrow;
    }
  }

  vehicleFetchUser(context) async {
    try {
      final response = await _networkService
          .getGetApiResponse("http://3.109.183.75/cab/details/",
              Provider.of<SignInViewModel>(context, listen: false).token)
          .catchError((error, stackTrace) {
        Utils.showMyDialog(error.toString(), context);
      });
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
