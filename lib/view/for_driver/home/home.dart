import 'package:flutter/material.dart';
import 'package:myride/constant/app_color.dart';
import 'package:myride/constant/app_screen_size.dart';
import 'package:myride/constant/app_text_style.dart';
import 'package:myride/view/for_car_owner/verify_owner/verify_owner.dart';
import 'package:myride/view/for_car_owner/welocme_owner/welcome_owner.dart';
import 'package:myride/view/for_driver/verify/mobile.dart';
import 'package:myride/view_model/signIn_viewModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.mainbg,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logoicon.png'),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "My Ride",
                    style: AppTextStyle.logotext,
                  )
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const VerifyOwnerScreen();
                  }));
                },
                style: TextButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF1B6864), // No background color
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                        width: 0, color: Color(0xFF00B74C)), // Border
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                ),
                child: const Text(
                  'For Car Owner',
                  style: AppTextStyle.buttontext,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () async {
                  SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  if (sharedPreferences.containsKey('token')) {
                    SignInViewModel.token =
                        sharedPreferences.getString('token') ?? "";
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WelcomeScreenOwner(),
                      ),
                    );
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MobileVerify(),
                        ));
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent, // No background color
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                        width: 1, color: Color(0xFF00B74C)), // Border
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                ),
                child: const Text(
                  'Driver Registration',
                  style: AppTextStyle.buttontextone,
                ),
              )
            ],
          ),
          Positioned(
              height: AppSceenSize.getHeight(context) * 0.30,
              width: AppSceenSize.getWidth(context) * 1,
              bottom: 0,
              child: Image.asset(
                "assets/images/bg_style.png",
                fit: BoxFit.cover,
              ))
        ],
      ),
    );
  }
}
