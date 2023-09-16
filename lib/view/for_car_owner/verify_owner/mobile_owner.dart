import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:myride/constant/app_color.dart';
import 'package:myride/constant/app_screen_size.dart';
import 'package:myride/constant/app_text_style.dart';
import 'package:myride/view/for_car_owner/verify_owner/otp_owner.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';
// import 'package:myride/constant/app_color.dart';
// import 'package:myride/constant/app_screen_size.dart';
// import 'package:myride/constant/app_text_style.dart';
// import 'package:myride/view/for_driver/verify/otp.dart';

class MobileVerifyOwner extends StatefulWidget {
  const MobileVerifyOwner({super.key});

  @override
  State<MobileVerifyOwner> createState() => _MobileVerifyOwnerState();
}

class _MobileVerifyOwnerState extends State<MobileVerifyOwner> {
   final TextEditingController _phoneNumberController = TextEditingController();
  PhoneNumber _selectedPhoneNumber = PhoneNumber(isoCode: 'US');
  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Color(0xFF333333),
                    onPressed: () {
           Navigator.pop(context);
          },
        ), centerTitle: true, title: Text("Phone Number", style: TextStyle(color:Color(0xFF333333) ),),),
      body: Stack(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                SizedBox(height: 30,),

                const Text("Enter your mobile number", style: AppTextStyle.otpheadingtext,),
                SizedBox(height: 8,),
               const Text("We will send you the 4 digit verification code", style: AppTextStyle.otpsubheading,),
                SizedBox(height: 20,),
             IntlPhoneField(
            controller: _phoneNumberController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFDDDDDD)), // Customize the border color here
            borderRadius: BorderRadius.circular(8.0),
                  ),
              
              border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFDDDDDD)),  
            borderRadius: BorderRadius.circular(8.0),
                  ),
            ),
            initialCountryCode: 'IN',
            
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => const OtpScreenOwner(),));
            print("ccvbvb");
          }, child: Text("Generate Otp ")))),

     
      ],),
    );
  }
}