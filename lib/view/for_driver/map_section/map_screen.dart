import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myride/constant/app_screen_size.dart';
import 'package:myride/services/location_service.dart';
import 'package:myride/view/for_car_owner/welocme_owner/welcome_owner.dart';
import 'package:myride/view/for_driver/map_section/confirming_trip.dart';
import 'package:myride/view/for_driver/map_section/end_ride.dart';
import 'package:myride/view/for_driver/map_section/enter_otp_screen.dart';
import 'package:myride/view/for_driver/map_section/pickup_ride.dart';
import 'package:myride/view/for_driver/map_section/route_screen.dart';

class MapScreenDriver extends StatefulWidget {
  const MapScreenDriver({super.key});

  @override
  State<MapScreenDriver> createState() => _MapScreenDriverState();
}

class _MapScreenDriverState extends State<MapScreenDriver> {
  late GoogleMapController _controller;

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
    readData();
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
                        currentIndex == 0
                            ? Positioned(
                                left: 10,
                                top: 10,
                                child: Container(
                                  height: 70,
                                  width: AppSceenSize.getWidth(context) * 0.95,
                                  color: const Color(0xFF00B74C),
                                  child: const Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      CircleAvatar(
                                        radius: 20,
                                        child: Text(
                                          ' 30\nsec',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
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
      RouteScreenOwner(
        onSubmit: changeIndex,
      ),
      ConfirmTripScreen(
        onSubmit: changeIndex,
      ),
      PickUpScreenDriver(
        onSubmit: changeIndex,
      ),
      EnterOtpScreen(
        onSubmit: changeIndex,
      ),
      EndRideScreenOwner(
        onSubmit: changeIndex,
      ),
    ][currentIndex];
  }

  void changeIndex(val) {
    if (val == 5) {
      Navigator.of(context).popUntil((route) => false);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const WelcomeScreenOwner(),
          ));
      return;
    }
    setState(() {
      height = val == 1 ? 0.85 : 0.55;
      currentIndex = val;
    });
  }
}
