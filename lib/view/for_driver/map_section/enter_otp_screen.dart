import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class EnterOtpScreen extends StatefulWidget {
  final Function onSubmit;

  const EnterOtpScreen({super.key, required this.onSubmit});

  @override
  State<EnterOtpScreen> createState() => _EnterOtpScreenState();
}

class _EnterOtpScreenState extends State<EnterOtpScreen> {
  final List<TextEditingController> _otpControllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes =
      List.generate(4, (_) => FocusNode()); // Add this line

  void _moveFocusBack() {
    for (int index = _otpControllers.length - 1; index > 0; index--) {
      if (_otpControllers[index].text.isEmpty &&
          _otpControllers[index - 1].text.isNotEmpty) {
        // Add a slight delay before moving the focus
        Future.delayed(const Duration(milliseconds: 50), () {
          FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
        });
        break;
      }
    }
  }

  void _onOTPDigitChanged(String value, int index) {
    if (value.isNotEmpty && index < _otpControllers.length - 1) {
      if (_otpControllers[index + 1].text.isEmpty) {
        FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    KeyboardVisibilityController().onChange.listen((bool visible) {
      if (!visible) {
        _moveFocusBack();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20.0), topLeft: Radius.circular(20.0)),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        color: Colors.grey[200],
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 12,
            ),
            const Text("Enter Ride OTP"),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                _otpControllers.length,
                (index) => SizedBox(
                  width: 40,
                  height: 40,
                  child: TextField(
                    controller: _otpControllers[index],
                    focusNode: _focusNodes[index],
                    // Add this line
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    onChanged: (value) => _onOTPDigitChanged(value, index),
                    style: const TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      counterText: "",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  widget.onSubmit(4);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.44,
                  height: 40,
                  decoration: BoxDecoration(
                      color: const Color(0xFFFC1010),
                      borderRadius: BorderRadius.circular(30)),
                  child: const Center(
                      child: Text(
                    "Start Ride",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  )),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Click Here For Ride Support",
              style: TextStyle(
                decoration: TextDecoration.underline,
              ),
            )
          ],
        ),
      ),
    );
  }
}
