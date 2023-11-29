import 'package:flutter/material.dart';
import 'package:myride/constant/app_color.dart';
import 'package:myride/constant/app_screen_size.dart';
import 'package:myride/constant/app_text_style.dart';
import 'package:myride/model/driverprofile.dart';
import 'package:myride/model/vehicleinfo.dart';
import 'package:myride/utils/NavigationService.dart';
import 'package:myride/view/for_car_owner/additional/additional.dart';
import 'package:myride/view/for_car_owner/support/support.dart';
import 'package:myride/view/for_car_owner/welocme_owner/view_document_screen.dart';
import 'package:myride/view/for_driver/driver-details/driver-details.dart';
import 'package:myride/view/for_driver/vehicle_info/vehicle_info.dart';
import 'package:myride/view_model/driverprofile_viewmodel.dart';
import 'package:myride/view_model/trip_viewModel.dart';
import 'package:myride/view_model/vehicleinfo_viewmodel.dart';
import 'package:myride/web_socket/trip_socket.dart';
import 'package:provider/provider.dart';

class VehicleScreen extends StatefulWidget {
  const VehicleScreen({super.key});

  @override
  State<VehicleScreen> createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
  List<VehicleInfoo> vehicleList = [];

  VehicleInfoViewModel? _providerVehicle;
  double size = 0;
  double totalDistance = 0;

  void fetchData() {
    TripViewModel tripViewModel =
        Provider.of<TripViewModel>(context, listen: false);
    tripViewModel.getTrips(context);
  }

  void tripReadData() async {
    DriveProfileViewModel provider =
        Provider.of<DriveProfileViewModel>(context, listen: true);
    setState(() {
      size = provider.currDriverProfile?.totalTrip ?? 0.0;
      totalDistance = provider.currDriverProfile?.totalDistanceKm ?? 0.0;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    readData();
  }

  void readData() async {
    _providerVehicle =
        Provider.of<VehicleInfoViewModel>(context, listen: false);
    setState(() {
      _providerVehicle!.loading;
    });

    await _providerVehicle!.vehicleListUser(context);
    setState(() {
      vehicleList = _providerVehicle!.vehicleList;
    });
    debugPrint("${vehicleList.length}");

    if (vehicleList.isNotEmpty) {
      TripWebSocket().webSocketInit(vehicleList[0].cabclass!,
          NavigationService.navigatorKey.currentContext ?? context);
    }
    setState(() {
      _providerVehicle!.loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    tripReadData();
    return vehicleListView();
  }

  showEmptyVehicleList() {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Image.asset('assets/icon/empty_image.png'),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Your Vehicles List',
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text('You don\'t have any vehicles added'),
        const SizedBox(
          height: 10,
        ),
        addVehicleButton(),
      ],
    );
  }

  vehicleListView() {
    if (vehicleList.isEmpty) {
      return showEmptyVehicleList();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Container(
            color: const Color(0xFFF5F5F5),
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 20),
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      color: Colors.white,
                      child: Column(
                        children: [
                          Text(size.toString(),
                              style: AppTextStyle.upperitemtmeemtext),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Complete Trips",
                            style: AppTextStyle.upperitemtmeemspantext,
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 20),
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      color: Colors.white,
                      child: Column(
                        children: [
                          Text(totalDistance.toString(),
                              style: AppTextStyle.upperitemtmeemtext),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Kilometers",
                            style: AppTextStyle.upperitemtmeemspantext,
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 20),
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      color: Colors.white,
                      child: const Column(
                        children: [
                          Text("₹200", style: AppTextStyle.upperitemtmeemtext),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Today’s  Earning",
                            style: AppTextStyle.upperitemtmeemspantext,
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          vehicles(),
        ],
      ),
    );
  }

  DriverProfile? driverProfile;

  addVehicleButton() {
    DriveProfileViewModel? provider =
        Provider.of<DriveProfileViewModel>(context, listen: true);
    setState(() {
      driverProfile = provider.currDriverProfile;
    });

    return SizedBox(
      width: AppSceenSize.getWidth(context) * 0.7,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          if (driverProfile!.firstname == null ||
              driverProfile!.firstname!.isEmpty) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Your profile is incomplete"),
                    content: const Text(
                        "In order to add Vehicles,please fill in the profile details."),
                    actions: [
                      TextButton(
                          onPressed: () async {
                            Navigator.of(context).pop();
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const DriverDetailsScreen();
                                },
                              ),
                            );
                          },
                          child: Text(
                            "Go to Profile",
                            style: TextStyle(color: Appcolors.appgreen),
                          ))
                    ],
                  );
                });

            return;
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const VehicleInfo();
              },
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Appcolors.primaryGreen,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        child: const Text(
          "ADD Vehicle",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  vehicles() {
    return Expanded(
      child: ListView.builder(
        itemCount: vehicleList.length,
        itemBuilder: (context, index) {
          VehicleInfoo vehicleDetail = vehicleList[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/icon/car.png'),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              vehicleDetail.modelText ?? "",
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(vehicleDetail.cabTypeText ?? ""),
                                const SizedBox(
                                  width: 70,
                                ),
                                const Text("₹160/hr"),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text('Veh.No :   ${vehicleDetail.numberplate}'),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Switch(
                            value: vehicleDetail.isactive ?? false,
                            activeColor: Appcolors.appgreen,
                            inactiveTrackColor: Appcolors.lightRed,
                            inactiveThumbColor: Colors.red,
                            onChanged: (value) {
                              setState(() {
                                vehicleDetail.isactive = value;
                              });
                            }),
                        const Icon(Icons.more_vert)
                      ],
                    )
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        carOptionTile(() {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ViewDocumentScreen(
                              vehicleDetail: vehicleDetail,
                              documentType: "insurance_certiifcate",
                            );
                          }));
                        }, "Insurance", "assets/icon/frame1.png"),
                        carOptionTile(() {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ViewDocumentScreen(
                              vehicleDetail: vehicleDetail,
                              documentType: "registration_certiifcate",
                            );
                          }));
                        }, "Registration", "assets/icon/frame2.png"),
                        carOptionTile(() {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const SupportScreen();
                          }));
                        }, "Support", "assets/icon/frame3.png"),
                        carOptionTile(() {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const AdditionalScreen();
                          }));
                        }, "Additional", "assets/icon/frame4.png")
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget carOptionTile(Function onTap, String title, String imageLocation) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Column(
        children: [
          Image.asset(
            imageLocation,
            width: 60,
            height: 60,
          ),
          Text(title)
        ],
      ),
    );
  }
}
