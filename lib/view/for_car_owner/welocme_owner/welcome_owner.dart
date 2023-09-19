import 'package:flutter/material.dart';
import 'package:myride/constant/app_color.dart';
import 'package:myride/constant/app_screen_size.dart';
import 'package:myride/constant/app_text_style.dart';
import 'package:myride/model/driverprofile.dart';
import 'package:myride/model/vehicleinfo.dart';
import 'package:myride/view/for_car_owner/additional/additional.dart';
import 'package:myride/view/for_car_owner/support/support.dart';
import 'package:myride/view/for_driver/driver-details/driver-details.dart';
import 'package:myride/view/for_driver/driver-details/vehicle_extra_document.dart';
import 'package:myride/view/for_driver/payment-amount/payment.dart';
import 'package:myride/view/for_driver/vehicle_info/vehicle_info.dart';
import 'package:myride/view_model/driverprofile_viewmodel.dart';
import 'package:myride/view_model/vehicleinfo_viewmodel.dart';
import 'package:provider/provider.dart';

class WelcomeScreenOwner extends StatefulWidget {
  const WelcomeScreenOwner({super.key});

  @override
  State<WelcomeScreenOwner> createState() => _WelcomeScreenOwnerState();
}

class _WelcomeScreenOwnerState extends State<WelcomeScreenOwner>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DriverProfile? driverProfile;
  List<VehicleInfoo> vehicleList = [];

  bool onDuty = false;
  int _selectedIndex = 0;
  bool light0 = false;
  DriveProfileViewModel? _provider;
  VehicleInfoViewModel? _providerVehicle;

  int ridesIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
    await _provider!.getProfile(context);
    setState(() {
      driverProfile = _provider!.currdriverProfile;
    });
    debugPrint("Updated values :- $driverProfile");
    if (context.mounted) {
      _providerVehicle =
          Provider.of<VehicleInfoViewModel>(context, listen: false);
      await _providerVehicle!.vehicleListUser(context);
      setState(() {
        vehicleList = _providerVehicle!.vehicleList;
      });
      debugPrint("${vehicleList.length}");
    }
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
    final MaterialStateProperty<Icon?> thumbIcon =
        MaterialStateProperty.resolveWith<Icon?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return const Icon(Icons.check);
        }
        return const Icon(Icons.close);
      },
    );
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
                                      },
                                      child: const Text(
                                        "Welcome, Manas",
                                        style: AppTextStyle.welcommehead,
                                      )),
                                  const Text(
                                    "Kolkata | #837494",
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
            Center(
              child: addVehicleButton(),
            ),
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
                children: [
                  vehicleListView(),
                  yourRideView(),
                  inComplete(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/truck-fast.png"),
            label: 'Route',
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/map.png"),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/user-square.png"),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor:
            const Color(0xFF058F2C), // Change this to your desired active color
      ),
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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Monday 23rd 04:25 PM...",
                    ),
                    Text('Detail')
                  ],
                ),
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
                      child: const Column(
                        children: [
                          Text("100", style: AppTextStyle.upperitemtmeemtext),
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
                      child: const Column(
                        children: [
                          Text("1145.5",
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
                              vehicleDetail.model.toString(),
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(vehicleDetail.cabtype.toString()),
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
                        Column(
                          children: [
                            Image.asset(
                              "assets/icon/frame1.png",
                              width: 60,
                              height: 60,
                            ),
                            const Text("Insurance")
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              "assets/icon/frame2.png",
                              width: 60,
                              height: 60,
                            ),
                            const Text("Registration")
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const SupportScreen();
                            }));
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/icon/frame3.png",
                                width: 60,
                                height: 60,
                              ),
                              const Text("Support")
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const AdditionalScreen();
                            }));
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/icon/frame4.png",
                                width: 60,
                                height: 60,
                              ),
                              const Text("Additional")
                            ],
                          ),
                        ),
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

  bool conditionForYourRide() {
    return false;
  }

  yourRideView() {
    if (conditionForYourRide()) {
      return yourRideEmptyView();
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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Monday 23rd 04:25 PM...",
                    ),
                    Text('Detail')
                  ],
                ),
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
                      child: const Column(
                        children: [
                          Text("100", style: AppTextStyle.upperitemtmeemtext),
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
                      child: const Column(
                        children: [
                          Text("1145.5",
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
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ridesCardView(
                "Current Rides",
                1,
              ),
              ridesCardView(
                "Schedule Rides",
                2,
              ),
              ridesCardView(
                "Share Rides",
                3,
              ),
            ],
          ),
          currentRideItem()
        ],
      ),
    );
  }

  currentRideItem() {
    return Expanded(
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
                border: Border.all(
                    width: 1, color: Colors.green, style: BorderStyle.solid),
                color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset('assets/images/truck-fast.png'),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      "Ride 1",
                      style: AppTextStyle.rideitemhead,
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_right_outlined)
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                RichText(
                    text: const TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                      TextSpan(
                          text: "Drop Point : ",
                          style: AppTextStyle.dropitmeemtext),
                      TextSpan(
                          text: " kolkata 70000001 ,newtown",
                          style: AppTextStyle.dropitmeemspantext)
                    ])),
                const SizedBox(
                  height: 6,
                ),
                RichText(
                    text: const TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                      TextSpan(
                          text: "Distance to reach : 1.2Km ",
                          style: AppTextStyle.disitmeemtext),
                      TextSpan(
                          text: "Timing: 7 mins Ride .No :#0R080",
                          style: AppTextStyle.disitmeemspantext),
                    ])),
              ],
            ),
          );
        },
      ),
    );
  }

  ridesCardView(String title, int index) {
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: () {
          setState(() {
            ridesIndex = index;
          });
        },
        child: Container(
            decoration: BoxDecoration(
                color:
                    index == ridesIndex ? Appcolors.primaryGreen : Colors.white,
                borderRadius: BorderRadius.circular(15)),
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
            margin: const EdgeInsets.symmetric(horizontal: 5),
            height: 100,
            child: Center(
              child: Text(
                title,
                style: AppTextStyle.boldUpperText,
              ),
            )),
      ),
    );
  }

  yourRideEmptyView() {
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
          'Your Cars List',
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
            'Your request is currently being reviewed by our \n                      system administrators.')
      ],
    );
  }

  inComplete() {
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
          'Your Cars List',
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
            'Your request is currently being reviewed by our \n                      system administrators.')
      ],
    );
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

  addVehicleButton() {
    return SizedBox(
      width: AppSceenSize.getWidth(context) * 0.7,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          if (driverProfile!.firstname != null ||
              driverProfile!.firstname!.isEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const VehicleInfo();
                },
              ),
            );
            return;
          }
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
}
