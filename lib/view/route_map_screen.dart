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

  void changeMapPosition() async {
    Position position = await LocationServices().currentLocation();
    _kGooglePlex = CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 14.4746,
    );
    _controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

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
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                      compassEnabled: false,
                      onMapCreated: (GoogleMapController controller) {
                        _controller = controller;
                        changeMapPosition();
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
                          onPressed: changeMapPosition,
                          icon: const Icon(Icons.my_location_outlined)),
                    )),
                Positioned(
                    bottom: 50,
                    left: 25,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(5.0),
                      child: IconButton(
                          onPressed: () {
                            debugPrint("Button Clicked");
                            // Map socketData = {
                            //   "source":
                            //       "307 b, Sector 10, Steel Plant Twp, Visakhapatnam, Pedamadaka, Andhra Pradesh 530032, India#17.6476978#17.6476978",
                            //   "destination":
                            //       "Kurmannapalem, Visakhapatnam, Andhra Pradesh, India#17.6905906#17.6905906",
                            //   "phone_number": "8309057182",
                            //   "name": "Aryna",
                            //   "trip_id": 510,
                            //   "customer_id": 154,
                            //   "status": "BOOKED",
                            // };
                            // TripWebSocket().dummyData(socketData);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const BalanceScreen(),
                                ));
                          },
                          icon: const Icon(
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
