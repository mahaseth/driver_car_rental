import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myride/constant/app_color.dart';
import 'package:myride/view/for_car_owner/welocme_owner/account_screen.dart';
import 'package:myride/view/for_car_owner/welocme_owner/route_screens/overview_screen.dart';
import 'package:myride/view/route_map_screen.dart';
import 'package:myride/web_socket/trip_socket.dart';

class WelcomeScreenOwner extends StatefulWidget {
  const WelcomeScreenOwner({super.key});

  @override
  State<WelcomeScreenOwner> createState() => _WelcomeScreenOwnerState();
}

class _WelcomeScreenOwnerState extends State<WelcomeScreenOwner>
    with SingleTickerProviderStateMixin {
  late GoogleMapController _controller;
  CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(22.5726, 88.3639),
    zoom: 14.4746,
  );

  int _selectedIndex = 0;
  bool onDuty = TripWebSocket.isDuty;
  String onOfText = "ON";

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        RouteMapScreen(),
        const DriverOverViewScreen(),
        AccountScreen(onItemTapped: _onItemTapped)
      ][_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/truck-fast.png",
                color: _selectedIndex == 0 ? Appcolors.appgreen : Colors.grey),
            label: 'Route',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.transfer_within_a_station,
                color: _selectedIndex == 1 ? Appcolors.appgreen : Colors.grey),
            label: 'My Trips',
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
