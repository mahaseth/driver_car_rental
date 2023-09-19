import 'package:flutter/material.dart';
import 'package:myride/constant/app_color.dart';
import 'package:myride/view/for_car_owner/welocme_owner/account_screen.dart';
import 'package:myride/view/for_car_owner/welocme_owner/route_screen.dart';

class WelcomeScreenOwner extends StatefulWidget {
  const WelcomeScreenOwner({super.key});

  @override
  State<WelcomeScreenOwner> createState() => _WelcomeScreenOwnerState();
}

class _WelcomeScreenOwnerState extends State<WelcomeScreenOwner>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  List _screens = [
    DriverOverViewScreen(),
    DriverOverViewScreen(),
    AccountScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/truck-fast.png",
                color: _selectedIndex == 0 ? Appcolors.appgreen : Colors.grey),
            label: 'Route',
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/map.png",
                color: _selectedIndex == 1 ? Appcolors.appgreen : Colors.grey),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/user-square.png",
                color: _selectedIndex == 2 ? Appcolors.appgreen : Colors.grey),
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
