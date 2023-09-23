import 'package:flutter/material.dart';
import 'package:myride/constant/app_text_style.dart';
import 'package:myride/view/for_car_owner/welocme_owner/welcome_owner.dart';

class EndRideScreenOwner extends StatelessWidget {
  final Function onSubmit;

  const EndRideScreenOwner({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.37,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20.0), topLeft: Radius.circular(20.0)),
      ),
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
                        child: const Text(
                          "PALLADIUM MALL, 462, a-nuch ate muf, alar a2a, yad, retay 400013, India",
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
                        child: const Text(
                          "Star MALL, 462, a-nuch ate muf, alar a2a, yad, retay 400013, India",
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                onSubmit(5);
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.44,
                height: 40,
                decoration: BoxDecoration(
                    color: const Color(0xFFF0C414),
                    borderRadius: BorderRadius.circular(30)),
                child: const Center(
                    child: Text(
                  "End Ride",
                  style: TextStyle(fontSize: 14, color: Colors.black),
                )),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Click Here For Ride Support",
            style: TextStyle(
              decoration: TextDecoration.underline,
            ),
          )
        ],
      ),
    );
  }
}
