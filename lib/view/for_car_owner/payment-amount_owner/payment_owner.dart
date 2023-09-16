import 'package:flutter/material.dart';
import 'package:myride/constant/app_text_style.dart';
import 'package:myride/view/for_driver/payment-amount/scan_pay.dart';

class PaymentScreenOwner extends StatefulWidget {
  const PaymentScreenOwner({super.key});

  @override
  State<PaymentScreenOwner> createState() => _PaymentScreenOwnerState();
}

class _PaymentScreenOwnerState extends State<PaymentScreenOwner> {
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
                     Navigator.push(context, MaterialPageRoute(builder: (context) => ScanPayScrren(),));
                  },
                  child: Image.asset("assets/images/Dollar.png")),
                SizedBox(height: 10,),
                Text("Payment Through Cash", style: AppTextStyle.amountitmeemspantext,),
                SizedBox(height: 10,),
                Text("Collect ₹765 from the customer", style: AppTextStyle.amounitmeemtext,)
                ],
            ),
          ),

          SizedBox(height: 20,),

             
         
        ],
      ),
    ),

    Positioned(
      top: MediaQuery.of(context).size.height*0.60,
      width: MediaQuery.of(context).size.width,
      child: Column(
               children: [
                 GestureDetector(
                         onTap: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context) => ScanPayScrren(),));
                         },
                         child: Container(
                           width: MediaQuery.of(context).size.width,  
                           margin: EdgeInsets.symmetric(horizontal: 20),           
                           height: 50,
                           decoration: BoxDecoration(
                  border: Border.all(width: 1,color: Colors.green,style: BorderStyle.solid),
                  color: Color(0xFF00B74C)
                           ),
                          
                         padding: EdgeInsets.all(16),
                         child: Center(
                           child: Text(
                  'Show QR code',
                  style: TextStyle(color: Color(0xFFffffff), ),  
                           ),
                         ),
                         ),
                       ),
               ],
             ),),

    
  ],
),

      // bottomNavigationBar: BottomNavigationBar(
      //   items: <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Image.asset("assets/images/truck-fast.png"),
      //       label: 'Route',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Image.asset("assets/images/map.png"),
      //       label: 'Wallet',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Image.asset("assets/images/user-square.png"),
      //       label: 'Account',
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   onTap: _onItemTapped,
      //   selectedItemColor: Color(0xFF058F2C), // Change this to your desired active color
      // ),
    );
  }
}