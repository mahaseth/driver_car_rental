import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:myride/constant/app_text_style.dart';
import 'package:myride/view/for_driver/waiting_for_approval/waiting_for_approval.dart';

class SubmitScreen extends StatefulWidget {
  const SubmitScreen({super.key});

  @override
  State<SubmitScreen> createState() => _SubmitScreenState();
}

class _SubmitScreenState extends State<SubmitScreen> {
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
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Image.asset('assets/images/sumbit_icon.png'),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Accept My Pride’s Terms & Review Privacy Policy",
                style: AppTextStyle.sumbitheading,
              ),
              const SizedBox(
                height: 8,
              ),
              RichText(
                  text: const TextSpan(
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
              const SizedBox(
                height: 30,
              ),
              DottedBorder(
                color: const Color(0xFFdddddd),
                strokeWidth: 1,
                dashPattern: const [5, 6],
                child: Container(
                  color: const Color(0xffbf5f5f5),
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
                      const Text("I Agree")
                    ],
                  ),
                ),
              ),
              const Spacer(),
              const Text(
                  "Do you agree to register for My Ride insurance police"),
              const SizedBox(
                height: 50,
              ),
              DottedBorder(
                  strokeWidth: 1,
                  dashPattern: const [5, 6],
                  color: const Color(0xFFdddddd),
                  child: Container(
                    color: const Color(0xffbf5f5f5),
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
                        const Text("I Agree")
                      ],
                    ),
                  )),
              const Spacer(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const WaitingForApproval(),
              ));
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: double.infinity,
          height: 50,
          color: const Color(0xFF00B74C),
          padding: const EdgeInsets.all(16),
          child: const Center(
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
