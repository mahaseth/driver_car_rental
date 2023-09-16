import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:myride/constant/app_text_style.dart';
import 'package:myride/view/for_car_owner/welocme_owner/welcome_owner.dart';

class SignScreenForOwner extends StatefulWidget {
  const SignScreenForOwner({super.key});

  @override
  State<SignScreenForOwner> createState() => _SignScreenForOwnerState();
}

class _SignScreenForOwnerState extends State<SignScreenForOwner> with SingleTickerProviderStateMixin {
   late TabController _tabController;
   final TextEditingController _phoneNumberController = TextEditingController();
    //  PhoneNumber _selectedPhoneNumber = PhoneNumber(isoCode: 'US');

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50,),
       const Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text("Sign in with", style: AppTextStyle.sumbitheading,),
        ),
         SizedBox(height: 50,),
         TabBar(
              controller: _tabController,
              indicatorColor: Colors.green,
              labelColor: Colors.green,
              unselectedLabelColor: Colors.grey,     
              tabs: const [
                Tab(
                  text: 'Mobile',
                 
                ),
                Tab(
                  text: 'Email',
                  
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                   Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 15,),
                        Text("Mobile Number"),
                       IntlPhoneField(
          controller: _phoneNumberController,
          decoration: InputDecoration(
            
            enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade200), // Customize the border color here
          borderRadius: BorderRadius.circular(8.0),
        ),
            
            border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade200),  
          borderRadius: BorderRadius.circular(8.0),
        ),
          ),
          initialCountryCode: 'IN',
          
        ),
        Text("We will send you the 4 digit sign code"),

  SizedBox(height: 30,),
  GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomeScreenOwner(),));
          },
          child: Container(
             
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(width: 1,color: Colors.green,style: BorderStyle.solid),
              color: Color(0xFF00B74C)
            ),
           
          padding: EdgeInsets.all(16),
          child: Center(
            child: Text(
              'Sign in',
              style: TextStyle(color: Color(0xFFffffff), ),  
            ),
          ),
          ),
        ),

                    ],),
                   ),
                  // Content for the 'Email' tab
                  Center(
                    child: Text('Email Tab Content'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
          onTap: (){

        Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomeScreenOwner(),));
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(width: 2,color: Colors.green,style: BorderStyle.solid)
            ),
           
          padding: EdgeInsets.all(16),
          child: Center(
            child: Text(
              'Register Now',
              style: TextStyle(color: Color(0xFF00B74C), ),  
            ),
          ),
          ),
        ),
    );
     
  }
}