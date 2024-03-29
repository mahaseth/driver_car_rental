import 'package:flutter/material.dart';
import 'package:myride/constant/app_color.dart';
import 'package:myride/model/vehicleinfo.dart';
import 'package:myride/utils/NavigationService.dart';
import 'package:myride/view/for_car_owner/welocme_owner/account_screen.dart';
import 'package:myride/view/for_car_owner/welocme_owner/route_screens/overview_screen.dart';
import 'package:myride/view/route_map_screen.dart';
import 'package:myride/view_model/vehicleinfo_viewmodel.dart';
import 'package:myride/web_socket/trip_socket.dart';
import 'package:provider/provider.dart';

class WelcomeScreenOwner extends StatefulWidget {
  const WelcomeScreenOwner({super.key});

  @override
  State<WelcomeScreenOwner> createState() => _WelcomeScreenOwnerState();
}

class _WelcomeScreenOwnerState extends State<WelcomeScreenOwner>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  bool onDuty = TripWebSocket.isDuty;
  String onOfText = "ON";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startWebSocket();
  }

  void startWebSocket() {
    VehicleInfoViewModel providerVehicle =
        Provider.of<VehicleInfoViewModel>(context, listen: false);

    VehicleInfoo? vehicleModel = providerVehicle.currentVehicle;

    if (vehicleModel != null) {
      TripWebSocket().webSocketInit(providerVehicle.currentVehicle!.cabclass!,
          NavigationService.navigatorKey.currentContext ?? context);
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        const RouteMapScreen(),
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
