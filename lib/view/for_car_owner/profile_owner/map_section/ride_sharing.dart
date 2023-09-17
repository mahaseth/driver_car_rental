import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myride/constant/app_screen_size.dart';

class RideSharingScreen extends StatefulWidget {
  const RideSharingScreen({super.key});

  @override
  State<RideSharingScreen> createState() => _RideSharingScreenState();
}

class _RideSharingScreenState extends State<RideSharingScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(22.5726, 88.3639),
    zoom: 14.4746,
  );

  // @override
  // void initState() {
  //   super.initState();
  //   // Add a delay to give time for the widget tree to render before showing the bottom sheet.
  //   Future.delayed(const Duration(milliseconds: 2), () {
  //     _showBottomSheet(context);
  //   });
  // }

  // Create a GlobalKey to access the Scaffold for the drawer.
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          body: Stack(
            children: [
              SizedBox(
                height: AppSceenSize.getHeight(context),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: AppSceenSize.getWidth(context),
                          height: AppSceenSize.getHeight(context) * 0.53,
                          child: GoogleMap(
                              initialCameraPosition: _kGooglePlex,
                              onMapCreated: (GoogleMapController controller) {
                                _controller.complete(controller);
                              }),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back)),
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.38,
                          right: 10,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    width: 90,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFF0D94CE),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Center(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Image.asset("assets/icon/call.png"),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text(
                                            "Call",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    )),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    width: 90,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFF0C414),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: const Center(
                                        child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Icon(Icons.chat_outlined),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Chat",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // GestureDetector(
                    //   onVerticalDragEnd: (details) {
                    //     // Detect the swipe up gesture and show the bottom sheet.
                    //     if (details.primaryVelocity! < 0) {
                    //       _showBottomSheet(context);
                    //     }
                    //   },
                    //   child: const Center(
                    //     child: Text(
                    //       'swipe up!',
                    //       style: TextStyle(fontSize: 24.0),
                    //     ),
                    //   ),
                    // ),
                    _bottomBuildSection()
                  ],
                ),
              ),
            ],
          )),
    );
  }

  _bottomBuildSection() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20.0), topLeft: Radius.circular(20.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Current Rides"),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      height: MediaQuery.of(context).size.height * 0.13,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset("assets/icon/vehicle.png"),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text("Ride 1"),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.33,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFAC682A),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: const Center(
                                        child: Text(
                                      "End Trip",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                color: Colors.black, // Default text color
                                fontSize: 16.0, // Default font size
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Drop Point : ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: 'kolkata 70000001 ,newtown',
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Distance to reach : 1.2Km",
                                style: TextStyle(fontSize: 10),
                              ),
                              Container(
                                height: 10,
                                width: 2,
                                color: Colors.grey,
                              ),
                              const Text("Timing: 7 mins",
                                  style: TextStyle(fontSize: 10)),
                              Container(
                                height: 10,
                                width: 2,
                                color: Colors.grey,
                              ),
                              const Text("Ride.No :#0R080",
                                  style: TextStyle(fontSize: 10)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  // void _showBottomSheet(BuildContext context) {
  //   showModalBottomSheet(
  //     isDismissible: false,
  //     context: context,
  //     shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
  //     builder: (BuildContext context) {
  //       return
  //        Container(
  //         height: MediaQuery.of(context).size.height * 0.4,
  //         padding: const EdgeInsets.all(16.0),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text("Current Rides"),
  //             SizedBox(
  //               height: 10,
  //             ),

  //             SizedBox(
  //                 height: MediaQuery.of(context).size.height * 0.3,
  //               child: ListView.builder(
  //                 itemCount: 2,
  //                 itemBuilder: (context,index){
  //                 return Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: Container(
  //                   padding: const EdgeInsets.only(left: 10, right: 10),
  //                   height: MediaQuery.of(context).size.height * 0.13,
  //                   decoration: BoxDecoration(
  //                       border: Border.all(color: Colors.green),
  //                       borderRadius: BorderRadius.circular(5)),
  //                   child: Column(
  //                     mainAxisSize: MainAxisSize.min,
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           Row(
  //                             children: [
  //                               Image.asset("assets/icon/vehicle.png"),
  //                               SizedBox(
  //                                 width: 10,
  //                               ),
  //                               Text("Ride 1"),
  //                             ],
  //                           ),
  //                           Padding(
  //                             padding: const EdgeInsets.all(8.0),
  //                             child: GestureDetector(
  //                               onTap: () {},
  //                               child: Container(
  //                                 width: MediaQuery.of(context).size.width * 0.33,
  //                                 height: 40,
  //                                 decoration: BoxDecoration(
  //                                     color: Color(0xFFAC682A),
  //                                     borderRadius: BorderRadius.circular(30)),
  //                                 child: Center(
  //                                     child: Text(
  //                                   "End Trip",
  //                                   style: TextStyle(
  //                                       fontSize: 14, color: Colors.white),
  //                                 )),
  //                               ),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                       RichText(
  //                         text: TextSpan(
  //                           style: TextStyle(
  //                             color: Colors.black, // Default text color
  //                             fontSize: 16.0, // Default font size
  //                           ),
  //                           children: <TextSpan>[
  //                             TextSpan(
  //                               text: 'Drop Point : ',
  //                               style: TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                               ),
  //                             ),
  //                             TextSpan(
  //                               text: 'kolkata 70000001 ,newtown',
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         height: 10,
  //                       ),
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           Text(
  //                             "Distance to reach : 1.2Km",
  //                             style: TextStyle(fontSize: 10),
  //                           ),
  //                           Container(
  //                             height: 10,
  //                             width: 2,
  //                             color: Colors.grey,
  //                           ),
  //                           Text("Timing: 7 mins", style: TextStyle(fontSize: 10)),
  //                           Container(
  //                             height: 10,
  //                             width: 2,
  //                             color: Colors.grey,
  //                           ),
  //                           Text("Ride.No :#0R080", style: TextStyle(fontSize: 10)),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //               ),
  //                 );

  //               }),
  //             )

  //           ],
  //         ),
  //       );

  //     },
  //   );
  // }
}
