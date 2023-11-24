import 'package:flutter/material.dart';
import 'package:myride/constant/app_text_style.dart';
import 'package:myride/model/trip_model.dart';
import 'package:myride/view/for_car_owner/welocme_owner/ride_details_screen.dart';
import 'package:myride/view_model/trip_viewModel.dart';
import 'package:provider/provider.dart';

import '../../../../constant/app_color.dart';

class YourRideScreen extends StatefulWidget {
  const YourRideScreen({super.key});

  @override
  State<YourRideScreen> createState() => _YourRideScreenState();
}

class _YourRideScreenState extends State<YourRideScreen> {
  int ridesIndex = 1;

  List<TripModel> tripList = [];

  @override
  void initState() {
    super.initState();
  }

  void readData() async {
    TripViewModel provider = Provider.of<TripViewModel>(context, listen: true);

    List<TripModel> list =
        ridesIndex == 1 ? provider.activeTripList : provider.scheduledTripList;
    setState(() {
      tripList = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    readData();
    return yourRideView();
  }

  bool conditionForYourRide() {
    return false;
    // return tripList.isEmpty;
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
          'Your Trip List',
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text('You don\'t have any trip till now.')
      ],
    );
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
                // const Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       "Monday 23rd 04:25 PM...",
                //     ),
                //     Text('Detail')
                //   ],
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
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
                          Text("${tripList.length}",
                              style: AppTextStyle.upperitemtmeemtext),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            "Active Trips",
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
            ],
          ),
          currentRideItem()
        ],
      ),
    );
  }

  String ridesTile() {
    if (ridesIndex == 1) {
      return "Current Rides";
    } else {
      return "Schedule Ride";
    }
  }

  ridesCardView(String title, int index) {
    Color background =
        index == ridesIndex ? Appcolors.primaryGreen : Colors.white;
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
                color: background, borderRadius: BorderRadius.circular(15)),
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

  currentRideItem() {
    return Expanded(
      child: ListView.builder(
        itemCount: tripList.length,
        itemBuilder: (context, index) {
          TripModel tripModel = tripList[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RideDetailScreen(
                      title: ridesTile(),
                      tripData: tripModel
                    ),
                  ));
            },
            child: Container(
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
                      Text(
                        "Ride $index",
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
                      text: TextSpan(
                          style: const TextStyle(color: Colors.black),
                          children: [
                        const TextSpan(
                            text: "Drop Point : ",
                            style: AppTextStyle.dropitmeemtext),
                        TextSpan(
                            text: tripModel.destination,
                            style: AppTextStyle.dropitmeemspantext)
                      ])),
                  const SizedBox(
                    height: 6,
                  ),
                  RichText(
                      text: TextSpan(
                          style: const TextStyle(color: Colors.black),
                          children: [
                        TextSpan(
                            text: "Distance to reach : ${tripModel.distance}",
                            style: AppTextStyle.disitmeemtext),
                        TextSpan(
                            text: "Ride .No :#${tripModel.id}",
                            style: AppTextStyle.disitmeemspantext),
                      ])),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
