import 'dart:developer';

import 'package:flutter/material.dart';

class ChooseVehicleViewModel extends ChangeNotifier {
  bool _isRequest = false;
  get isRequest => _isRequest;

  setIsRequest(value) {
    _isRequest = value;

    log("IS REQUEST $_isRequest");
    notifyListeners();
  }

  //Selected vehicle index

  int _selectedIndex = -1;
  int get selectedIndex => _selectedIndex;

  bool _isVehicleSelectedView = false;
  bool get isVehicleSelectedView => _isVehicleSelectedView;

  setSelectedIndex(value) {
    _selectedIndex = value;

    setIsRequest(false);

    _isVehicleSelectedView = true;

    log("Is vehicle selected veiw $_isVehicleSelectedView");

    notifyListeners();
  }

  //Book successfull

  bookSuccessFull(BuildContext context) {
    Navigator.pop(context);
    _showBookSuccessfullDialog(context);
  }

  //is Package clicked

  bool _packageTapped = false;
  bool get packageTapped => _packageTapped;

  setpackageTapped(value) {
    Future.delayed(const Duration(seconds: 05), () {
      _isVehicleSelectedView = false;
    });
    _packageTapped = value;
    notifyListeners();

    log("package tapped $_packageTapped");
    notifyListeners();
  }

  final List<bool> _isPackageclicked = [false, false, false];
  List<bool> get isPackageclicked => _isPackageclicked;

  setIsPackageclicked(bool value, int index) {
    _isPackageclicked[index] = !value;
    notifyListeners();
  }

//Dialog showing here

  void _showBookSuccessfullDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              Image.asset("assets/icons/check.png"),
              const SizedBox(
                height: 7,
              ),
              const Text('Booking Successful'),
            ],
          ),
          content: const Text(
              'Your booking has been confirmed\n Driver will pickup you in 2 minutes.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Perform an action here
                _isRequest = false;
                Navigator.of(context).pop();
              },
              child: const Text('Done'),
            ),
          ],
        );
      },
    );
  }
}
