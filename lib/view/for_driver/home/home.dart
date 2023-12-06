import 'package:flutter/material.dart';
import 'package:myride/constant/app_color.dart';
import 'package:myride/constant/app_screen_size.dart';
import 'package:myride/constant/app_text_style.dart';
import 'package:myride/view/for_car_owner/welocme_owner/welcome_owner.dart';
import 'package:myride/view/for_driver/verify/mobile.dart';
import 'package:myride/view_model/driverprofile_viewmodel.dart';
import 'package:myride/view_model/signIn_viewModel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // readData();
    gotoNextScreen();
  }

  void readData() async {
    String token = '7687869c4772056d8b2d54a5317b237ff9d79f74';
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("token", token);
  }

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
              Center(
                child: CircularProgressIndicator(
                  color: Colors.blueAccent,
                ),
              ),
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

  void gotoNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey('token')) {
      SignInViewModel.token = sharedPreferences.getString('token') ?? "";

      DriveProfileViewModel provider =
          Provider.of<DriveProfileViewModel>(context, listen: false);
      await provider.getProfile(context);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const WelcomeScreenOwner(),
        ),
      );
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MobileVerify(),
          ));
    }
  }
}
