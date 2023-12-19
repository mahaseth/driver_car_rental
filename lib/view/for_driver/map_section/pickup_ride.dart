import 'package:flutter/material.dart';
import 'package:myride/constant/app_text_style.dart';
import 'package:myride/model/location_model.dart';
import 'package:myride/view_model/driverprofile_viewmodel.dart';
import 'package:myride/view_model/trip_viewModel.dart';
import 'package:myride/web_socket/trip_detail_socket.dart';
import 'package:myride/web_socket/trip_socket.dart';
import 'package:provider/provider.dart';

import '../../../web_socket/payment_socket.dart';

class PickUpScreenDriver extends StatefulWidget {
  final Function onSubmit;
  final Map map;

  const PickUpScreenDriver(
      {super.key, required this.onSubmit, required this.map});

  @override
  State<PickUpScreenDriver> createState() => _PickUpScreenDriverState();
}

class _PickUpScreenDriverState extends State<PickUpScreenDriver> {
  String startLocation = "";
  String endingLocation = "";

  @override
  void initState() {
    super.initState();
    LocationData start = parseLocationString(widget.map["source"]);
    LocationData end = parseLocationString(widget.map["destination"]);
    startLocation = start.location;
    endingLocation = end.location;
    startWebSockets();
  }

  void startWebSockets() {
    PaymentWebSocket().webSocketInit(widget.map["trip_id"]);
    PaymentWebSocket().listenSocket(context);

    DriveProfileViewModel provider =
        Provider.of<DriveProfileViewModel>(context, listen: false);

    String url = provider.currDriverProfile?.photoupload ?? "";
    TripSecurityWebSocket().webSocketInit(widget.map["trip_id"], url);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20.0), topLeft: Radius.circular(20.0)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 4,
              color: Colors.grey,
              width: 80,
            ),
            const SizedBox(
              width: 12,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.location_on),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Pick-up",
                          style: TextStyle(color: Color(0xFFC8C7CC)),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            startLocation,
                            style: AppTextStyle.addressText,
                          ),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ],
                ),
                Image.asset('assets/icon/ic_Location.png')
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.location_on),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Drop-off",
                          style: TextStyle(color: Color(0xFFC8C7CC)),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            endingLocation,
                            style: AppTextStyle.addressText,
                          ),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ],
                ),
                Image.asset('assets/icon/ic_Location.png')
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      widget.onSubmit(3);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.44,
                      height: 40,
                      decoration: BoxDecoration(
                          color: const Color(0xFF00B74C),
                          borderRadius: BorderRadius.circular(30)),
                      child: const Center(
                          child: Text(
                        "Arrive Pick Up Location",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () async {
                      await rideSelection();
                      Navigator.of(context).popUntil((route) {
                        if (route is MaterialPageRoute) {
                          debugPrint("Route :- ${route.builder.runtimeType}");
                          String screenName =
                              "(BuildContext) => WelcomeScreenOwner";

                          bool condition =
                              ("${route.builder.runtimeType}" == screenName);
                          return condition;
                        }
                        return false;
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.44,
                      height: 40,
                      decoration: BoxDecoration(
                          color: const Color(0xFFFC1010),
                          borderRadius: BorderRadius.circular(30)),
                      child: const Center(
                          child: Text(
                        "Reject Ride",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future rideSelection() async {
    Map tripData = {
      "status": "REJECTED",
    };
    TripViewModel viewModel =
        Provider.of<TripViewModel>(context, listen: false);
    await viewModel.getCurrentTrip(context, widget.map["trip_id"]);
    await viewModel.editTrip(context, tripData, viewModel.currentTrip!.id);
    TripWebSocket().cancelRideMessage("DRIVER_REJECTED");
  }
}
