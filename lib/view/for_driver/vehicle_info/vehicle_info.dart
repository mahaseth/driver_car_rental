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
import 'package:myride/view/for_driver/driver-details/vehicle_extra_document.dart';
import 'package:myride/view_model/signIn_viewModel.dart';
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
  final TextEditingController _controller = TextEditingController();

  int? vehicleType;
  int? vehicleMaker;
  int? vehicleModel;
  bool isLoading = false;

  late File? ic, rc, mc, ad;
  String? frontCarPhotoUrl,
      backPhotoUrl,
      rightSideUrl,
      leftSideUrl,
      backHeadUrl,
      frontheadLightUrl,
      passengerSeatUrl,
      driverSideUrl,
      additionalImage;

  VehicleInfoViewModel? _provider;

  Dio dio = Dio();

  late Response response;

  void handleFileUpload(String type) async {
    setState(() {
      isLoading = true;
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
          isLoading = false;
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
    dio.options.headers["Authorization"] = "Token ${SignInViewModel.token}";
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
        case 'additionalImage':
          additionalImage = response.data['url'];
          break;
        default:
      }

      setState(() {
        isLoading = false;
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

  String carType = "AUTO";
  List<String> carOption = ["AUTO", "Taxi", "Bike", "Cab"];

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<VehicleInfoViewModel>(context, listen: true);

    return ModalProgressHUD(
      inAsyncCall: isLoading,
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
                customLine(),
                customLine(),
                customLine(),
                customLine(),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    await _provider!.cabType(context);
                    cabtypeBottomSheet();
                  },
                  child: Container(
                    decoration: containerDecoration(),
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _provider!.vehicleType == null
                            ? const Text(
                                "Cab Type",
                                style: TextStyle(fontSize: 18),
                              )
                            : Text(
                                _provider!.vehicleType!.cabtype!,
                                style: const TextStyle(fontSize: 18),
                              ),
                        const Icon(Icons.arrow_drop_down_sharp),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  child: Container(
                    decoration: containerDecoration(),
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _provider!.vehicleMaker == null
                            ? const Text(
                                "Vehicle Maker",
                                style: TextStyle(fontSize: 18),
                              )
                            : Text(
                                _provider!.vehicleMaker!.maker!,
                                style: const TextStyle(fontSize: 18),
                              ),
                        const Icon(Icons.arrow_drop_down_sharp),
                      ],
                    ),
                  ),
                  onTap: () async {
                    if (vehicleType == null) {
                      showSnackbar("Please select Vehicle Type First");
                      return;
                    }
                    await _provider!.vehicleMakerCall(
                        context, _provider!.vehicleType!.id ?? 1);
                    vehicleMakeBottomSheet();
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  child: Container(
                    decoration: containerDecoration(),
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _provider!.currVehicleModel == null
                            ? const Text(
                                "Vehicle Model",
                                style: TextStyle(fontSize: 18),
                              )
                            : Text(
                                _provider!.currVehicleModel!.model!,
                                style: const TextStyle(fontSize: 18),
                              ),
                        const Icon(Icons.arrow_drop_down_sharp),
                      ],
                    ),
                  ),
                  onTap: () async {
                    if (vehicleMaker == null) {
                      showSnackbar("Please select Vehicle Maker First");
                      return;
                    }
                    await _provider!.vehicleModel(
                        context, _provider!.vehicleMaker?.id ?? 1);
                    vehiclemodelBottomSheet();
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                inputTextField(_controller, "Vehicle Number*", width: 0.95),
                const SizedBox(
                  height: 15,
                ),
                selectBox(),
              ],
            )
          ],
        ),
        bottomNavigationBar: GestureDetector(
          onTap: () {
            check() ? submit() : showSnackbar("All fields required");
            // submit();
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

  containerDecoration() {
    return BoxDecoration(
        border: Border.all(
          color: const Color(0xFF8D8D8D), // Specify the color of the border
          width: 2.0, // Specify the width of the border
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)));
  }

  check() {
    if (_provider!.vehicleMaker != null &&
        _provider!.vehicleType != null &&
        _provider!.currVehicleModel != null &&
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
      isLoading = true;
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
        maker: _provider!.vehicleMaker!.id,
        model: _provider!.currVehicleModel!.id,
        cabtype: _provider!.vehicleType!.id,
        cabclass: _provider!.currVehicleModel!.cabClass);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return VehicleExtraDocument(
            vehicleDetail: _provider!.vi,
          );
        },
      ),
    );
  }

  uploadSquareBox(String hint, String? file, String uploadText) {
    return GestureDetector(
      onTap: () {
        handleFileUpload(uploadText);
      },
      child: Container(
          width: 100,
          height: 100,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: DottedBorder(
            color: const Color(0xFFdddddd),
            strokeWidth: 1,
            dashPattern: const [5, 6],
            child: file != null
                ? Image.network(file)
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 75,
                                width: 75,
                                child: Icon(Icons.add),
                              ),
                              Text(
                                hint,
                                style: const TextStyle(fontSize: 12),
                              )
                            ],
                          )),
                    ],
                  ),
          )),
    );
  }

  selectBox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ListTile(
          title: Text("Upload Car Photos*"),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  uploadSquareBox('Front', frontCarPhotoUrl, "ic"),
                  uploadSquareBox('Back', backPhotoUrl, "rc"),
                  uploadSquareBox('Right Side', rightSideUrl, "mc"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  uploadSquareBox('Left Side', leftSideUrl, "ad"),
                  uploadSquareBox(
                      'Interior', passengerSeatUrl, "passangerSeat"),
                  uploadSquareBox('Interior', driverSideUrl, "driverSeat"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  uploadSquareBox(
                      'Front No. Plate', frontheadLightUrl, "backHead"),
                  uploadSquareBox('Back No. Plate', backHeadUrl, "backHead"),
                  uploadSquareBox(
                      'Additional Image', additionalImage, "additionImage"),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 25,
        )
      ],
    );
  }

  customLine() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.20,
      height: 4,
      color: Colors.green,
    );
  }

  vehicleMakeBottomSheet() {
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
                      itemCount: _provider!.vehicleMakerList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return RadioListTile(
                          activeColor: Appcolors.appgreen,
                          title:
                              Text(_provider!.vehicleMakerList[index].maker!),
                          value: index,
                          groupValue: vehicleMaker,
                          onChanged: (curr) {
                            setState(() {
                              vehicleMaker = curr;
                              _provider!.vehicleMaker =
                                  _provider!.vehicleMakerList[index];
                            });

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
          builder: (context, changeState) {
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            selectVehicleWidget("Auto", 0, changeState),
                            const SizedBox(
                              width: 25,
                            ),
                            selectVehicleWidget("Bike", 1, changeState),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            selectVehicleWidget("Cab", 2, changeState),
                            const SizedBox(
                              width: 25,
                            ),
                            selectVehicleWidget("Taxi", 3, changeState),
                          ],
                        )
                      ],
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

  Widget selectVehicleWidget(String name, int index, changeState) {
    return InkWell(
      onTap: () {
        debugPrint(name);
        changeState(() {
          vehicleType = index;
        });
        setState(() {
          _provider!.vehicleType = _provider!.cabTypeList[index];
          _provider!.vehicleMaker = null;
        });
        Navigator.pop(context);
      },
      child: Container(
        height: AppSceenSize.getHeight(context) * 0.1,
        width: AppSceenSize.getWidth(context) * 0.35,
        decoration: BoxDecoration(
            color: Appcolors.primaryGreen,
            borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/icon/${name}_choose.png",
                height: 35,
                width: 35,
              ),
              Text(name)
            ],
          ),
        ),
      ),
    );
  }

  inputTextField(TextEditingController controller, String hintText,
      {double width = 1}) {
    return SizedBox(
      width: AppSceenSize.getWidth(context) * width,
      height: 50,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            // hintText: hintText,
            labelText: hintText),
      ),
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
          builder: (context, changeState) {
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
                      itemCount: _provider!.vehicleModelList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return RadioListTile(
                          title:
                              Text(_provider!.vehicleModelList[index].model!),
                          value: index,
                          groupValue: vehicleModel,
                          activeColor: Appcolors.appgreen,
                          onChanged: (curr) {
                            changeState(() {
                              vehicleModel = curr;
                            });
                            setState(() {
                              _provider!.currVehicleModel =
                                  _provider!.vehicleModelList[index];
                            });
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

// cabclassBottomSheet() {
//   Future.delayed(const Duration(seconds: 1));
//   showModalBottomSheet<void>(
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(
//         top: Radius.circular(30),
//       ),
//     ),
//     context: context,
//     builder: (BuildContext context) {
//       return StatefulBuilder(
//         builder: (context, setState) {
//           return SizedBox(
//             height: MediaQuery.of(context).size.height * 0.75,
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 15,
//                     vertical: 15,
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       const Text(
//                         "Cab Class",
//                         style: AppTextStyle.vehicleheading,
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.pop(context);
//                         },
//                         child: const Icon(Icons.cancel_rounded),
//                       )
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: _provider!.cc.length,
//                     shrinkWrap: true,
//                     itemBuilder: (context, index) {
//                       return RadioListTile(
//                         title: Text(_provider!.cc[index].cabclass!),
//                         value: index,
//                         activeColor: Appcolors.appgreen,
//                         groupValue: val4,
//                         onChanged: (curr) {
//                           setState(() {
//                             val4 = curr;
//                           });
//                           _provider!.currcc = _provider!.cc[index];
//                         },
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       );
//     },
//   );
// }
}
