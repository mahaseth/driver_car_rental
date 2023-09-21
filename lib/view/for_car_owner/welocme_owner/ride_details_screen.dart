import 'package:flutter/material.dart';
import 'package:myride/constant/app_color.dart';
import 'package:myride/constant/app_screen_size.dart';
import 'package:myride/constant/app_text_style.dart';
import 'package:myride/view/for_driver/map_section/pickup_ride.dart';

class RideDetailScreen extends StatefulWidget {
  final String title;

  const RideDetailScreen({super.key, required this.title});

  @override
  State<RideDetailScreen> createState() => _RideDetailScreenState();
}

class _RideDetailScreenState extends State<RideDetailScreen> {
  @override
  Widget build(BuildContext context) {
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
                        child: const Text(
                          "PALLADIUM MALL, 462, a-nuch ate muf, alar a2a, yad, retay 400013, India",
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
                        child: const Text(
                          "PALLADIUM MALL, 462, a-nuch ate muf, alar a2a, yad, retay 400013, India",
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
                      rowTextView("Ride Type:", "Comfort"),
                      rowTextView("Ride Duration:", "51 Mins"),
                      rowTextView("Trip Distance", "20.3 KMs"),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigator.of(context).popUntil((route) => false);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PickRideScreen(),
                          ));
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

  customDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Divider(
        color: Appcolors.appgreen,
      ),
    );
  }

  rowTextView(String title, String value) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
