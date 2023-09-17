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
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFAFA),
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
          "Payment amount",
          style: TextStyle(color: Color(0xFF333333)),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height * 0.10,
            child: Column(
              children: [
                const Text(
                  " MRP ₹765",
                  style: AppTextStyle.amounttext,
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: MediaQuery.of(context).size.width * 0.94,
                  height: 250,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ScanPayScrren(),
                                ));
                          },
                          child: Image.asset("assets/images/Dollar.png")),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Payment Through Cash",
                        style: AppTextStyle.amountitmeemspantext,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Collect ₹765 from the customer",
                        style: AppTextStyle.amounitmeemtext,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.60,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ScanPayScrren(),
                        ));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: Colors.green,
                            style: BorderStyle.solid),
                        color: const Color(0xFF00B74C)),
                    padding: const EdgeInsets.all(16),
                    child: const Center(
                      child: Text(
                        'Show QR code',
                        style: TextStyle(
                          color: Color(0xFFffffff),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
