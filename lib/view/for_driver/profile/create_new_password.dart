import 'package:flutter/material.dart';
import 'package:myride/constant/app_text_style.dart';

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({super.key});

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
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
          Text("Password"),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 40,
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.mail),
                labelText: '************',
                border: OutlineInputBorder(), // This adds the outline border
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Text("Confirm Password"),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 40,
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.mail),
                suffixIcon: Icon(Icons.visibility_off),
                labelText: '*************',
                border: OutlineInputBorder(), // This adds the outline border
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Center(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Must be at least 8 characters. ",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 44,
                decoration: BoxDecoration(
                    color: Color(0xFF00B74C),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                    child: Text(
                  "Reset Password",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
