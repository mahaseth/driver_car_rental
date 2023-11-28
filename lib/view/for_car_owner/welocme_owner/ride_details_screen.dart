import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myride/constant/app_color.dart';
import 'package:myride/constant/app_screen_size.dart';
import 'package:myride/constant/app_text_style.dart';
import 'package:myride/model/trip_model.dart';
import 'package:myride/utils/utils.dart';
import 'package:myride/view/for_driver/map_section/map_screen.dart';
import 'package:provider/provider.dart';

import '../../../view_model/customerprofile_viewmodel.dart';

class RideDetailScreen extends StatefulWidget {
  final String title;
  final TripModel tripData;

  const RideDetailScreen(
      {super.key, required this.title, required this.tripData});

  @override
  State<RideDetailScreen> createState() => _RideDetailScreenState();
}

class _RideDetailScreenState extends State<RideDetailScreen> {
  TripModel get tripData => widget.tripData;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.parse(tripData.timing);
    String formattedDate = DateFormat('dd-MM-yyyy , h:mm a').format(now);

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
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 1,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back)),
                        SizedBox(
                          width: AppSceenSize.getWidth(context) * 0.8,
                          child: const Text(
                            "My Rides",
                            style: AppTextStyle.welcommehead,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 25,
                ),
                Image.asset("assets/images/truck-fast.png"),
                const SizedBox(
                  width: 100,
                ),
                Text(
                  widget.title,
                  style: TextStyle(color: Appcolors.appgreen, fontSize: 18),
                  textAlign: TextAlign.start,
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            customDivider(),
            const Center(
              child: Text(
                "Ride 1",
                style: TextStyle(color: Colors.black, fontSize: 18),
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("PICK-UP"),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "assets/icon/pick_up.png",
                        scale: 2,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      SizedBox(
                        width: AppSceenSize.getWidth(context) * 0.7,
                        child: Text(
                          tripData.source,
                          overflow: TextOverflow.clip,
                          style: TextStyle(fontSize: 12),
                        ),
                      )
                    ],
                  ),
                  Divider(
                    height: 25,
                    color: Appcolors.appGrey,
                  ),
                  const Text("DROP-OFF"),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "assets/icon/drop_off.png",
                        scale: 2,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      SizedBox(
                        width: AppSceenSize.getWidth(context) * 0.7,
                        child: Text(
                          tripData.destination,
                          overflow: TextOverflow.clip,
                          style: TextStyle(fontSize: 12),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      rowTextView("Ride Type: ",
                          tripData.cabData.cabTypeText ?? "Vehicle"),
                      rowTextView("Trip Distance: ", tripData.distance),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  rowTextView("Schedule Time: ", formattedDate, fontSize: 15),
                  const SizedBox(
                    height: 10,
                  ),
                  rowTextView("Price: ", "₹ 159", fontSize: 15),
                  const SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () async {
                      CustomerProfile provider =
                          Provider.of<CustomerProfile>(context, listen: false);
                      await provider.getProfile(context, tripData.customer);
                      String sourceAddress =
                          "${tripData.source}#${tripData.sourceLat}#${tripData.sourceLong}";
                      String destinationAddress =
                          "${tripData.destination}#${tripData.destinationLat}#${tripData.destinationLong}";
                      Map socketData = {
                        "source": sourceAddress,
                        "destination": destinationAddress,
                        "phone_number":
                            provider.customerProfile?.phone ?? "100",
                        "name":
                            provider.customerProfile?.firstName ?? "No Name",
                        "trip_id": tripData.id,
                        "customer_id": tripData.customer,
                      };
                      if (context.mounted) {
                        int index = 2;
                        if (tripData.status == "ON_TRIP") index = 4;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MapScreenDriver(
                                map: socketData,
                                screenIndex: index,
                              ),
                            ));
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                          color: const Color(0xFF00B74C),
                          borderRadius: BorderRadius.circular(15)),
                      padding: const EdgeInsets.all(16),
                      child: const Center(
                        child: Text(
                          'Lets Go',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  rowTextView(String title, String value, {double fontSize = 12}) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
        ),
        Text(
          value,
          style: TextStyle(fontSize: fontSize),
        ),
      ],
    );
  }
}
