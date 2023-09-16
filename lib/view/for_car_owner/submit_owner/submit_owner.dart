// import 'dart:developer';

// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:myride/constant/app_text_style.dart';

import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:myride/constant/app_text_style.dart';
import 'package:myride/view/for_car_owner/sign_owner/sign_owner.dart';

class SubmitScreenOwner extends StatefulWidget {
  const SubmitScreenOwner({super.key});

  @override
  State<SubmitScreenOwner> createState() => _SubmitScreenOwnerState();
}

class _SubmitScreenOwnerState extends State<SubmitScreenOwner> {
  bool _isChecked = true;
  bool _registerChecked = true;
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Image.asset('assets/images/sumbit_icon.png'),
              SizedBox(
                height: 20,
              ),
              Text(
                "Accept My Pride’s Terms & Review Privacy Policy",
                style: AppTextStyle.sumbitheading,
              ),
              SizedBox(
                height: 8,
              ),
              RichText(
                  text: TextSpan(
                      text:
                          "By selecting “I Agree” Below, I have reviewed and agree to the ",
                      style: AppTextStyle.submitsubheading,
                      children: <TextSpan>[
                    TextSpan(
                        text: ' Terms of Use ',
                        style: TextStyle(color: Color(0xFF0A9EEB))),
                    TextSpan(text: 'and acknowledge the '),
                    TextSpan(
                        text: ' Privacy Policy. ',
                        style: TextStyle(color: Color(0xFF0A9EEB))),
                    TextSpan(text: 'I am at least 18 years of age.')
                  ])),
              SizedBox(
                height: 30,
              ),
              DottedBorder(
                color: Color(0xFFdddddd),
                strokeWidth: 1,
                dashPattern: [5, 6],
                child: Container(
                  color: Color(0xFFbF5F5F5),
                  child: Row(
                    children: [
                      Checkbox(
                        activeColor: Colors.black,
                        value: _isChecked,
                        onChanged: (bool? newValue) {
                          setState(() {
                            _isChecked = newValue ?? true;
                          });
                        },
                      ),
                      Text("I Agree")
                    ],
                  ),
                ),
              ),
              Spacer(),
              Text("Do you agree to register for My Ride insurance police"),
              SizedBox(
                height: 50,
              ),
              DottedBorder(
                  strokeWidth: 1,
                  dashPattern: [5, 6],
                  color: Color(0xFFdddddd),
                  child: Container(
                    color: Color(0xFFbF5F5F5),
                    child: Row(
                      children: [
                        Checkbox(
                          activeColor: Colors.black,
                          value: _registerChecked,
                          onChanged: (bool? newValue) {
                            setState(() {
                              _registerChecked = newValue ?? true;
                            });
                          },
                        ),
                        Text("I Agree")
                      ],
                    ),
                  )),
              Spacer(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          log("PRINT NAVIGATUO");

          Navigator.push(context, MaterialPageRoute(builder: (context){
            return SignScreenForOwner();
          }));




               },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: double.infinity,
          height: 50,
          color: Color(0xFF00B74C),
          padding: EdgeInsets.all(16),
          child: Center(
            child: Text(
              'Submit',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
