import 'dart:io';

import 'package:csc_picker/csc_picker.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:myride/constant/app_color.dart';
import 'package:myride/constant/app_screen_size.dart';
import 'package:myride/constant/app_text_style.dart';
import 'package:myride/model/driverprofile.dart';
import 'package:myride/utils/utils.dart';
import 'package:myride/view_model/driverprofile_viewmodel.dart';
import 'package:myride/view_model/signIn_viewModel.dart';
import 'package:provider/provider.dart';

class DriverDetailsScreen extends StatefulWidget {
  const DriverDetailsScreen({super.key});

  @override
  State<DriverDetailsScreen> createState() => _DriverDetailsScreenState();
}

class _DriverDetailsScreenState extends State<DriverDetailsScreen> {
  final TextEditingController fName = TextEditingController();
  final TextEditingController lName = TextEditingController();
  final TextEditingController pinCode = TextEditingController();
  final TextEditingController state = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController houseNumber = TextEditingController();
  final TextEditingController roadName = TextEditingController();
  final TextEditingController nearbyPlace = TextEditingController();
  final TextEditingController aadhar = TextEditingController();
  final TextEditingController pan = TextEditingController();
  final TextEditingController license = TextEditingController();
  final TextEditingController email = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late File? af, ab, p, lf, lb, pu;
  String? afs, abs, ps, lfs, lbs, pus;

  Dio dio = Dio();
  String countryValue = "", stateValue = "", cityValue = "";

  late Response response;

  DriveProfileViewModel? _provider;

