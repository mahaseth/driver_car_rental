import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:myride/constant/app_text_style.dart';
import 'package:myride/model/driverprofile.dart';
import 'package:myride/utils/rating_stars.dart';
import 'package:myride/view/for_car_owner/welocme_owner/view_document_screen.dart';
import 'package:myride/view/for_driver/profile/message_screen.dart';
import 'package:myride/view/for_driver/profile/write_message.dart';
import 'package:myride/view/for_driver/splash/splash.dart';
import 'package:myride/view_model/driverprofile_viewmodel.dart';
import 'package:myride/view_model/signIn_viewModel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatefulWidget {
  final Function onItemTapped;

  const AccountScreen({super.key, required this.onItemTapped});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  DriverProfile? driverProfile;

  double size = 0;
  double totalDistance = 0;
  DriveProfileViewModel? _provider;
  String name = "", location = "", id = "", url = "";
  bool isLoading = false;

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
    const Icon(Icons.fire_truck),
    const Icon(Icons.contact_page),
    const Icon(Icons.book),
    const Icon(Icons.book),
    const Icon(Icons.book),
    const Icon(Icons.book),
    const Icon(Icons.phone),
  ];

  List<dynamic> tileOnClick = [
    1,
    "license_number",
    "aadhar_number",
    "pan_number",
    const MessageScreen(),
    const WriteMessage(),
    null,
  ];

  @override
  void initState() {
    super.initState();
    readData();
  }

  void showLogout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: const [
              Text('Do you want to log out'),
            ],
          ),
          // content: Text(
          //     'Your booking has been confirmed\n Driver will pickup you in 2 minutes.'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                if (sharedPreferences.containsKey('token')) {
                  SignInViewModel.token = "";
                  sharedPreferences.remove('token');
                  Navigator.of(context).popUntil((route) => false);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SplashScreen(),
                    ),
                  );
                }
              },
              child: const Text('YES'),
            ),
            TextButton(
              onPressed: () {
                // Perform an action here
                Navigator.of(context).pop();
              },
              child: Text('NO'),
            ),
          ],
        );
      },
    );
  }

  void readData() async {
    _provider = Provider.of<DriveProfileViewModel>(context, listen: false);
    setState(() {
      _provider!.loading;
    });
    await _provider!.getProfile(context);
    setState(() {
      driverProfile = _provider!.currDriverProfile;
    });
    setState(() {
      _provider!.loading;
      name = driverProfile!.firstname ?? "";
      location = driverProfile!.fulladdress ?? "";
      id = (driverProfile!.id ?? 0).toString();
      url = driverProfile!.photoupload ?? "";
      size = driverProfile!.totalTrip ?? 0.0;
      totalDistance = driverProfile!.totalDistanceKm ?? 0.0;
    });
  }

  showSnackbar(String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  uploadFile(File f) async {
    setState(() {
      isLoading = true;
    });
    String token = SignInViewModel.token;
    FormData formdata =
        FormData.fromMap({"file": await MultipartFile.fromFile(f.path)});
    Dio dio = Dio();
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers["Authorization"] = "Token $token";
    var response = await dio.post(
      "http://3.109.183.75/account/upload/",
      data: formdata,
      onSendProgress: (int sent, int total) {
        String percentage = (sent / total * 100).toStringAsFixed(2);
        print("$sent Bytes of $total Bytes - $percentage % uploaded");
      },
    );
    if (response.statusCode == 200) {
      showSnackbar("File Uploaded");
    } else {
      showSnackbar("Error during connection to server, try again!");
    }
    setState(() {
      isLoading = false;
      url = response.data['url'];
    });
    Map<String, dynamic> map = {"photo_upload": url};
    _provider!.updateProfile(context, map);
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
                        const SizedBox(
                          height: 10,
                        ),
                        const StarRating(rating: 4, size: 24)
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
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : GestureDetector(
                    onTap: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();
                      if (result != null) {
                        File file = File(result.files.single.path.toString());
                        uploadFile(file);
                      }
                    },
                    child: ClipOval(
                      child: url.isEmpty
                          ? const Icon(
                              Icons.person,
                              size: 75,
                            )
                          : Image.network(
                              url,
                              fit: BoxFit.fill,
                              width: 150,
                              height: 150,
                            ),
                    ),
                  )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  child: Column(
                    children: [
                      Text(size.toString(),
                          style: AppTextStyle.upperitemtmeemtext),
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
                  child: Column(
                    children: [
                      Text(totalDistance.toString(),
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
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("MENU"),
                  ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            if (tileOnClick[index] == null) return;
                            if (tileOnClick[index] is int) {
                              if (tileOnClick[index] == 1) {
                                widget.onItemTapped(0);
                              }
                              return;
                            }
                            if (tileOnClick[index] is String) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ViewDocumentScreen(
                                      driverProfile: driverProfile!,
                                      documentType: tileOnClick[index])));
                              return;
                            }

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => tileOnClick[index]));
                          },
                          child: Card(
                            child: ListTile(
                              leading: tileIcons[index],
                              title: Text(tileTitle[index]),
                              trailing: const Icon(Icons.arrow_forward_ios),
                            ),
                          ),
                        );
                      }),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.logout),
                      title: const Text(
                        "Logout",
                      ),
                      onTap: () => showLogout(),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
