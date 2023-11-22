import 'package:flutter/material.dart';
import 'package:myride/utils/NavigationService.dart';
import 'package:myride/view/for_driver/home/home.dart';
import 'package:myride/view_model/choose_vehicle_type.dart';
import 'package:myride/view_model/customerprofile_viewmodel.dart';
import 'package:myride/view_model/driverprofile_viewmodel.dart';
import 'package:myride/view_model/message_viewmodel.dart';
import 'package:myride/view_model/signIn_viewModel.dart';
import 'package:myride/view_model/trip_viewModel.dart';
import 'package:myride/view_model/vehicleinfo_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ChooseVehicleViewModel()),
        ChangeNotifierProvider(create: (context) => SignInViewModel()),
        ChangeNotifierProvider(create: (context) => DriveProfileViewModel()),
        ChangeNotifierProvider(create: (context) => VehicleInfoViewModel()),
        ChangeNotifierProvider(create: (context) => CustomerProfile()),
        ChangeNotifierProvider(create: (context) => MessageViewModel()),
        ChangeNotifierProvider(create: (context) => TripViewModel()),
      ],
      child: MaterialApp(
        navigatorKey: NavigationService.navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: const WelcomeScreenOwner(),
        home: const HomePageScreen(),
      ),
    );
  }
}
