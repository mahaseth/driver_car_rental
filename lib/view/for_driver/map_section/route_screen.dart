import 'package:flutter/material.dart';
import 'package:myride/constant/app_text_style.dart';
import 'package:myride/model/location_model.dart';

class RouteScreenOwner extends StatefulWidget {
  final Function onSubmit;
  final Map map;

  const RouteScreenOwner(
      {super.key, required this.onSubmit, required this.map});

  @override
  State<RouteScreenOwner> createState() => _RouteScreenOwnerState();
}

class _RouteScreenOwnerState extends State<RouteScreenOwner> {
  String startLocation = "";
  String endingLocation = "";

  @override
  void initState() {
    super.initState();
    LocationData start = parseLocationString(widget.map["source"]);
    LocationData end = parseLocationString(widget.map["destination"]);
    startLocation = start.location;
    endingLocation = end.location;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20.0), topLeft: Radius.circular(20.0)),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 4,
            color: Colors.grey,
            width: 80,
          ),
          const SizedBox(
            width: 12,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.location_on),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Pick-up",
                        style: TextStyle(color: Color(0xFFC8C7CC)),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          startLocation,
                          style: AppTextStyle.addressText,
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ],
              ),
              Image.asset('assets/icon/ic_Location.png')
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.location_on),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Drop-off",
                        style: TextStyle(color: Color(0xFFC8C7CC)),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          endingLocation,
                          style: AppTextStyle.addressText,
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ],
              ),
              Image.asset('assets/icon/ic_Location.png')
            ],
          ),
          const Row(
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
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    widget.onSubmit(1);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 40,
                    decoration: BoxDecoration(
                        color: const Color(0xFF00B74C),
                        borderRadius: BorderRadius.circular(30)),
                    child: const Center(
                        child: Text(
                      "Accept Ride",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 40,
                    decoration: BoxDecoration(
                        color: const Color(0xFFFC1010),
                        borderRadius: BorderRadius.circular(30)),
                    child: const Center(
                        child: Text(
                      "Reject Ride",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    )),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
