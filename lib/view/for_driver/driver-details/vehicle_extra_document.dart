// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:myride/constant/app_screen_size.dart';
import 'package:myride/constant/app_text_style.dart';
import 'package:myride/model/vehicleinfo.dart';
import 'package:myride/view_model/vehicleinfo_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../constant/app_color.dart';

class Car {
  final String name;

  Car({required this.name});
}

class VehicleExtraDocument extends StatefulWidget {
  final VehicleInfoo vehicleDetail;

  const VehicleExtraDocument({super.key, required this.vehicleDetail});

  @override
  State<VehicleExtraDocument> createState() => _VehicleExtraDocument();
}

class _VehicleExtraDocument extends State<VehicleExtraDocument> {
  @override
  void initState() {
    super.initState();
  }

  late File? file;
  String? insuranceUrl, rcUrl, additionalUrl, soundUrl, motUrl, pollutionUrl;

  VehicleInfoViewModel? _provider;

  Dio dio = Dio();

  late Response response;

  void handleFileUpload(String type) async {
    setState(() {
      _provider!.loading = true;
    });
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        switch (type) {
          case 'insurance':
            file = File(result.files.single.path.toString());
            uploadFile("insurance", file!);
            break;
          case 'rc':
            file = File(result.files.single.path.toString());
            uploadFile("rc", file!);
            break;
          case 'pollution':
            file = File(result.files.single.path.toString());
            uploadFile("pollution", file!);
            break;
          case 'sound':
            file = File(result.files.single.path.toString());
            uploadFile("sound", file!);
            break;
          case 'mot':
            file = File(result.files.single.path.toString());
            uploadFile("mot", file!);
            break;
          case 'additional':
            file = File(result.files.single.path.toString());
            uploadFile("additional", file!);
            break;
          default:
        }
      } else {
        setState(() {
          _provider!.loading = false;
        });
      }
    } on PlatformException catch (e) {
      showSnackbar("Error Uploading file $e");
    }
  }

  uploadFile(String type, File f) async {
    FormData formdata =
        FormData.fromMap({"file": await MultipartFile.fromFile(f.path)});
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers["Authorization"] =
        "Token 51fbe6e9f6755a819d29c48f644f1160b49de2ee";
    response = await dio.post(
      "http://3.109.183.75/account/upload/",
      data: formdata,
      onSendProgress: (int sent, int total) {
        String percentage = (sent / total * 100).toStringAsFixed(2);
        setState(() {
          print("$sent Bytes of $total Bytes - $percentage % uploaded");
          //update the progress
        });
      },
    );
    if (response.statusCode == 200) {
      showSnackbar("File Uploaded");
      switch (type) {
        case 'insurance':
          insuranceUrl = response.data['url'];
          break;
        case 'rc':
          rcUrl = response.data['url'];
          break;
        case 'pollution':
          pollutionUrl = response.data['url'];
          break;
        case 'additional':
          additionalUrl = response.data['url'];
          break;
        case 'mot':
          motUrl = response.data['url'];
          break;
        case 'sound':
          soundUrl = response.data['url'];
          break;
        default:
      }

      setState(() {
        _provider!.loading = false;
      });
    } else {
      showSnackbar("Error during connection to server, try again!");
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
    _provider = Provider.of<VehicleInfoViewModel>(context, listen: true);
    return ModalProgressHUD(
      inAsyncCall: _provider!.loading,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFFAFAFA),
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Vehicle",
            style: TextStyle(color: Color(0xFF333333)),
          ),
        ),
        body: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                coustomline(),
                coustomline(),
                coustomline(),
                coustomline(),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: AppSceenSize.getHeight(context) * 0.10,
              color: const Color(0xFFFAFAFA),
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Add your vehicle info ",
                      style: AppTextStyle.vehicleheading,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Please provide details about your vehicle & kindly upload the Certificate.",
                      style: AppTextStyle.vehiclesubheading,
                    ),
                  ],
                ),
              ),
            ),
            selectbox(),
          ],
        ),
        bottomNavigationBar: GestureDetector(
          onTap: () {
            check() ? submit() : showSnackbar("All fields required");
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            width: double.infinity,
            height: 50,
            color: const Color(0xFF00B74C),
            padding: const EdgeInsets.all(16),
            child: const Center(
              child: Text(
                'DONE',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  check() {
    if (insuranceUrl != null &&
        rcUrl != null &&
        motUrl != null &&
        additionalUrl != null &&
        soundUrl != null &&
        pollutionUrl != null) {
      return true;
    }
    return false;
  }

  submit() async {
    setState(() {
      _provider!.loading = true;
    });
    VehicleInfoo vehicleDetail = widget.vehicleDetail;

    vehicleDetail.pollution = pollutionUrl;
    vehicleDetail.motcertiifcate = motUrl;
    vehicleDetail.addtionaldocument = additionalUrl;
    vehicleDetail.insurancecertiifcate = insuranceUrl;
    vehicleDetail.sound = soundUrl;
    vehicleDetail.registrationcertiifcate = rcUrl;
    _provider!.vi = vehicleDetail;

    _provider!.submit(context);
  }

  selectbox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ListTile(
          title: Text("Upload Certificates*"),
        ),
        customRowUploadView(insuranceUrl, "insurance", 'Insurance'),
        customRowUploadView(rcUrl, "rc", 'RC'),
        customRowUploadView(pollutionUrl, "pollution", 'Pollution'),
        customRowUploadView(motUrl, "mot", 'MOT'),
        customRowUploadView(soundUrl, "sound", 'Sound'),
        customRowUploadView(additionalUrl, "additional", 'Additional'),
        const SizedBox(
          height: 25,
        )
      ],
    );
  }

  Widget customRowUploadView(String? baseUrl, String fileName, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: DottedBorder(
        color: const Color(0xFFdddddd),
        strokeWidth: 1,
        dashPattern: const [5, 6],
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.check_box,
                      color: baseUrl != null ? Appcolors.appgreen : Colors.grey,
                    ),
                    hintText: title,
                    hintStyle:
                        const TextStyle(color: Color(0xFF999999), fontSize: 12),
                    border: InputBorder.none),
              ),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Appcolors.appgreen,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 12)),
              onPressed: () async {
                handleFileUpload(fileName);
              },
              icon: const Icon(
                Icons.upload,
                size: 15,
              ),
              label: baseUrl != null
                  ? const Text("Uploaded")
                  : const Text("Upload"),
            ),
          ],
        ),
      ),
    );
  }

  coustomline() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.20,
      height: 4,
      color: Colors.green,
    );
  }
}
