import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myride/constant/app_screen_size.dart';
import 'package:myride/model/location_model.dart';
import 'package:myride/services/location_service.dart';
import 'package:myride/view/for_driver/chat/chat_screen.dart';
import 'package:myride/view/for_driver/map_section/confirming_trip.dart';
import 'package:myride/view/for_driver/map_section/end_ride.dart';
import 'package:myride/view/for_driver/map_section/enter_otp_screen.dart';
import 'package:myride/view/for_driver/map_section/payment_receive_screen.dart';
import 'package:myride/view/for_driver/map_section/pickup_ride.dart';
import 'package:myride/view/for_driver/map_section/trip_accpet_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class MapScreenDriver extends StatefulWidget {
  final Map map;
  final int screenIndex;

  const MapScreenDriver(
      {super.key, required this.map, required this.screenIndex});

  @override
  State<MapScreenDriver> createState() => _MapScreenDriverState();
}

class _MapScreenDriverState extends State<MapScreenDriver> {
  late GoogleMapController _controller;
  int timing = 30;

  late Position position;
  CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(22.5726, 88.3639),
    zoom: 14.4746,
  );

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int currentIndex = 0;
  double height = 0.55;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.screenIndex;
    readData();
    KeyboardVisibilityController().onChange.listen((bool visible) {
      setState(() {
        height = visible ? 0.25 : 0.55;
      });
    });
    decreaseTiming();
  }

  void decreaseTiming() async {
    for (int i = 0; i < 30; i++) {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        timing--;
      });
    }
    if (context.mounted && currentIndex == 0) {
      Navigator.of(context).popUntil((route) {
        if (route is MaterialPageRoute) {
          debugPrint("Route :- ${route.builder.runtimeType}");
          String screenName = "(BuildContext) => WelcomeScreenOwner";

          bool condition = ("${route.builder.runtimeType}" == screenName);
          return condition;
        }
        return false;
      });
    }
  }

  void readData() async {
    await LocationServices().checkPermissions();

    position = await LocationServices().currentLocation();
    _kGooglePlex = CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 14.4746,
    );

    _controller.moveCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint("Dispose");
    _controller.dispose();
  }

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
                          height: AppSceenSize.getHeight(context) * height,
                          child: GoogleMap(
                              initialCameraPosition: _kGooglePlex,
                              myLocationButtonEnabled: true,
                              myLocationEnabled: true,
                              zoomControlsEnabled: false,
                              onMapCreated: (GoogleMapController controller) {
                                _controller = controller;
                              }),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.38,
                          right: 10,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    Uri phoneNumber = Uri.parse(
                                        'tel:${widget.map["phone_number"]}');
                                    await launchUrl(phoneNumber);
                                  },
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
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ChatScreen(map: widget.map)));
                                  },
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
                        if (currentIndex != 0)
                          Positioned(
                            top: MediaQuery.of(context).size.height * 0.38,
                            left: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () async {
                                  LocationData locationData;
                                  if (currentIndex == 4) {
                                    locationData = parseLocationString(
                                        widget.map["destination"]);
                                  } else {
                                    locationData = parseLocationString(
                                        widget.map["source"]);
                                  }
                                  double destinationLat = locationData.latitude;
                                  double destinationLng =
                                      locationData.longitude;

                                  debugPrint(
                                      "Data :- $destinationLat $destinationLng");
                                  final String googleMapUrl =
                                      'https://www.google.com/maps/dir/?api=1&destination=$destinationLat,$destinationLng';

                                  await launchUrl(Uri.parse(googleMapUrl));
                                },
                                child: Container(
                                  width: 175,
                                  height: 40,
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF0D94CE),
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Center(
                                      child: Row(
                                    children: [
                                      const Icon(Icons.pin_drop),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        currentIndex == 4
                                            ? "Go to destination"
                                            : "Go to Pick-Up",
                                        style: const TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      ),
                                    ],
                                  )),
                                ),
                              ),
                            ),
                          ),
                        currentIndex == 0
                            ? Positioned(
                                left: 10,
                                top: 10,
                                child: Container(
                                  height: 70,
                                  width: AppSceenSize.getWidth(context) * 0.95,
                                  color: const Color(0xFF00B74C),
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      CircleAvatar(
                                        radius: 20,
                                        child: Text(
                                          ' $timing\nsec',
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Expanded(
                                          child: Text(
                                              'It will automatically transfer to other driver after time completed.')),
                                    ],
                                  ),
                                ),
                              )
                            : const SizedBox.shrink()
                      ],
                    ),
                    _buildBottomSection()
                  ],
                ),
              ),
            ],
          )),
    );
  }

  _buildBottomSection() {
    return [
      TripAcceptScreen(
        onSubmit: changeIndex,
        map: widget.map,
      ),
      ConfirmTripScreen(
        onSubmit: changeIndex,
      ),
      PickUpScreenDriver(
        onSubmit: changeIndex,
        map: widget.map,
      ),
      EnterOtpScreen(
        onSubmit: changeIndex,
        map: widget.map,
      ),
      EndRideScreenOwner(
        onSubmit: changeIndex,
        map: widget.map,
      ),
    ][currentIndex];
  }

  void changeIndex(val) {
    if (val == 5) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TipsScreen(),
          ));
      return;
    }
    setState(() {
      height = val == 1 ? 0.85 : 0.55;
      currentIndex = val;
    });
  }
}
