import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myride/constant/app_screen_size.dart';

class EnterOtpScreen extends StatefulWidget {
  const EnterOtpScreen({super.key});

  @override
  State<EnterOtpScreen> createState() => _EnterOtpScreenState();
}

class _EnterOtpScreenState extends State<EnterOtpScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(22.5726, 88.3639),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    // Add a delay to give time for the widget tree to render before showing the bottom sheet.
    // Future.delayed(const Duration(milliseconds: 2), () {
    //   _showBottomSheet(context);
    // });

    KeyboardVisibilityController().onChange.listen((bool visible) {
      setState(() {
        _isKeyboardVisible = visible;
      });
      if (!visible) {
        _moveFocusBack();
      }
    });
  }

  // Create a GlobalKey to access the Scaffold for the drawer.
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<TextEditingController> _otpControllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes =
      List.generate(4, (_) => FocusNode()); // Add this line
  bool _isKeyboardVisible = false;

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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          body: Stack(
            children: [
              SizedBox(
                height: AppSceenSize.getHeight(context),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: AppSceenSize.getWidth(context),
                          height: AppSceenSize.getHeight(context) * 0.64,
                          child: GoogleMap(
                              initialCameraPosition: _kGooglePlex,
                              onMapCreated: (GoogleMapController controller) {
                                _controller.complete(controller);
                              }),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back)),
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.45,
                          right: 10,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    width: 90,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFF0D94CE),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Center(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Image.asset("assets/icon/call.png"),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text(
                                            "Call",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    )),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    width: 90,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFF0C414),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: const Center(
                                        child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Icon(Icons.chat_outlined),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Chat",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // GestureDetector(
                    //   onVerticalDragEnd: (details) {
                    //     // Detect the swipe up gesture and show the bottom sheet.
                    //     if (details.primaryVelocity! < 0) {
                    //       _showBottomSheet(context);
                    //     }
                    //   },
                    //   child: const Center(
                    //     child: Text(
                    //       'swipe up!',
                    //       style: TextStyle(fontSize: 24.0),
                    //     ),
                    //   ),
                    // ),

                    _buildBottomSection()
                  ],
                ),
              ),
            ],
          )),
    );
  }

  // void _showBottomSheet(BuildContext context) {
  //   showModalBottomSheet(
  //     isDismissible: false,
  //     context: context,
  //     shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
  //     builder: (BuildContext context) {
  //       return

  //     },
  //   );
  // }

  _buildBottomSection() {
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
                    focusNode: _focusNodes[index], // Add this line
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
                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return const EndRideScreen();
                  // }));
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
