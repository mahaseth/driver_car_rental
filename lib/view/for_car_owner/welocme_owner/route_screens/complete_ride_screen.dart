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

  @override
  void initState() {
    super.initState();
    readData();
  }

  void readData() async {
    TripViewModel provider = Provider.of<TripViewModel>(context, listen: false);
    // await provider.getTrips(context);
    List<TripModel> list = provider.tripList;
    setState(() {
      tripList = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return inComplete();
  }

  bool conditionForYourRide() {
    return false;
    // return tripList.isEmpty;
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

  _buildCompletedRide(int index) {
    TripModel tripModel = tripList[index];
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        const Text("My Route",
                            style: AppTextStyle.listCardProfile),
                      ],
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // const Text("Monday 22nd 04:25 PM (+01:00)..."),
                    Text(
                      "Completed",
                      style: TextStyle(color: Appcolors.appgreen),
                    )
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        const Column(
                          children: [Text("Price"), Text("100 rs")],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 2,
                          height: 14,
                          color: Colors.grey,
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    // Row(
                    //   children: [
                    //     const Column(
                    //       children: [Text("Duration"), Text("5h:30 min")],
                    //     ),
                    //     const SizedBox(
                    //       width: 10,
                    //     ),
                    //     Container(
                    //       width: 2,
                    //       height: 14,
                    //       color: Colors.grey,
                    //     )
                    //   ],
                    // ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      children: [
                        Text("Distance"),
                        Text("${tripModel.distance}")
                      ],
                    ),
                  ],
                ),
                const SizedBox(
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
