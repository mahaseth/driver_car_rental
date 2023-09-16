import 'package:flutter/material.dart';
import 'package:myride/constant/app_screen_size.dart';
import 'package:myride/constant/app_text_style.dart';

class MySchedule extends StatefulWidget {
  const MySchedule({super.key});

  @override
  State<MySchedule> createState() => _MyScheduleState();
}

class _MyScheduleState extends State<MySchedule>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _headerText = 'My Schedule';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [_buildTopSection(), _buildTabSection()],
          ),
        ),
      ),
    );
  }

  _buildTopSection() {
    return Stack(
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              "assets/icon/background.png",
              fit: BoxFit.fill,
            )),
        Positioned(
          bottom: 2,
          left: 0,
          right: 0,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back)),
                  Text(
                    _headerText,
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 40,
                  color: Color(0xFF7676803D),
                  child: Flexible(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildTabSection() {
    return Container(
      height: AppSceenSize.getHeight(context) * 0.7,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.green,
              indicatorWeight: 3.0,
              labelColor: Colors.green,
              onTap: (index) {
                if (index == 1) {
                  _headerText = "My Route";
                } else {
                  _headerText = "My Schedule";
                }
                setState(() {});
              },
              tabs: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Schduled Ride"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Completed"),
                )
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // CAR  Tab Content
                _buildScheduleRide(),
                // Bike tab In Tab Content
                _buildCompleteRide(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildScheduleRide() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, right: 10, left: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Column(
                children: const [
                  Icon(Icons.location_on),
                  SizedBox(
                    height: 40,
                  ),
                  Icon(Icons.location_on)
                ],
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Pick-up",
                    style: TextStyle(color: Color(0xFFC8C7CC)),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  const Text(
                    "My current location",
                    // style: AppTextStyle.onboaringSubtitle,
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Drop-off",
                          style: TextStyle(color: Color(0xFFC8C7CC)),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          'newtown',
                          style: AppTextStyle.onboaringSubtitle,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Text("Ride Type:", style: AppTextStyle.rideBold),
                  Text(
                    "Comfort",
                    style: AppTextStyle.rideNormal,
                  )
                ],
              ),
              Row(
                children: [
                  Text("Ride Duration:", style: AppTextStyle.rideBold),
                  Text(
                    "51 mins",
                    style: AppTextStyle.rideNormal,
                  )
                ],
              ),
              Row(
                children: [
                  Text("Trip Distance", style: AppTextStyle.rideBold),
                  Text(
                    "20.3kms",
                    style: AppTextStyle.rideNormal,
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 50,
            decoration: BoxDecoration(
                color: Color(0xFFFC1010),
                borderRadius: BorderRadius.circular(30)),
            child: Center(
                child: Text(
              "Reject ride",
              style: TextStyle(fontSize: 20, color: Colors.white),
            )),
          )
        ],
      ),
    );
  }

  _buildCompleteRide() {
    return ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return _buildCompletedRide();
        });
  }

  _buildCompletedRide() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/icon/route.png",
                          width: 30,
                        ),
                        Text("My Route", style: AppTextStyle.listCardProfile),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [Text("Stop"), Text("100")],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 2,
                          height: 14,
                          color: Colors.grey,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          children: [Text("Duration"), Text("5h:30 min")],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 2,
                          height: 14,
                          color: Colors.grey,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          children: [Text("Distance"), Text("250mi")],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 2,
                          height: 14,
                          color: Colors.grey,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          children: [Text("Assign"), Text("Sandip")],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        // Container(
                        //   width: 2,
                        //   height: 14,
                        //   color: Colors.grey,
                        // )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
