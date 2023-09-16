import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:myride/constant/app_color.dart';
import 'package:myride/constant/app_screen_size.dart';
import 'package:myride/constant/app_text_style.dart';
import 'package:myride/view/for_car_owner/verify_owner/email_owner.dart';
// import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
// import 'package:myride/constant/app_color.dart';
// import 'package:myride/constant/app_screen_size.dart';
// import 'package:myride/constant/app_text_style.dart';
// import 'package:myride/view/for_driver/verify/email.dart';

class OtpScreenOwner extends StatefulWidget {
  const OtpScreenOwner({super.key});

  @override
  State<OtpScreenOwner> createState() => _OtpScreenOwnerState();
}

class _OtpScreenOwnerState extends State<OtpScreenOwner> {
  List<TextEditingController> _otpControllers = List.generate(4, (_) => TextEditingController());
  List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode()); // Add this line
bool _isKeyboardVisible = false;



@override
void initState() {
  super.initState();
  KeyboardVisibilityController().onChange.listen((bool visible) {
    setState(() {
      _isKeyboardVisible = visible;
    });
    if (!visible) {
      _moveFocusBack();
    }
  });
}

void _moveFocusBack() {
  for (int index = _otpControllers.length - 1; index > 0; index--) {
    if (_otpControllers[index].text.isEmpty && _otpControllers[index - 1].text.isNotEmpty) {
      // Add a slight delay before moving the focus
      Future.delayed(Duration(milliseconds: 50), () {
        FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
      });
      break;
    }
  }
}

  void _onOTPDigitChanged(String value, int index) {
    if (value.isNotEmpty && index < _otpControllers.length - 1) {
      if (_otpControllers[index + 1].text.isEmpty) {
        FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Color(0xFF333333),
                    onPressed: () {
           Navigator.pop(context);
          },
        ), centerTitle: true, ),
      body: Stack(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
           SizedBox(height: 30,),

                const Text("OTP Verification", style: AppTextStyle.otpheadingtext,),
                SizedBox(height: 8,),
               const Text("Enter the OTP sent to +229036464851", style: AppTextStyle.otpsubheading,),
                SizedBox(height: 20,),

          Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  _otpControllers.length,
                  (index) => SizedBox(
                    width: 60,
                    child: TextField(
                      controller: _otpControllers[index],
                      focusNode: _focusNodes[index], // Add this line
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      onChanged: (value) => _onOTPDigitChanged(value, index),
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                        counterText: "",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          
                  
            ],),
          ),
 Positioned(height: AppSceenSize.getHeight(context)*0.30, width: AppSceenSize.getWidth(context)*1, bottom: 0, child: Image.asset("assets/images/whitebg.png", fit: BoxFit.cover,)),
           Positioned(bottom: 10, child: Container(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10), width: AppSceenSize.getWidth(context), child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Appcolors.appgreen, // Background color
            onPrimary: Colors.white, // Text color
            padding: EdgeInsets.all(16), // Button padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Button border radius
            ),),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => EmailScreenOwner(),));
          }, child: Text("Continue")))),



         
      ],),
    );
  }
}