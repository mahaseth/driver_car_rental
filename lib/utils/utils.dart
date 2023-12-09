import 'package:flutter/material.dart';

class Utils {
  static snackBar(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.red, content: Text(message)));
  }

  static showMyDialog(String error, BuildContext context) {
    return showDialog(
      context: context,
      // barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // title: const Text(''),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(error.toString()),
              ],
            ),
          ),
        );
      },
    );
  }

  static show(String error, BuildContext context) {
    return showDialog(
      context: context,
      // barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // title: const Text(''),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(error.toString()),
              ],
            ),
          ),
        );
      },
    );
  }
}

extension ShowSnackBar on BuildContext {
  void showSnackBar({
    required String message,
    Color backgroundColor = Colors.green,
    Color textColor = Colors.white,
  }) {
    ScaffoldMessenger.of(this)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(
          message,
          style: TextStyle(color: textColor),
          maxLines: 2,
        ),
        backgroundColor: backgroundColor,
      ));
  }

  void showErrorSnackBar({required String message}) {
    showSnackBar(message: message, backgroundColor: Colors.red);
  }
}

customDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(
      horizontal: 10,
    ),
    child: const Divider(
      color: Color.fromARGB(255, 206, 204, 204),
    ),
  );
}

String? validator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter some text';
  }
  return null;
}
