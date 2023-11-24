import 'package:flutter/material.dart';
import 'package:myride/constant/app_color.dart';
import 'package:myride/constant/app_text_style.dart';
import 'package:myride/model/driverprofile.dart';
import 'package:myride/view/for_car_owner/welocme_owner/route_screens/complete_ride_screen.dart';
import 'package:myride/view/for_car_owner/welocme_owner/route_screens/vehicle_screen.dart';
import 'package:myride/view/for_car_owner/welocme_owner/route_screens/your_rides_screen.dart';
import 'package:myride/view/for_driver/payment-amount/payment.dart';
import 'package:myride/view_model/driverprofile_viewmodel.dart';
import 'package:myride/view_model/trip_viewModel.dart';
import 'package:provider/provider.dart';

class DriverOverViewScreen extends StatefulWidget {
  const DriverOverViewScreen({super.key});

  @override
  State<DriverOverViewScreen> createState() => DriverOverViewScreenState();
}

class DriverOverViewScreenState extends State<DriverOverViewScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DriverProfile? driverProfile;
  bool onDuty = false;
  bool light0 = false;
  DriveProfileViewModel? _provider;
  String name = "", location = "", id = "";

  @override
  void initState() {
    super.initState();
    readData();
    _tabController = TabController(length: 3, vsync: this);
  }

  void readData() async {
    _provider = Provider.of<DriveProfileViewModel>(context, listen: false);
    setState(() {
      _provider!.loading;
    });
    TripViewModel tripViewModel =
        Provider.of<TripViewModel>(context, listen: false);
    await tripViewModel.getTrips(context);

    await _provider!.getProfile(context);
    setState(() {
      driverProfile = _provider!.currDriverProfile;
    });
    debugPrint("Updated values :- $driverProfile");

    setState(() {
      _provider!.loading;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (driverProfile != null) {
      name = driverProfile!.firstname ?? "";
      location = driverProfile!.fulladdress ?? "";
      id = driverProfile!.id.toString() ?? "";
    }
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Stack(
                children: [
                  Image.asset("assets/images/headerbg.png"),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back)),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const PaymentScreen(),
                                            ));

                                        // Map map = {
                                        //   "source":
                                        //       "Rispana Pull, Dehradun, Uttarakhand#30.2940767#30.2940767",
                                        //   "destination":
                                        //       "Jogiwala, Dehradun, Uttarakhan#30.2857815#30.2857815",
                                        //   "phone_number": "8449269235",
                                        //   "customer_id": 96,
                                        //   "name": "Aryan",
                                        //   "trip_id": 109,
                                        // };
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             MapScreenDriver(
                                        //               map: map,
                                        //             )));
                                      },
                                      child: Text(
                                        "Welcome, $name",
                                        style: AppTextStyle.welcommehead,
                                      )),
                                  Text(
                                    "$location | #$id",
                                    style: AppTextStyle.welcomesubheading,
                                  )
                                ],
                              ),
                              const Icon(Icons.notifications_none)
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFD2D2D2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                const Expanded(
                                    flex: 3,
                                    child: Center(child: Text("ON DUTY"))),
                                Expanded(
                                  flex: 1,
                                  child: Switch(
                                      value: onDuty,
                                      activeColor: Appcolors.appgreen,
                                      onChanged: (value) {
                                        setState(() {
                                          onDuty = value;
                                        });
                                      }),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            // vehicleList.isNotEmpty
            //     ? Center(
            //         child: addVehicleButton(),
            //       )
            //     : const SizedBox.shrink(),
            const SizedBox(
              height: 10,
            ),
            TabBar(
              controller: _tabController,
              indicatorColor: Colors.green,
              labelColor: Colors.green,
              unselectedLabelColor: Colors.grey,
              tabs: const [
                Tab(
                  text: 'My Vehicles',
                ),
                Tab(
                  text: 'Your Rides',
                ),
                Tab(
                  text: 'Complete',
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  VehicleScreen(),
                  YourRideScreen(),
                  CompleteRideScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
