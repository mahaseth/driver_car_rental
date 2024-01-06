import 'package:myride/view_model/signIn_viewModel.dart';

import '../services/api_services.dart';
import '../utils/utils.dart';

class CustomerProfileRepo {
  final _networkService = NetworkApiService();

  Future getProfile(context, id) async {
    try {
      final response = await _networkService
          .getGetApiResponse(
              "http://13.200.69.54/account/$id/get-customer-profile/",
              SignInViewModel.token)
          .catchError(
        (error, stackTrace) {
          Utils.showMyDialog(error.toString(), context);
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
