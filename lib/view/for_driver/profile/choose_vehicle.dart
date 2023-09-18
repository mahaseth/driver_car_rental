import 'package:flutter/material.dart';
import 'package:myride/constant/app_color.dart';
import 'package:myride/constant/app_screen_size.dart';
import 'package:myride/view/for_car_owner/welocme_owner/welcome_owner.dart';
import 'package:myride/view_model/signIn_viewModel.dart';
import 'package:provider/provider.dart';

class ChooseVehicleScreen extends StatefulWidget {
  const ChooseVehicleScreen({super.key});

  @override
  State<ChooseVehicleScreen> createState() => _ChooseVehicleScreenState();
}

class _ChooseVehicleScreenState extends State<ChooseVehicleScreen> {

  @override
  Widget build(BuildContext context) {
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
          "Add Your Vehicle",
          style: TextStyle(color: Color(0xFF333333)),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    selectVehicleWidget("Cab"),
                    const SizedBox(
                      width: 25,
                    ),
                    selectVehicleWidget("Taxi"),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    selectVehicleWidget("Bike"),
                    const SizedBox(
                      width: 25,
                    ),
                    selectVehicleWidget("Auto"),
                  ],
                )
              ],
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
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const WelcomeScreenOwner()));
                },
                child: const Text("Click & Continue"),
              ),
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
        ],
      ),
    );
  }

  Widget selectVehicleWidget(String name) {
    return InkWell(
      onTap: () {
        debugPrint(name);
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const WelcomeScreenOwner()));
      },
      child: Container(
        height: AppSceenSize.getHeight(context) * 0.1,
        width: AppSceenSize.getWidth(context) * 0.35,
        decoration: BoxDecoration(
            color: Appcolors.primaryGreen,
            borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/icon/${name}_choose.png",
                height: 35,
                width: 35,
              ),
              Text(name)
            ],
          ),
        ),
      ),
    );
  }
}
