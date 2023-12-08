import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myride/constant/app_screen_size.dart';
import 'package:myride/services/location_service.dart';
import 'package:myride/view/bank_details/balance_screen.dart';
import 'package:myride/web_socket/trip_socket.dart';

import '../constant/app_color.dart';

class RouteMapScreen extends StatefulWidget {
  const RouteMapScreen({super.key});

  @override
  State<RouteMapScreen> createState() => _RouteMapScreenState();
}

class _RouteMapScreenState extends State<RouteMapScreen> {
  late GoogleMapController _controller;
  CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(22.5726, 88.3639),
    zoom: 14.4746,
  );

  bool onDuty = TripWebSocket.isDuty;
  String onOfText = "ON";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: AppSceenSize.getHeight(context),
            child: Stack(
              children: [
                SizedBox(
                  width: AppSceenSize.getWidth(context),
                  height: AppSceenSize.getHeight(context),
                  child: GoogleMap(
                      initialCameraPosition: _kGooglePlex,
                      myLocationButtonEnabled: false,
                      myLocationEnabled: true,
                      zoomControlsEnabled: false,
                      compassEnabled: false,
                      onMapCreated: (GoogleMapController controller) {
                        _controller = controller;
                      }),
                ),
                Positioned(
                  top: 75,
                  right: 25,
                  left: 25,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: Center(child: Text("$onOfText DUTY"))),
                        Expanded(
                            flex: 1,
                            child: Switch(
                                value: onDuty,
                                activeColor: Appcolors.appgreen,
                                onChanged: (value) {
                                  String text = "ON";
                                  TripWebSocket.isDuty = onDuty;
                                  if (onOfText == "OFF") {
                                    text = "ON";
                                    TripWebSocket().webSocketInit(
                                        TripWebSocket.driverId, context);
                                  } else {
                                    text = "OFF";
                                    TripWebSocket().closeChannel();
                                  }
                                  setState(() {
                                    onDuty = value;
                                    onOfText = text;
                                  });
                                }))
                      ],
                    ),
                  ),
                ),
                Positioned(
                    bottom: 50,
                    right: 25,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(5.0),
                      child: IconButton(
                          onPressed: () async {
                            Position position =
                                await LocationServices().currentLocation();
                            _kGooglePlex = CameraPosition(
                              target:
                                  LatLng(position.latitude, position.longitude),
                              zoom: 14.4746,
                            );
                            _controller.animateCamera(
                                CameraUpdate.newCameraPosition(_kGooglePlex));
                          },
                          icon: Icon(Icons.my_location_outlined)),
                    )),
                Positioned(
                    bottom: 50,
                    left: 25,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(5.0),
                      child: IconButton(
                          onPressed: () {
                            debugPrint("Button Clicked");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const BalanceScreen(),
                                ));
                          },
                          icon: Icon(
                            Icons.monetization_on_rounded,
                            size: 50,
                            color: Colors.amber,
                          )),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
