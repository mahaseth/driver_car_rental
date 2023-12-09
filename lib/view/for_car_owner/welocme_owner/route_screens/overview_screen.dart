import 'package:flutter/material.dart';
import 'package:myride/view/for_car_owner/welocme_owner/route_screens/complete_ride_screen.dart';
import 'package:myride/view/for_car_owner/welocme_owner/route_screens/schedule_rides.dart';
import 'package:myride/view/for_car_owner/welocme_owner/route_screens/your_rides_screen.dart';
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

  @override
  void initState() {
    super.initState();
    readData();
    _tabController = TabController(length: 3, vsync: this);
  }

  void readData() async {
    TripViewModel tripViewModel =
        Provider.of<TripViewModel>(context, listen: false);
    await tripViewModel.getTrips(context);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  text: 'Scheduled Rides',
                ),
                Tab(
                  text: 'Ride History',
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  YourRideScreen(),
                  ScheduledRideScreen(),
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
