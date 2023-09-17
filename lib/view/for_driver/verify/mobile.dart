import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:myride/constant/app_color.dart';
import 'package:myride/constant/app_screen_size.dart';
import 'package:myride/constant/app_text_style.dart';
import 'package:myride/view_model/signIn_viewModel.dart';
import 'package:provider/provider.dart';

class MobileVerify extends StatefulWidget {
  const MobileVerify({super.key});

  @override
  State<MobileVerify> createState() => _MobileVerifyState();
}

class _MobileVerifyState extends State<MobileVerify> {
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
        title: const Text(
          "Phone Number",
          style: TextStyle(color: Color(0xFF333333)),
        ),
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
                  "Enter your mobile number",
                  style: AppTextStyle.otpheadingtext,
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "We will send you the 4 digit verification code",
                  style: AppTextStyle.otpsubheading,
                ),
                const SizedBox(
                  height: 20,
                ),
                IntlPhoneField(
                  controller: _provider!.mobileNumberController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFFDDDDDD),
                      ), // Customize the border color here
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  initialCountryCode: 'IN',
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
                  foregroundColor: Colors.white,
                  backgroundColor: Appcolors.appgreen, // Text color
                  padding: const EdgeInsets.all(16), // Button padding
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(8), // Button border radius
                  ),
                ),
                onPressed: () {
                  _provider!.registerDriver(context);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const OtpScreen(),
                  //   ),
                  // );
                },
                child: const Text("Generate Otp "),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
