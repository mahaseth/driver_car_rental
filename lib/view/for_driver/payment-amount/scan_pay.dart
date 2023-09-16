import 'package:flutter/material.dart';
import 'package:myride/constant/app_text_style.dart';
import 'package:myride/view/for_driver/payment-amount/payment_received.dart';

class ScanPayScrren extends StatefulWidget {
  const ScanPayScrren({super.key});

  @override
  State<ScanPayScrren> createState() => _ScanPayScrrenState();
}

class _ScanPayScrrenState extends State<ScanPayScrren> {
   int _selectedIndex = 2;

  

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xFFFAFAFA), elevation: 0, leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Color(0xFF333333),
                    onPressed: () {
           Navigator.pop(context);
          },
        ), centerTitle: true, title: const Text("Payment amount", style: TextStyle(color:Color(0xFF333333) ),),),
      body:Stack(
  children: [   
    
    Positioned(
      top: MediaQuery.of(context).size.height * 0.10,
      child: Column(
        children: [
           Text(" MRP ₹765", style: AppTextStyle.amounttext,),
           SizedBox(height: 30,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: MediaQuery.of(context).size.width*0.94,
            height: 250,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               
                GestureDetector(
                  onTap: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentReceived(),));
                  },
                  child: Image.asset("assets/images/qr-code.png")),
               
                
                SizedBox(height: 10,),
                Text("Scan & Pay", style: AppTextStyle.scanpaytext,)
                ],
            ),
          ),

          SizedBox(height: 20,),

             
         
        ],
      ),
    ),

    

    
  ],
),

      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/truck-fast.png"),
            label: 'Route',
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/map.png"),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/user-square.png"),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Color(0xFF058F2C), // Change this to your desired active color
      ),
    );
  }
}