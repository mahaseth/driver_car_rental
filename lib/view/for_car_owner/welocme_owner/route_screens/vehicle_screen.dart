import 'package:flutter/material.dart';
import 'package:myride/constant/app_color.dart';
import 'package:myride/constant/app_screen_size.dart';
import 'package:myride/constant/app_text_style.dart';
import 'package:myride/model/driverprofile.dart';
import 'package:myride/model/vehicleinfo.dart';
import 'package:myride/utils/NavigationService.dart';
import 'package:myride/utils/image_view.dart';
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
  VehicleInfoo? vehicleModel;

  VehicleInfoViewModel? _providerVehicle;
  double size = 0;
  double totalDistance = 0;

  void fetchData() async {
    TripViewModel tripViewModel =
        Provider.of<TripViewModel>(context, listen: false);
    tripViewModel.getTrips(context);

    _providerVehicle =
        Provider.of<VehicleInfoViewModel>(context, listen: false);
    _providerVehicle!.vehicleListUser(context);
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
  }

  void readData() async {
    _providerVehicle = Provider.of<VehicleInfoViewModel>(context, listen: true);

    setState(() {
      vehicleModel = _providerVehicle!.currentVehicle;
    });

    if (vehicleModel != null) {
      TripWebSocket().webSocketInit(_providerVehicle!.currentVehicle!.cabclass!,
          NavigationService.navigatorKey.currentContext ?? context);
    }
  }

  @override
  Widget build(BuildContext context) {
    tripReadData();
    readData();
    return Scaffold(
      appBar: AppBar(
        title: Text("My Vehicles"),
      ),
      body: vehicleListView(),
    );
  }

  showEmptyVehicleList() {
    return Center(
      child: Column(
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
      ),
    );
  }

  vehicleListView() {
    if (vehicleModel == null) {
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
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
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
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
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
                          Text("₹0", style: AppTextStyle.upperitemtmeemtext),
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
    return
        // Expanded(
        // child: ListView.builder(
        //   itemCount: vehicleList.length,
        //   itemBuilder: (context, index) {
        //     VehicleInfoo vehicleDetail = vehicleList[index];
        //     return
        Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  showImage(vehicleModel?.iconImage ?? ""),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        vehicleModel?.modelText ?? "",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(vehicleModel?.cabTypeText ?? ""),
                          const SizedBox(
                            width: 70,
                          ),
                          Text("₹${vehicleModel?.price ?? 0}/Km"),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text('Veh.No :   ${vehicleModel?.numberplate}'),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  )
                ],
              ),

              Text("${vehicleModel?.cabClassText}"),
              // Row(
              //   children: [
              //     Text("${vehicleModel?.cabClassText}"),
              //     GestureDetector(
              //         onTap: () {
              //           showDialog(
              //               context: context,
              //               builder: (inContext) {
              //                 return AlertDialog(
              //                   title: const Text('Delete Vehicle'),
              //                   content: const Text(
              //                       'Are you sure you want to delete your vehicle'),
              //                   actions: <Widget>[
              //                     TextButton(
              //                       onPressed: () {
              //                         Navigator.of(context).pop();
              //                       },
              //                       child: const Text('Cancel'),
              //                     ),
              //                     TextButton(
              //                       onPressed: () {
              //                         // BankViewModel bankViewModel =
              //                         //     Provider.of<BankViewModel>(
              //                         //         context,
              //                         //         listen: false);
              //                         //
              //                         // bankViewModel.deleteBankDetail(
              //                         //     context,
              //                         //     bankViewModel.bankModel?.id ??
              //                         //         1);
              //                         Navigator.of(context).pop();
              //                       },
              //                       child: const Text('Delete'),
              //                     ),
              //                   ],
              //                 );
              //               });
              //         },
              //         child: Icon(Icons.delete))
              //   ],
              // )
            ],
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey)),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  carOptionTile(() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ViewDocumentScreen(
                        vehicleDetail: vehicleModel,
                        documentType: "insurance_certiifcate",
                      );
                    }));
                  }, "Insurance", "assets/icon/frame1.png"),
                  carOptionTile(() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ViewDocumentScreen(
                        vehicleDetail: vehicleModel,
                        documentType: "registration_certiifcate",
                      );
                    }));
                  }, "Registration", "assets/icon/frame2.png"),
                  carOptionTile(() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ViewDocumentScreen(
                        vehicleDetail: vehicleModel,
                        documentType: "pollution",
                      );
                    }));
                  }, "Pollution", "assets/icon/frame3.png"),
                  carOptionTile(() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ViewDocumentScreen(
                        vehicleDetail: vehicleModel,
                        documentType: "sound",
                      );
                    }));
                  }, "Sound", "assets/icon/frame4.png")
                ],
              ),
            ),
          ),
        ],
      ),
    );
    // },
    // ),
    // );
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
