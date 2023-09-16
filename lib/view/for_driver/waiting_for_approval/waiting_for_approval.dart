import 'package:flutter/material.dart';
import 'package:myride/view/for_driver/map_section/route_screen.dart';
import 'package:myride/view/for_driver/payment-amount/payment.dart';
import 'package:myride/view/for_driver/profile/profile.dart';

class WaitingForApproval extends StatefulWidget {
  const WaitingForApproval({super.key});

  @override
  State<WaitingForApproval> createState() => _WaitingForApprovalState();
}

class _WaitingForApprovalState extends State<WaitingForApproval> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List _listOfScreens = [
    const RouteScreen(),
    const PaymentScreen(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listOfScreens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _selectedIndex == 0
                ? Image.asset(
                    "assets/images/truck-fast.png",
                    color: Colors.green,
                  )
                : Image.asset(
                    "assets/images/truck-fast.png",
                    color: Colors.black,
                  ),
            label: 'Route',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 1
                ? Image.asset(
                    "assets/images/map.png",
                    color: Colors.green,
                  )
                : Image.asset("assets/images/map.png"),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 2
                ? Image.asset("assets/images/user-square.png",
                    color: Colors.green)
                : Image.asset(
                    "assets/images/user-square.png",
                    color: Colors.black,
                  ),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,

        selectedItemColor:
            const Color(0xFF058F2C), // Change this to your desired active color
      ),
    );
  }
}
