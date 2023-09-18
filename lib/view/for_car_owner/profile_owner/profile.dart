import 'package:flutter/material.dart';
import 'package:myride/constant/app_text_style.dart';
import 'package:myride/view/for_driver/profile/add_new_vehicle.dart';
import 'package:myride/view/for_driver/profile/change_password.dart';
import 'package:myride/view/for_driver/profile/message_screen.dart';
import 'package:myride/view/for_driver/profile/my_schedule.dart';
import 'package:myride/view/for_driver/profile/vehicle_list.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _buildTopSection(),
            _buildCard(),
            _buildOptionList(),
          ],
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
          left: 10,
          bottom: 4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sandip Sen",
                    style: TextStyle(fontSize: 30),
                  ),
                  Text("sandip@gmail.com")
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.34,
              ),
              const CircleAvatar(
                radius: 40,
              )
            ],
          ),
        )
      ],
    );
  }

  _buildCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: const Column(
                  children: [Text("100"), Text("Total Route")],
                ),
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: const Column(
                  children: [Text("12"), Text("Total Miles")],
                ),
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: const Column(
                  children: [Text("2"), Text("Total Vehicles")],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildOptionList() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const MySchedule();
            }));
          },
          child: Card(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              child: Row(
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
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const MessageScreen();
            }));
          },
          child: Card(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/icon/notification.png",
                        width: 30,
                      ),
                      const Text("Message",
                          style: AppTextStyle.listCardProfile),
                    ],
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const VehicleList();
            }));
          },
          child: Card(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/icon/vehicle.png",
                        width: 30,
                      ),
                      const Text("Vehicle",
                          style: AppTextStyle.listCardProfile),
                    ],
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const AddNewVehicle();
            }));
          },
          child: Card(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/icon/personalcard.png",
                        width: 30,
                      ),
                      const Text("Driver Licence",
                          style: AppTextStyle.listCardProfile),
                    ],
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const ChangePassword();
            }));
          },
          child: Card(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/icon/lock.png",
                        width: 30,
                      ),
                      const Text("Change Password",
                          style: AppTextStyle.listCardProfile),
                    ],
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context) {
            //   return RouteScreen();
            // }));
          },
          child: Card(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/icon/call.png",
                        width: 30,
                      ),
                      const Text("Contact",
                          style: AppTextStyle.listCardProfile),
                    ],
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
