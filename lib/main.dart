import 'package:flutter/material.dart';
import 'package:myride/view/for_driver/home/home.dart';
import 'package:myride/view_model/choose_vehicle_type.dart';
import 'package:myride/view_model/driverprofile_viewmodel.dart';
import 'package:myride/view_model/signIn_viewModel.dart';
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePageScreen(),
      ),
    );
  }
}

//some code part

// Stack(
//   children: [
//     Container(
//         width: double.infinity,
//         height: double.infinity,
//         child: Image.asset("assets/images/bg.png")),
//     Positioned(
//       top: MediaQuery.of(context).size.height * 0.30,
//       child: Column(
//         children: [
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 10),
//             width: MediaQuery.of(context).size.width * 0.94,
//             height: 250,
//             decoration: BoxDecoration(
//               color: Color.fromARGB(255, 255, 255, 255),
//               borderRadius: BorderRadius.circular(20),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.5),
//                   spreadRadius: 2,
//                   blurRadius: 5,
//                   offset: Offset(0, 5),
//                 ),
//               ],
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => SignScreen(),
//                           ));
//                     },
//                     child:
//                         Image.asset("assets/images/check-circle.1.png")),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Text("Application  Received")
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//     Positioned(
//         top: MediaQuery.of(context).size.height * 0.70,
//         width: MediaQuery.of(context).size.width,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text("Waiting for Approval....."),
//           ],
//         ))

//   ],
// ),
