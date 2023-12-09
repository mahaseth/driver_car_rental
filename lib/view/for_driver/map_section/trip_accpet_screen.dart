import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myride/constant/app_text_style.dart';
import 'package:myride/model/location_model.dart';
import 'package:myride/model/vehicleinfo.dart';
import 'package:myride/utils/distance_utils.dart';
import 'package:myride/utils/utils.dart';
import 'package:myride/view_model/driver_status_provider.dart';
import 'package:myride/view_model/driverprofile_viewmodel.dart';
import 'package:myride/view_model/trip_viewModel.dart';
import 'package:myride/view_model/vehicleinfo_viewmodel.dart';
import 'package:myride/web_socket/trip_socket.dart';
import 'package:provider/provider.dart';

class TripAcceptScreen extends StatefulWidget {
  final Function onSubmit;
  final Map map;

  const TripAcceptScreen(
      {super.key, required this.onSubmit, required this.map});

  @override
  State<TripAcceptScreen> createState() => _TripAcceptScreenState();
}

class _TripAcceptScreenState extends State<TripAcceptScreen> {
  String startLocation = "";
  String endingLocation = "";
  String distance = "0.0 Km";
  String time = "0 Min.";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    readData();
  }

  void setDistance(String distanceText, String timeText) {
    setState(() {
      distance = distanceText;
      time = timeText;
    });
  }

  void readData() async {
    LocationData start = parseLocationString(widget.map["source"]);
    LocationData end = parseLocationString(widget.map["destination"]);
    startLocation = start.location;
    endingLocation = end.location;
    getDistance(LatLng(start.latitude, start.longitude),
        LatLng(end.latitude, end.longitude), setDistance);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20.0), topLeft: Radius.circular(20.0)),
      ),
      padding: const EdgeInsets.all(16.0),
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
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: widget.map["status"] == "SCHEDULED" ? 65 : 40,
              decoration: BoxDecoration(
                  color: const Color(0xFF00B74C),
                  borderRadius: BorderRadius.circular(30)),
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  widget.map["status"] == "SCHEDULED"
                      ? "This is Schedule Ride \n ${widget.map['timing']}"
                      : "This is Current Ride",
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
              )),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Row(
                //   children: [
                //     Text("Ride Type:", style: AppTextStyle.rideBold),
                //     Text(
                //       "Comfort",
                //       style: AppTextStyle.rideNormal,
                //     )
                //   ],
                // ),
                Row(
                  children: [
                    const Text("Ride Duration:", style: AppTextStyle.rideBold),
                    Text(
                      time,
                      style: AppTextStyle.rideNormal,
                    )
                  ],
                ),
                Row(
                  children: [
                    const Text("Trip Distance", style: AppTextStyle.rideBold),
                    Text(
                      distance,
                      style: AppTextStyle.rideNormal,
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                        await rideSelection();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: 40,
                        decoration: BoxDecoration(
                            color: const Color(0xFF00B74C),
                            borderRadius: BorderRadius.circular(30)),
                        child: const Center(
                            child: Text(
                          "Accept Ride",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
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
                        width: MediaQuery.of(context).size.width * 0.3,
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
    setState(() {
      isLoading = true;
    });

    DriveProfileViewModel provider =
        Provider.of<DriveProfileViewModel>(context, listen: false);
    DriverStatusProvider driverStatus =
        Provider.of<DriverStatusProvider>(context, listen: false);
    VehicleInfoViewModel providerVehicle =
        Provider.of<VehicleInfoViewModel>(context, listen: false);

    driverStatus.startRidingStatus(context);
    List<VehicleInfoo> vehicleList = providerVehicle.vehicleList;
    if (provider.currDriverProfile == null || vehicleList.isEmpty) return;

    TripWebSocket().addMessage(provider.currDriverProfile?.id ?? 96,
        providerVehicle.currentVehicle?.id ?? 2, widget.map["status"]);

    Map tripData = {
      "driver": provider.currDriverProfile?.id ?? 96,
      "driver_profile_pic": provider.currDriverProfile?.photoupload ?? "",
      "status": widget.map["status"],
      "cab": providerVehicle.currentVehicle?.id ?? 2,
    };

    TripViewModel viewModel =
        Provider.of<TripViewModel>(context, listen: false);

    await viewModel.getCurrentTrip(context, widget.map["trip_id"]);
    await viewModel.editTrip(context, tripData, viewModel.currentTrip!.id);

    if (viewModel.currentTrip!.status == "SCHEDULED" ||
        viewModel.currentTrip!.status == "BOOKED") {
      context.showSnackBar(message: "This is Scheduled ride");
      Navigator.of(context).pop();
    } else {
      widget.onSubmit(1);
    }
    setState(() {
      isLoading = false;
    });
  }
}
