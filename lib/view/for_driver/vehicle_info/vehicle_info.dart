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

class VehicleInfo extends StatefulWidget {
  const VehicleInfo({super.key});

  @override
  State<VehicleInfo> createState() => _VehicleInfoState();
}

class _VehicleInfoState extends State<VehicleInfo> {
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController _controller = TextEditingController();

  int? val1;
  int? val2;
  int? val3;
  int? val4;

  late File? ic, rc, mc, ad;
  String? frontCarPhotoUrl,
      backPhotoUrl,
      rightSideUrl,
      leftSideUrl,
      backHeadUrl,
      frontheadLightUrl,
      passengerSeatUrl,
      driverSideUrl;

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
          case 'ic':
            ic = File(result.files.single.path.toString());
            uploadFile("ic", ic!);
            break;
          case 'rc':
            rc = File(result.files.single.path.toString());
            uploadFile("rc", rc!);
            break;
          case 'mc':
            mc = File(result.files.single.path.toString());
            uploadFile("mc", mc!);
            break;
          case 'ad':
            ad = File(result.files.single.path.toString());
            uploadFile("ad", ad!);
            break;
          case 'driverSeat':
            ad = File(result.files.single.path.toString());
            uploadFile("driverSeat", ad!);
            break;
          case 'passangerSeat':
            ad = File(result.files.single.path.toString());
            uploadFile("passangerSeat", ad!);
            break;
          case 'backHead':
            ad = File(result.files.single.path.toString());
            uploadFile("backHead", ad!);
            break;
          case 'frontHead':
            ad = File(result.files.single.path.toString());
            uploadFile("frontHead", ad!);
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
        case 'ic':
          frontCarPhotoUrl = response.data['url'];
          break;
        case 'rc':
          backPhotoUrl = response.data['url'];
          break;
        case 'mc':
          rightSideUrl = response.data['url'];
          break;
        case 'ad':
          leftSideUrl = response.data['url'];
          break;
        case 'driverSeat':
          driverSideUrl = response.data['url'];
          break;
        case 'backHead':
          backHeadUrl = response.data['url'];
          break;
        case 'frontHead':
          frontheadLightUrl = response.data['url'];
          break;
        case 'passangerSeat':
          passengerSeatUrl = response.data['url'];
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
            Column(
              children: [
                ListTile(
                  title: const Text("Vehicle Maker"),
                  trailing: _provider!.currvma == null
                      ? const Text("Select")
                      : Text(_provider!.currvma!.maker!),
                  onTap: () async {
                    await _provider!.vehicleMaker(context);
                    vehiclemakeBottomSheet();
                  },
                ),
                customDivider(),
                ListTile(
                  title: const Text("Cab Type"),
                  trailing: _provider!.currct == null
                      ? const Text("Select")
                      : Text(_provider!.currct!.cabtype!),
                  onTap: () async {
                    await _provider!.cabType(context);
                    cabtypeBottomSheet();
                  },
                ),
                _provider!.currvma != null
                    ? Column(
                        children: [
                          customDivider(),
                          ListTile(
                            title: const Text("Vehicle Model"),
                            trailing: _provider!.currvmo == null
                                ? const Text("Select")
                                : Text(_provider!.currvmo!.model!),
                            onTap: () async {
                              await _provider!.vehicleModel(context, val1! + 1);
                              vehiclemodelBottomSheet();
                            },
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
                _provider!.currct != null
                    ? Column(
                        children: [
                          customDivider(),
                          ListTile(
                            title: const Text("Cab Class"),
                            trailing: _provider!.currcc == null
                                ? const Text("Select")
                                : Text(_provider!.currcc!.cabclass!),
                            onTap: () async {
                              await _provider!.cabClass(context, val2! + 1);
                              cabclassBottomSheet();
                            },
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
                customDivider(),
                ListTile(
                  title: const Text("Vehicle Plate Number"),
                  trailing: SizedBox(
                    width: 100,
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Number Plate",
                      ),
                    ),
                  ),
                ),
                selectbox(),
              ],
            )
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
    if (_provider!.currvma != null &&
        _provider!.currct != null &&
        _provider!.currvmo != null &&
        _provider!.currcc != null &&
        _controller.text.isNotEmpty &&
        frontCarPhotoUrl != null &&
        backPhotoUrl != null &&
        rightSideUrl != null &&
        leftSideUrl != null &&
        passengerSeatUrl != null &&
        backHeadUrl != null &&
        frontheadLightUrl != null &&
        driverSideUrl != null) {
      return true;
    }
    return false;
  }

  submit() async {
    setState(() {
      _provider!.loading = true;
    });

    _provider!.vi = VehicleInfoo(
      isactive: true,
      numberplate: _controller.text,
      front: frontCarPhotoUrl,
      back: backPhotoUrl,
      right: rightSideUrl,
      left: leftSideUrl,
      insideDriverSeat: driverSideUrl,
      frontHeadLight: frontheadLightUrl,
      backHeadLight: backHeadUrl,
      insidePassangerSeat: passengerSeatUrl,
      lastlocation: "",
      driver: 41,
      maker: _provider!.currvma!.id,
      model: _provider!.currvmo!.id,
      cabtype: _provider!.currct!.id,
      cabclass: _provider!.currcc!.id,
    );
    _provider!.submit(context);
  }

  customDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: const Divider(
        color: Color.fromARGB(255, 206, 204, 204),
      ),
    );
  }

  selectbox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: const Text("Upload Car Photos*"),
        ),
        Container(
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
                          color: frontCarPhotoUrl != null
                              ? Appcolors.appgreen
                              : Colors.grey,
                        ),
                        hintText: 'Front',
                        hintStyle:
                            TextStyle(color: Color(0xFF999999), fontSize: 12),
                        border: InputBorder.none),
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Appcolors.appgreen,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 12)),
                  onPressed: () async {
                    handleFileUpload("ic");
                  },
                  icon: const Icon(
                    Icons.upload,
                    size: 15,
                  ),
                  label: frontCarPhotoUrl != null
                      ? const Text("Uploaded")
                      : const Text("Upload"),
                ),
              ],
            ),
          ),
        ),
        Container(
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
                          color: backPhotoUrl != null
                              ? Appcolors.appgreen
                              : Colors.grey,
                        ),
                        hintText: 'Back',
                        hintStyle:
                            TextStyle(color: Color(0xFF999999), fontSize: 12),
                        border: InputBorder.none),
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Appcolors.appgreen,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 12)),
                  onPressed: () async {
                    handleFileUpload("rc");
                  },
                  icon: const Icon(
                    Icons.upload,
                    size: 15,
                  ),
                  label: backPhotoUrl != null
                      ? const Text("Uploaded")
                      : const Text("Upload"),
                ),
              ],
            ),
          ),
        ),
        Container(
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
                          color: rightSideUrl != null
                              ? Appcolors.appgreen
                              : Colors.grey,
                        ),
                        hintText: 'Right Side',
                        hintStyle:
                            TextStyle(color: Color(0xFF999999), fontSize: 12),
                        border: InputBorder.none),
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Appcolors.appgreen,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 12)),
                  onPressed: () async {
                    handleFileUpload("mc");
                  },
                  icon: const Icon(
                    Icons.upload,
                    size: 15,
                  ),
                  label: rightSideUrl != null
                      ? const Text("Uploaded")
                      : const Text("Upload"),
                ),
              ],
            ),
          ),
        ),
        Container(
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
                          color: leftSideUrl != null
                              ? Appcolors.appgreen
                              : Colors.grey,
                        ),
                        hintText: 'Left Side',
                        hintStyle:
                            TextStyle(color: Color(0xFF999999), fontSize: 12),
                        border: InputBorder.none),
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Appcolors.appgreen,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 12)),
                  onPressed: () async {
                    handleFileUpload("ad");
                  },
                  icon: const Icon(
                    Icons.upload,
                    size: 15,
                  ),
                  label: leftSideUrl != null
                      ? const Text("Uploaded")
                      : const Text("Upload"),
                ),
              ],
            ),
          ),
        ),
        Container(
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
                          color: driverSideUrl != null
                              ? Appcolors.appgreen
                              : Colors.grey,
                        ),
                        hintText: 'Inside the driver Seat',
                        hintStyle:
                            TextStyle(color: Color(0xFF999999), fontSize: 12),
                        border: InputBorder.none),
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Appcolors.appgreen,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 12)),
                  onPressed: () async {
                    handleFileUpload("driverSeat");
                  },
                  icon: const Icon(
                    Icons.upload,
                    size: 15,
                  ),
                  label: driverSideUrl != null
                      ? const Text("Uploaded")
                      : const Text("Upload"),
                ),
              ],
            ),
          ),
        ),
        Container(
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
                          color: passengerSeatUrl != null
                              ? Appcolors.appgreen
                              : Colors.grey,
                        ),
                        hintText: 'Inside the passanger seat',
                        hintStyle:
                            TextStyle(color: Color(0xFF999999), fontSize: 12),
                        border: InputBorder.none),
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Appcolors.appgreen,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 12)),
                  onPressed: () async {
                    handleFileUpload("passangerSeat");
                  },
                  icon: const Icon(
                    Icons.upload,
                    size: 15,
                  ),
                  label: passengerSeatUrl != null
                      ? const Text("Uploaded")
                      : const Text("Upload"),
                ),
              ],
            ),
          ),
        ),
        Container(
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
                          color: frontheadLightUrl != null
                              ? Appcolors.appgreen
                              : Colors.grey,
                        ),
                        hintText: 'Front Head Lights',
                        hintStyle:
                            TextStyle(color: Color(0xFF999999), fontSize: 12),
                        border: InputBorder.none),
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Appcolors.appgreen,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 12)),
                  onPressed: () async {
                    handleFileUpload("frontHead");
                  },
                  icon: const Icon(
                    Icons.upload,
                    size: 15,
                  ),
                  label: frontheadLightUrl != null
                      ? const Text("Uploaded")
                      : const Text("Upload"),
                ),
              ],
            ),
          ),
        ),
        Container(
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
                          color: backHeadUrl != null
                              ? Appcolors.appgreen
                              : Colors.grey,
                        ),
                        hintText: 'Back head Lights',
                        hintStyle:
                            TextStyle(color: Color(0xFF999999), fontSize: 12),
                        border: InputBorder.none),
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Appcolors.appgreen,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 12)),
                  onPressed: () async {
                    handleFileUpload("backHead");
                  },
                  icon: const Icon(
                    Icons.upload,
                    size: 15,
                  ),
                  label: backHeadUrl != null
                      ? const Text("Uploaded")
                      : const Text("Upload"),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 25,
        )
      ],
    );
  }

  coustomline() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.20,
      height: 4,
      color: Colors.green,
    );
  }

  vehiclemakeBottomSheet() {
    Future.delayed(const Duration(seconds: 1));
    showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Vehicle Maker",
                          style: AppTextStyle.vehicleheading,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.cancel_rounded),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _provider!.vma.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return RadioListTile(
                          activeColor: Appcolors.appgreen,
                          title: Text(_provider!.vma[index].maker!),
                          value: index,
                          groupValue: val1,
                          onChanged: (curr) {
                            setState(() {
                              val1 = curr;
                            });
                            _provider!.currvma = _provider!.vma[index];
                            _provider!.vehicleModel(context, index + 1);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  cabtypeBottomSheet() {
    Future.delayed(const Duration(seconds: 1));
    showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Cab Type",
                          style: AppTextStyle.vehicleheading,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.cancel_rounded),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _provider!.ct.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return RadioListTile(
                          title: Text(_provider!.ct[index].cabtype!),
                          value: index,
                          activeColor: Appcolors.appgreen,
                          groupValue: val2,
                          onChanged: (curr) {
                            setState(() {
                              val2 = curr;
                            });
                            _provider!.currct = _provider!.ct[index];
                            _provider!.cabClass(context, index + 1);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  vehiclemodelBottomSheet() {
    Future.delayed(const Duration(seconds: 1));
    showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 15,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Vehicle Model",
                          style: AppTextStyle.vehicleheading,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.cancel_rounded),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _provider!.vmo.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return RadioListTile(
                          title: Text(_provider!.vmo[index].model!),
                          value: index,
                          groupValue: val3,
                          activeColor: Appcolors.appgreen,
                          onChanged: (curr) {
                            setState(() {
                              val3 = curr;
                            });
                            _provider!.currvmo = _provider!.vmo[index];
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  cabclassBottomSheet() {
    Future.delayed(const Duration(seconds: 1));
    showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 15,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Cab Class",
                          style: AppTextStyle.vehicleheading,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.cancel_rounded),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _provider!.cc.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return RadioListTile(
                          title: Text(_provider!.cc[index].cabclass!),
                          value: index,
                          activeColor: Appcolors.appgreen,
                          groupValue: val4,
                          onChanged: (curr) {
                            setState(() {
                              val4 = curr;
                            });
                            _provider!.currcc = _provider!.cc[index];
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