  void handleFileUpload(String type) async {
    setState(() {
      _provider!.loading = true;
    });
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        switch (type) {
          case 'af':
            af = File(result.files.single.path.toString());
            uploadFile("af", af!);
            break;
          case 'ab':
            ab = File(result.files.single.path.toString());
            uploadFile("ab", ab!);
            break;
          case 'p':
            p = File(result.files.single.path.toString());
            uploadFile("p", p!);
            break;
          case 'lf':
            lf = File(result.files.single.path.toString());
            uploadFile("lf", lf!);
            break;
          case 'lb':
            lb = File(result.files.single.path.toString());
            uploadFile("lb", lb!);
            break;
          case 'pu':
            pu = File(result.files.single.path.toString());
            uploadFile("pu", pu!);
            break;
          default:
        }
      } else {
        setState(() {
          _provider!.loading = true;
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
        case 'af':
          afs = response.data['url'];
          break;
        case 'ab':
          abs = response.data['url'];
          break;
        case 'p':
          ps = response.data['url'];
          break;
        case 'lf':
          lfs = response.data['url'];
          break;
        case 'lb':
          lbs = response.data['url'];
          break;
        case 'pu':
          pus = response.data['url'];
          break;
        default:
      }
      setState(() {});
    } else {
      showSnackbar("Error during connection to server, try again!");
    }
    setState(() {
      _provider!.loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<DriveProfileViewModel>(context, listen: true);
    return ModalProgressHUD(
      inAsyncCall: _provider!.loading,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFFAFAFA),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: const Color(0xFF333333),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: const Text(
            "Driver Details",
            style: TextStyle(color: Color(0xFF333333)),
          ),
        ),
        body: ListView(
          children: [
            Container(
              height: AppSceenSize.getHeight(context) * 0.10,
              color: const Color(0xFFFAFAFA),
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: const Center(
                child: Text(
                  "Enter your info exactly as it appears on your license so Kanan can verify your eligibility to route.",
                  style: AppTextStyle.drhsubheading,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    inputTextField(fName, "First Name *", width: 1),
                    const SizedBox(
                      height: 25,
                    ),
                    inputTextField(lName, "Last Name *", width: 1),
                    const SizedBox(
                      height: 25,
                    ),
                    inputTextField(email, "Email *", width: 1),
                    const SizedBox(
                      height: 25,
                    ),
                    addressView(),
                    customDivider(),
                    selectbox(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
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

  uploadImageBoxView(String hint, String? file, String uploadText) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            readOnly: true,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.check_box,
                color: file != null ? Appcolors.appgreen : Colors.grey,
              ),
              hintText: hint,
              hintStyle: const TextStyle(
                color: Color(0xFF999999),
                fontSize: 12,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00B74C),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 12,
            ),
          ),
          onPressed: () async {
            handleFileUpload(uploadText);
          },
          icon: const Icon(
            Icons.upload,
            size: 15,
          ),
          label: file != null ? const Text("Uploaded") : const Text("Upload"),
        ),
      ],
    );
  }

  selectbox() {
    return Column(
      children: [
        countryValue != "🇮🇳    India"
            ? const SizedBox.shrink()
            : Card(
                child: DottedBorder(
                  color: const Color(0xff2f2f2f),
                  strokeWidth: 1,
                  dashPattern: const [5, 6],
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      inputTextField(aadhar, "Adhaar No. *", width: 0.9),
                      const SizedBox(
                        height: 15,
                      ),
                      uploadImageBoxView('Adhar Upload Front...', afs, "af"),
                      const SizedBox(
                        height: 15,
                      ),
                      uploadImageBoxView('Adhar Upload back...', abs, "ab"),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
        const SizedBox(
          height: 15,
        ),
        countryValue == "🇮🇳    India"
            ? const SizedBox.shrink()
            : Card(
                child: DottedBorder(
                  color: const Color(0xff2f2f2f),
                  strokeWidth: 1,
                  dashPattern: const [5, 6],
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      inputTextField(aadhar, "PassPort No. *", width: 0.9),
                      const SizedBox(
                        height: 15,
                      ),
                      uploadImageBoxView('Passport Upload Front...', afs, "af"),
                      const SizedBox(
                        height: 15,
                      ),
                      uploadImageBoxView('Passport Upload back...', abs, "ab"),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
        const SizedBox(
          height: 15,
        ),
        countryValue != "🇮🇳    India"
            ? const SizedBox.shrink()
            : Card(
                child: DottedBorder(
                  color: const Color(0xff2f2f2f),
                  strokeWidth: 1,
                  dashPattern: const [5, 6],
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      inputTextField(pan, "PAN No. *", width: 0.9),
                      const SizedBox(
                        height: 15,
                      ),
                      uploadImageBoxView('Pan Upload...', ps, "p"),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
        const SizedBox(
          height: 15,
        ),
        Card(
          child: DottedBorder(
            color: const Color(0xff2f2f2f),
            strokeWidth: 1,
            dashPattern: const [5, 6],
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                inputTextField(license, "Licence Number. *", width: 0.9),
                const SizedBox(
                  height: 15,
                ),
                uploadImageBoxView('Licence Upload Front...', lfs, "lf"),
                const SizedBox(
                  height: 15,
                ),
                uploadImageBoxView('Licence Upload back...', lbs, "lb"),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Card(
          child: DottedBorder(
            color: const Color(0xff2f2f2f),
            strokeWidth: 1,
            dashPattern: const [5, 6],
            child: uploadImageBoxView('Upload Photo', pus, "pu"),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          width: AppSceenSize.getWidth(context),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Appcolors.appgreen, // Text color
              padding: const EdgeInsets.all(16), // Button padding
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // Button border radius
              ),
            ),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                check()
                    ? submit()
                    : context.showErrorSnackBar(
                        message: "All fields are required");
                // submit();
              }
            },
            child: const Text("SUBMIT "),
          ),
        )
      ],
    );
  }

  check() {
    if (fName.text.isNotEmpty &&
        lName.text.isNotEmpty &&
        pinCode.text.isNotEmpty &&
        aadhar.text.isNotEmpty &&
        pan.text.isNotEmpty &&
        email.text.isNotEmpty &&
        afs != null &&
        abs != null &&
        ps != null &&
        pus != null) {
      return true;
    }
    return false;
  }

  submit() {
    _provider!.driverProfile = DriverProfile(
      firstname: fName.text,
      lastname: lName.text,
      phone: Provider.of<DriveProfileViewModel>(context, listen: false)
              .currDriverProfile
              ?.phone ??
          "9458942703",
      email: email.text,
      fulladdress: pinCode.text,
      alternatenumber: "",
      aadharnumber: aadhar.text,
      aadharuploadfront: afs,
      aadharuploadback: abs,
      pannumber: pan.text,
      panupload: ps,
      licensenumber: license.text,
      licenseuploadfront: lfs,
      licenseuploadback: lbs,
      photoupload: pus,
      termspolicy: true,
      myrideinsurance: true,
      driverDuty: false,
    );
    setState(() {
      _provider!.loading = true;
    });
    _provider!.makeProfile(context);
  }

  addressView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        inputTextField(pinCode, "Pincode *", width: 0.4),
        const SizedBox(
          height: 15,
        ),
        CSCPicker(
          onCountryChanged: (value) {
            setState(() {
              countryValue = value;
            });

            debugPrint("State Value $countryValue");
          },
          onStateChanged: (value) {
            setState(() {
              stateValue = value ?? "";
            });
          },
          onCityChanged: (value) {
            setState(() {
              cityValue = value ?? "";
            });
          },
        ),
        const SizedBox(
          height: 15,
        ),
        inputTextField(houseNumber, "House No, Building Name *"),
        const SizedBox(
          height: 15,
        ),
        inputTextField(roadName, "Road name, Area, Colony *"),
        const SizedBox(
          height: 15,
        ),
        inputTextField(nearbyPlace, "Add nearby famous landmark"),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }

  inputTextField(TextEditingController controller, String hintText,
      {double width = 1}) {
    return SizedBox(
      width: AppSceenSize.getWidth(context) * width,
      height: 50,
      child: TextFormField(
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            // hintText: hintText,
            labelText: hintText),
      ),
    );
  }
}
