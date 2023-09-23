import 'package:flutter/material.dart';
import 'package:myride/view/for_driver/payment-amount/payment.dart';
import 'package:myride/view/for_driver/profile/profile.dart';

import '../profile_owner/map_section/route_screen.dart';

class WaitingForApprovalOwner extends StatefulWidget {
  const WaitingForApprovalOwner({super.key});

  @override
  State<WaitingForApprovalOwner> createState() =>
      _WaitingForApprovalOwnerState();
}

class _WaitingForApprovalOwnerState extends State<WaitingForApprovalOwner> {
  int _selectedIndex = 2;

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
        selectedItemColor:
            const Color(0xFF058F2C), // Change this to your desired active color
      ),
    );
  }
}
