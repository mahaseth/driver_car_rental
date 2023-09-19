import 'package:flutter/material.dart';
import 'package:myride/constant/app_text_style.dart';
import 'package:myride/model/driverprofile.dart';
import 'package:myride/utils/rating_stars.dart';
import 'package:myride/view_model/driverprofile_viewmodel.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  DriverProfile? driverProfile;

  DriveProfileViewModel? _provider;
  String name = "", location = "", id = "", url = "";

  List<String> tileTitle = [
    "My Vehicle",
    "Driving Liscense",
    "Aadhar Card",
    "PAN Card",
    "Message",
    "Admin Support",
    "Contact Us",
  ];

  List<Icon> tileIcons = [
    Icon(Icons.fire_truck),
    Icon(Icons.contact_page),
    Icon(Icons.book),
    Icon(Icons.book),
    Icon(Icons.book),
    Icon(Icons.book),
    Icon(Icons.phone),
  ];

  @override
  void initState() {
    super.initState();
    readData();
  }

  void readData() async {
    _provider = Provider.of<DriveProfileViewModel>(context, listen: false);
    setState(() {
      _provider!.loading;
    });
    await _provider!.getProfile(context);
    setState(() {
      driverProfile = _provider!.currdriverProfile;
    });
    setState(() {
      _provider!.loading;
    });
  }

  topProfileView() {
    return Stack(
      children: [
        Image.asset("assets/images/headerbg_image.png"),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.125,
          width: MediaQuery.of(context).size.width,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: AppTextStyle.welcommehead,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        StarRating(rating: 4, size: 24)
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ),
        Positioned(
            right: 0,
            bottom: 0,
            child: ClipOval(
              child: Image.network(
                url,
                fit: BoxFit.fill,
                width: 150,
                height: 150,
              ),
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (driverProfile != null) {
      name = driverProfile!.firstname ?? "";
      location = driverProfile!.fulladdress ?? "";
      id = driverProfile!.id.toString() ?? "";
      url = driverProfile!.photoupload ?? "";
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            topProfileView(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  color: Colors.white,
                  child: const Column(
                    children: [
                      Text("100", style: AppTextStyle.upperitemtmeemtext),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Complete Trips",
                        style: AppTextStyle.upperitemtmeemspantext,
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  color: Colors.white,
                  child: const Column(
                    children: [
                      Text("1145.5", style: AppTextStyle.upperitemtmeemtext),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("MENU"),
                  ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: tileIcons[index],
                            title: Text(tileTitle[index]),
                            trailing: Icon(Icons.arrow_forward_ios),
                          ),
                        );
                      })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
