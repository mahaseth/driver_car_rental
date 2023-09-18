import 'package:flutter/material.dart';
import 'package:myride/constant/app_text_style.dart';
import 'package:myride/view/for_driver/payment-amount/payment.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
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
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.10,
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
                              color: Colors.grey[400],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(),
                                const Text(
                                  "Off Duty",
                                  style: AppTextStyle.welcomesubheading,
                                ),
                                Switch(
                                  value: light0,
                                  onChanged: (bool value) {
                                    setState(() {
                                      light0 = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TabBar(
              controller: _tabController,
              indicatorColor: Colors.green,
              labelColor: Colors.green,
              unselectedLabelColor: Colors.grey,
              tabs: const [
                Tab(
                  text: 'Current Rides',
                ),
                Tab(
                  text: 'Completed Rides',
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  firstTabItem(),
                  firstTabItem(),
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

  firstTabItem() {
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
          currentrideitem(),
        ],
      ),
    );
  }

  currentrideitem() {
    return Expanded(
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
                border: Border.all(
                    width: 1, color: Colors.grey, style: BorderStyle.solid),
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
}
