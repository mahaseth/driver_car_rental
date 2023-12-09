import 'package:flutter/material.dart';
import 'package:myride/constant/app_color.dart';
import 'package:myride/constant/app_screen_size.dart';
import 'package:myride/constant/app_text_style.dart';
import 'package:myride/view/for_car_owner/driver-details_owner/driver-details_owner.dart';
// import 'package:myride/constant/app_color.dart';
// import 'package:myride/constant/app_screen_size.dart';
// import 'package:myride/constant/app_text_style.dart';
// import 'package:myride/view/for_driver/driver-details/driver-details.dart';

class EmailScreenOwner extends StatefulWidget {
  const EmailScreenOwner({super.key});

  @override
  State<EmailScreenOwner> createState() => _EmailScreenOwnerState();
}

class _EmailScreenOwnerState extends State<EmailScreenOwner> {
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
          "Email",
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
                  "Enter your email address",
                  style: AppTextStyle.otpheadingtext,
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "Enter your email address",
                  style: AppTextStyle.otpsubheading,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'demoemail@gmail.com',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.blue, // Border color
                        width: 2, // Border width
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.green, // Focused border color
                        width: 2, // Border width
                      ),
                    ),
                    hintText: 'Placeholder text',
                  ),
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
              )),
          Positioned(
              bottom: 10,
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DriverDetailsOwner(),
                            ));
                        print("ccvbvb");
                      },
                      child: const Text("Next ")))),
        ],
      ),
    );
  }
}
