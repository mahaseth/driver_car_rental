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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            SizedBox(
                height: AppSceenSize.getHeight(context) * 0.2,
                width: AppSceenSize.getWidth(context) * 1,
                child: Image.asset("assets/icon/top_bar.png")),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: const Text(
                      "ENTER YOUR MOBILE NUMBER TO CONTINUE",
                      style: AppTextStyle.otpheadingtext,
                    ),
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
            SizedBox(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
                  child: const Text("Proceed"),
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Text(
              "OR LOGIN USING YOUR FAVOURITE SOCIAL ACCOUNT",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            SizedBox(
              height: 25,
            ),
            SizedBox(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                width: AppSceenSize.getWidth(context),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.white, // Text color
                      padding: const EdgeInsets.all(16), // Button padding
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8), // Button border radius
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/icon/google.png"),
                        Text(
                          "Continue With Google",
                          style: AppTextStyle.otpheadingtext,
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
