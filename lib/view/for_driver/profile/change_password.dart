import 'package:flutter/material.dart';
import 'package:myride/constant/app_text_style.dart';
import 'package:myride/view/for_driver/profile/create_new_password.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
           _buildTopSection(),
            _buildMessageSection(),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CreateNewPassword();
              }));
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 44,
              decoration: BoxDecoration(
                  color: Color(0xFF00B74C),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                  child: Text(
                "Request Password Change",
                style: TextStyle(fontSize: 14, color: Colors.white),
              )),
            ),
          ),
        ),
      ),
    );
  }

   _buildTopSection() {
    return Stack(
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              "assets/icon/background.png",
              fit: BoxFit.fill,
            )),
        Positioned(
          bottom: 2,
          left: 0,
          right: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back)),
            
            ],
          ),
        ),
      ],
    );
  }


  _buildMessageSection() {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0, left: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text("Change Password", style: AppTextStyle.changePassword),
           SizedBox(
            height: 10,
          ),
          Text(
              "Enter the email address you used when you joined and we’ll send you instructions to reset your password",
              style: AppTextStyle.changePasswordContent),
          SizedBox(
            height: 40,
          ),
          Text("Email"),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 40,
            child: TextField(
              
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.mail),
                labelText: 'Enter your Email',
                border: OutlineInputBorder(), // This adds the outline border
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
          ),
          Center(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "If you remember your password. ",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  TextSpan(
                    text: "Login Here",
                    style: TextStyle(
                      color: Colors.green, // Set the text color to green
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
