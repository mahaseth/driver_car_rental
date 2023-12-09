import 'package:flutter/material.dart';
import 'package:myride/utils/utils.dart';

class DriverStatusProvider extends ChangeNotifier {
  bool _isRiding = false;

  bool get isRidingValue => _isRiding;

  startRidingStatus(BuildContext context) async {
    if (_isRiding) {
      context.showErrorSnackBar(message: "Driving is already on a ride");
      return;
    }
    _isRiding = true;
    notifyListeners();
  }

  finishRidingStatus(BuildContext context) async {
    if (!_isRiding) {
      context.showErrorSnackBar(message: "Not in any ride right now");
      return;
    }
    _isRiding = false;
    notifyListeners();
  }
}
