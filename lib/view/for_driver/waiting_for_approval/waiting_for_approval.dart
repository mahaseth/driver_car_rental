import 'package:flutter/material.dart';
import 'package:myride/view/for_car_owner/welocme_owner/welcome_owner.dart';

class WaitingForApproval extends StatefulWidget {
  const WaitingForApproval({super.key});

  @override
  State<WaitingForApproval> createState() => _WaitingForApprovalState();
}

class _WaitingForApprovalState extends State<WaitingForApproval> {
  // int _selectedIndex = 0;
  //
  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }
  //
  // final List _listOfScreens = [
  //   const RouteScreen(),
  //   const PaymentScreen(),
  //   const Profile(),
  // ];
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: _listOfScreens[_selectedIndex],
  //     bottomNavigationBar: BottomNavigationBar(
  //       items: <BottomNavigationBarItem>[
  //         BottomNavigationBarItem(
  //           icon: _selectedIndex == 0
  //               ? Image.asset(
  //                   "assets/images/truck-fast.png",
  //                   color: Colors.green,
  //                 )
  //               : Image.asset(
  //                   "assets/images/truck-fast.png",
  //                   color: Colors.black,
  //                 ),
  //           label: 'Route',
  //         ),
  //         BottomNavigationBarItem(
  //           icon: _selectedIndex == 1
  //               ? Image.asset(
  //                   "assets/images/map.png",
  //                   color: Colors.green,
  //                 )
  //               : Image.asset("assets/images/map.png"),
  //           label: 'Wallet',
  //         ),
  //         BottomNavigationBarItem(
  //           icon: _selectedIndex == 2
  //               ? Image.asset("assets/images/user-square.png",
  //                   color: Colors.green)
  //               : Image.asset(
  //                   "assets/images/user-square.png",
  //                   color: Colors.black,
  //                 ),
  //           label: 'Account',
  //         ),
  //       ],
  //       currentIndex: _selectedIndex,
  //       onTap: _onItemTapped,
  //
  //       selectedItemColor:
  //           const Color(0xFF058F2C), // Change this to your desired active color
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset("assets/images/bg.png")),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.30,
            child: Column(
              children: [
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
                      Image.asset("assets/images/check-circle.1.png"),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Application  Received")
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.70,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Waiting for Approval....."),
                  const SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () {
                      profileUpdate = true;
                      Navigator.of(context).popUntil((route) => false);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WelcomeScreenOwner(),
                          ));
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      width: double.infinity,
                      height: 50,
                      color: const Color(0xFF00B74C),
                      padding: const EdgeInsets.all(16),
                      child: const Center(
                        child: Text(
                          'Go to Home',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
