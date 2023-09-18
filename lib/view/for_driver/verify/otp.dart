import 'package:flutter/material.dart';
import 'package:myride/constant/app_color.dart';
import 'package:myride/constant/app_screen_size.dart';
import 'package:myride/constant/app_text_style.dart';
import 'package:myride/view_model/signIn_viewModel.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpScreen({super.key, required this.phoneNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  OtpFieldController otpController = OtpFieldController();

  String otpText = '';

  @override
  void initState() {
    super.initState();
  }

  SignInViewModel? _provider;

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<SignInViewModel>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: const Color(0xFF333333),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "OTP Verification",
                  style: AppTextStyle.otpsubheading,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Enter the OTP sent to +91${widget.phoneNumber}",
                  style: AppTextStyle.otpheadingtext,
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Center(
                      child: OTPTextField(
                          controller: otpController,
                          length: 4,
                          width: MediaQuery.of(context).size.width,
                          textFieldAlignment: MainAxisAlignment.spaceAround,
                          fieldWidth: 60,
                          fieldStyle: FieldStyle.box,
                          outlineBorderRadius: 10,
                          style: const TextStyle(fontSize: 17),
                          onChanged: (pin) {
                            otpText = pin;
                          },
                          onCompleted: (pin) {
                            otpText = pin;
                          }),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Didn’t receive OTP?"),
                        TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Resend",
                              style: TextStyle(
                                color: Colors.red,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.red,
                                decorationThickness: 2.0,
                              ),
                            ))
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            height: AppSceenSize.getHeight(context) * 0.30,
            width: AppSceenSize.getWidth(context) * 1,
            bottom: 0,
            child: Image.asset(
              "assets/images/whitebg.png",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              width: AppSceenSize.getWidth(context),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Appcolors.appGrey, // Text color
                  padding: const EdgeInsets.all(16), // Button padding
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(8), // Button border radius
                  ),
                ),
                onPressed: () {
                  _provider!.loginOtpVerificationDriver(context, otpText);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const ChooseVehicleScreen(),
                  //   ),
                  // );
                },
                child: const Text("Verify & Continue"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
