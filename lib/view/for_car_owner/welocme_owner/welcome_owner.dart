import 'package:flutter/material.dart';
import 'package:myride/constant/app_text_style.dart';
import 'package:myride/view/for_car_owner/additional/additional.dart';
import 'package:myride/view/for_car_owner/support/support.dart';
import 'package:myride/view/for_driver/payment-amount/payment.dart';

class WelcomeScreenOwner extends StatefulWidget {
  const WelcomeScreenOwner({super.key});

  @override
  State<WelcomeScreenOwner> createState() => _WelcomeScreenOwnerState();
}

class _WelcomeScreenOwnerState extends State<WelcomeScreenOwner>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  int _selectedIndex = 0;
  bool light0 = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
                  Container(
                    child: Column(
                      children: [Image.asset("assets/images/headerbg.png")],
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back)),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.10,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      padding: EdgeInsets.symmetric(
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
                                                  PaymentScreen(),
                                            ));
                                      },
                                      child: Text(
                                        "Welcome, Manas",
                                        style: AppTextStyle.welcommehead,
                                      )),
                                  Text(
                                    "Kolkata | #837494",
                                    style: AppTextStyle.welcomesubheading,
                                  )
                                ],
                              ),
                              Icon(Icons.notifications_none)
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
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
                  text: 'In Transit',
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
                  vehicleList(),
                  inTransit(),
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
            Color(0xFF058F2C), // Change this to your desired active color
      ),
    );
  }

  vehicleList() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Container(
            color: Color(0xFFF5F5F5),
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Monday 23rd 04:25 PM...",
                    ),
                    Text('Detail')
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      color: Colors.white,
                      child: Column(
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      color: Colors.white,
                      child: Column(
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      color: Colors.white,
                      child: Column(
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
        itemCount: 2,
        itemBuilder: (context, index) {
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
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'MARUTI SUZUKI',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text("sWIFT vDI"),
                                SizedBox(
                                  width: 70,
                                ),
                                Text("₹160/hr"),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text('Veh.No :   WB 21 DV 1264'),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        )
                      ],
                    ),
                    Icon(Icons.more_vert)
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
                            Text("Insurance")
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              "assets/icon/frame2.png",
                              width: 60,
                              height: 60,
                            ),
                            Text("Registration")
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return SupportScreen();
                            }));
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/icon/frame3.png",
                                width: 60,
                                height: 60,
                              ),
                              Text("Support")
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return AdditionalScreen();
                            }));
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/icon/frame4.png",
                                width: 60,
                                height: 60,
                              ),
                              Text("Additional")
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

  inTransit() {
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        Image.asset('assets/icon/empty_image.png'),
        SizedBox(
          height: 10,
        ),
        Text(
          'Your Cars List',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
            'Your request is currently being reviewed by our \n                      system administrators.')
      ],
    );
  }

  inComplete() {
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        Image.asset('assets/icon/empty_image.png'),
        SizedBox(
          height: 10,
        ),
        Text(
          'Your Cars List',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
            'Your request is currently being reviewed by our \n                      system administrators.')
      ],
    );
  }
}
