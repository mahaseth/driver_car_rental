import 'package:flutter/material.dart';
import 'package:myride/constant/app_text_style.dart';
import 'package:myride/model/location_model.dart';
import 'package:myride/view_model/driver_status_provider.dart';
import 'package:myride/view_model/trip_viewModel.dart';
import 'package:myride/web_socket/trip_socket.dart';
import 'package:provider/provider.dart';

class EndRideScreenOwner extends StatefulWidget {
  final Function onSubmit;
  final Map map;

  const EndRideScreenOwner(
      {super.key, required this.onSubmit, required this.map});

  @override
  State<EndRideScreenOwner> createState() => _EndRideScreenOwnerState();
}

class _EndRideScreenOwnerState extends State<EndRideScreenOwner> {
  String startLocation = "";
  String endingLocation = "";

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    LocationData start = parseLocationString(widget.map["source"]);
    LocationData end = parseLocationString(widget.map["destination"]);
    startLocation = start.location;
    endingLocation = end.location;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.37,
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
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                        Map tripData = {
                          "status": "COMPLETED",
                        };
                        setState(() {
                          isLoading = true;
                        });
                        TripViewModel viewModel =
                            Provider.of<TripViewModel>(context, listen: false);

                        await viewModel.editTrip(
                            context, tripData, viewModel.currentTrip!.id);
                        TripWebSocket().cancelRideMessage("COMPLETED");
                        setState(() {
                          isLoading = false;
                        });

                        DriverStatusProvider driverStatus =
                            Provider.of<DriverStatusProvider>(context,
                                listen: false);

                        driverStatus.finishRidingStatus(context);
                        widget.onSubmit(5);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.44,
                        height: 40,
                        decoration: BoxDecoration(
                            color: const Color(0xFFF0C414),
                            borderRadius: BorderRadius.circular(30)),
                        child: const Center(
                            child: Text(
                          "End Ride",
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        )),
                      ),
                    ),
                  ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Click Here For Ride Support",
              style: TextStyle(
                decoration: TextDecoration.underline,
              ),
            )
          ],
        ),
      ),
    );
  }
}
