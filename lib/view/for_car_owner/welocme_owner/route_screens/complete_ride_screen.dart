import 'package:flutter/material.dart';
import 'package:myride/constant/app_color.dart';
import 'package:myride/constant/app_text_style.dart';
import 'package:myride/model/trip_model.dart';
import 'package:myride/view_model/trip_viewModel.dart';
import 'package:provider/provider.dart';

class CompleteRideScreen extends StatefulWidget {
  const CompleteRideScreen({super.key});

  @override
  State<CompleteRideScreen> createState() => _CompleteRideScreenState();
}

class _CompleteRideScreenState extends State<CompleteRideScreen> {
  List<TripModel> tripList = [];

  double totalDistance = 0;

  @override
  void initState() {
    super.initState();
  }

  void readData() async {
    TripViewModel provider = Provider.of<TripViewModel>(context, listen: true);

    List<TripModel> list = provider.completedTripList;
    setState(() {
      tripList = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    readData();
    return Column(
      children: [yourRideView(), inComplete()],
    );
    ;
  }

  bool conditionForYourRide() {
    return tripList.isNotEmpty;
  }

  inComplete() {
    if (conditionForYourRide()) {
      return _buildCompleteRide();
    }
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

  _buildCompleteRide() {
    return ListView.builder(
        itemCount: tripList.length,
        itemBuilder: (context, index) {
          return _buildCompletedRide(index);
        });
  }

  yourRideView() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Container(
            color: const Color(0xFFF5F5F5),
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
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
                            "Total Trips",
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
                            "Total KMs",
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
                            "Total  Earning",
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
        ],
      ),
    );
  }

  _buildCompletedRide(int index) {
    TripModel tripModel = tripList[index];
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/icon/route.png",
                      width: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Pick-Up"),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text(tripModel.source,
                              style: AppTextStyle.listCardProfile),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Text("Destination"),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text(tripModel.destination,
                              style: AppTextStyle.listCardProfile),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            columnTextField("Price", "Rs. ${tripModel.amount}"),
                            columnTextField(
                                "Distance", "${tripModel.distance} KM"),
                            columnTextField("Cab-Type",
                                tripModel.cabData.cabClassText ?? "Cab"),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      tripModel.status,
                      style: TextStyle(
                          color: tripModel.status == "COMPLETED"
                              ? Appcolors.appgreen
                              : Colors.red),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  columnTextField(String key, String value) {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(key), Text(value)],
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          width: 2,
          height: 14,
          color: Colors.grey,
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
