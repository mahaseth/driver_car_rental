import 'package:flutter/material.dart';
import 'package:myride/constant/app_color.dart';
import 'package:myride/constant/app_screen_size.dart';
import 'package:myride/constant/app_text_style.dart';
import 'package:myride/view/for_driver/verify/verify.dart';

class HomeScreenOwner extends StatefulWidget {
  const HomeScreenOwner({super.key});

  @override
  State<HomeScreenOwner> createState() => _HomeScreenOwnerState();
}

class _HomeScreenOwnerState extends State<HomeScreenOwner> {
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
                  Text(
                    "My Ride",
                    style: AppTextStyle.logotext,
                  )
                ],
              ),
              SizedBox(
                height: 50,
              ),
              TextButton(
                onPressed: () {
                  // Button click action
                },
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xFF1B6864), // No background color
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                        width: 0, color: Color(0xFF00B74C)), // Border
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                ),
                child: Text(
                  'For Car Owner',
                  style: AppTextStyle.buttontext,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VerifyScreen(),
                      ));
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
  