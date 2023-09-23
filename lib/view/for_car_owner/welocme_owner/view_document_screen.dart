import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:myride/constant/app_color.dart';
import 'package:myride/constant/app_text_style.dart';
import 'package:myride/model/driverprofile.dart';
import 'package:myride/model/vehicleinfo.dart';
import 'package:myride/repository/driverprofile_repo.dart';
import 'package:myride/view_model/vehicleinfo_viewmodel.dart';
import 'package:provider/provider.dart';

class ImageNameKey {
  String name = "";
  String link = "";
  String key = "";

  ImageNameKey(this.name, this.link, this.key);
}

class ViewDocumentScreen extends StatefulWidget {
  DriverProfile? driverProfile;
  VehicleInfoo? vehicleDetail;
  final String documentType;

  ViewDocumentScreen(
      {super.key,
      this.driverProfile,
      required this.documentType,
      this.vehicleDetail});

  @override
  State<ViewDocumentScreen> createState() => _ViewDocumentScreenState();
}

class _ViewDocumentScreenState extends State<ViewDocumentScreen> {
  DriverProfile? profile;
  VehicleInfoo? vehicleDetail;
  bool isLoading = false;
  List<ImageNameKey> list = [];
  Dio dio = Dio();

  @override
  void initState() {
    super.initState();
    ImageNameKey? first, second;
    if (widget.driverProfile != null) {
      profile = widget.driverProfile;
    }
    if (widget.vehicleDetail != null) {
      vehicleDetail = widget.vehicleDetail;
    }
    switch (widget.documentType) {
      case "aadhar_number":
        first = ImageNameKey("Aadhar Front", profile!.aadharuploadfront ?? "",
            "aadhar_upload_front");
        second = ImageNameKey("Aadhar back", profile!.aadharuploadback ?? "",
            "aadhar_upload_back");
        break;
      case "license_number":
        first = ImageNameKey("License Front", profile!.licenseuploadfront ?? "",
            "license_upload_front");

        second = ImageNameKey("License back", profile!.licenseuploadback ?? "",
            "license_upload_back");
        break;
      case "pan_number":
        first =
            ImageNameKey("Pan Card", profile!.panupload ?? "", "pan_upload");
        break;
      case "registration_certiifcate":
        first = ImageNameKey(
            "Registration Certiifcate",
            vehicleDetail!.registrationcertiifcate ?? "",
            "registration_certiifcate");
        break;
      case "insurance_certiifcate":
        first = ImageNameKey("Insurance",
            vehicleDetail!.insurancecertiifcate ?? "", "insurance_certiifcate");
        break;
    }
    list.add(first!);
    if (second != null) list.add(second);
  }

  void toggleLoading() {
    isLoading = !isLoading;
  }

  void handelPhotoUpload(int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      toggleLoading();
      File file = File(result.files.single.path.toString());
      FormData formdata =
          FormData.fromMap({"file": await MultipartFile.fromFile(file.path)});
      dio.options.headers['Content-Type'] = 'application/json';
      dio.options.headers["Authorization"] =
          "Token 51fbe6e9f6755a819d29c48f644f1160b49de2ee";
      Response response = await dio.post(
        "http://3.109.183.75/account/upload/",
        data: formdata,
        onSendProgress: (int sent, int total) {
          String percentage = (sent / total * 100).toStringAsFixed(2);
          setState(() {
            print("$sent Bytes of $total Bytes - $percentage % uploaded");
          });
        },
      );

      if (response.statusCode == 200) {
        showSnackbar("File Uploaded");
        setState(() {
          list[index].link = response.data['url'];
        });

        Map<String, dynamic> map = {list[index].key: list[index].link};
        if (profile != null) {
          DriverProfileRepo().updateProfile(context, map);
        } else {
          VehicleInfoViewModel _provider =
              Provider.of<VehicleInfoViewModel>(context, listen: false);
          _provider.updateVehicle(context, map);
        }
        toggleLoading();
      } else {
        showSnackbar("Error during connection to server, try again!");
      }
    }
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                _buildTopSection(),
                ListView.builder(
                    itemCount: list.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return showDocumentView(index);
                    })
              ],
            ),
          ),
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
            top: 10,
            left: 10,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back)),
                // Text(
                //   "View Documents",
                //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                // )
              ],
            )),
      ],
    );
  }

  Widget showDocumentView(int index) {
    return Container(
      margin: const EdgeInsets.all(25),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: Appcolors.appGrey,
          )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            list[index].name,
            style: AppTextStyle.vehicleheading,
          ),
          list[index].link.isEmpty
              ? const Icon(
                  Icons.photo_camera_back,
                  size: 150,
                )
              : Image.network(
                  list[index].link,
                  width: 300,
                  height: 150,
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              uploadPhotoView(index),
              removePhotoView(index),
            ],
          )
        ],
      ),
    );
  }

  Widget uploadPhotoView(index) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          backgroundColor: Appcolors.appgreen,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12)),
      onPressed: () async {
        handelPhotoUpload(index);
      },
      icon: const Icon(
        Icons.upload,
        size: 15,
      ),
      // label: frontCarPhotoUrl != null
      //     ? const Text("Uploaded")
      label: const Text("Upload"),
    );
  }

  Widget removePhotoView(index) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12)),
      onPressed: () async {
        // handleFileUpload("ic");
        Map<String, dynamic> map = {list[index].key: ""};
        if (profile != null) {
          DriverProfileRepo().updateProfile(context, map);
        } else {
          VehicleInfoViewModel _provider =
              Provider.of<VehicleInfoViewModel>(context, listen: false);
          _provider.updateVehicle(context, map);
        }
        setState(() {
          list[index].link = "";
        });
      },
      icon: const Icon(
        Icons.close,
        size: 15,
      ),
      // label: frontCarPhotoUrl != null
      //     ? const Text("Uploaded")
      label: const Text("Remove"),
    );
  }
}
