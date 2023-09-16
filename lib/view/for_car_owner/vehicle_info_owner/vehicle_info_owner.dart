import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myride/constant/app_screen_size.dart';
import 'package:myride/constant/app_text_style.dart';
import 'package:myride/view/for_car_owner/submit_owner/submit_owner.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:myride/constant/app_screen_size.dart';
// import 'package:myride/constant/app_text_style.dart';
// import 'package:myride/view/for_driver/submit/submit.dart';

class Car {
  final String name;

  Car({required this.name});
}

class VehicleInfoOwner extends StatefulWidget {
  const VehicleInfoOwner({super.key});

  @override
  State<VehicleInfoOwner> createState() => _VehicleInfoOwnerState();
}

enum SingingCharacter { lafayette, jefferson }

class _VehicleInfoOwnerState extends State<VehicleInfoOwner> {
  SingingCharacter? _character = SingingCharacter.lafayette;

  final TextEditingController _controller = TextEditingController();
  String _uploadedFileName = '';

  void handleFileUpload() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        setState(() {
          _uploadedFileName = result.files.single.name;
        });
      }
    } on PlatformException catch (e) {
      print('Error while picking a file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Vehicle",
          style: TextStyle(color: Color(0xFF333333)),
        ),
      ),
      body: ListView(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                coustomline(),
                coustomline(),
                coustomline(),
                coustomline(),
              ],
            ),
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
            )),
          ),
          Column(
            children: [
              ListTile(
                title: const Text("Vehicle Make"),
                trailing: const Text("Tata Motors"),
                onTap: () {
                  vehiclemakeBottomSheet();
                },
              ),
              customDivider(),
              ListTile(
                title: const Text("Vehicle Model"),
                trailing: const Text("Hatchback"),
                onTap: () {
                  vehiclemodeBottomSheet();
                },
              ),
              customDivider(),
              const ListTile(
                title: Text("Vehicle Plate Number"),
                trailing: Text("BS 730 US"),
              ),
              selectbox(),
            ],
          )
        ],
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SubmitScreenOwner(),
              ));
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: double.infinity,
          height: 50,
          color: const Color(0xFF00B74C),
          padding: const EdgeInsets.all(16),
          child: const Center(
            child: Text(
              'Save & Continue',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  customDivider() {
    return Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: const Divider(
          color: Color.fromARGB(255, 206, 204, 204),
        ));
  }

  selectbox() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: DottedBorder(
            color: const Color(0xFFdddddd),
            strokeWidth: 1,
            dashPattern: const [5, 6],
            child: Container(
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _controller,
                      readOnly: true,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.check_box,
                            color: Colors.green,
                          ),
                          hintText: 'Insurance Certificate',
                          hintStyle:
                              TextStyle(color: Color(0xFF999999), fontSize: 12),
                          border: InputBorder.none),
                    ),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF999999),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 12)),
                    onPressed: handleFileUpload,
                    icon: const Icon(
                      Icons.cancel,
                      size: 15,
                    ),
                    label: const Text("Cancle"),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: DottedBorder(
            color: const Color(0xFFdddddd),
            strokeWidth: 1,
            dashPattern: const [5, 6],
            child: Container(
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _controller,
                      readOnly: true,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.check_box,
                            color: Colors.green,
                          ),
                          hintText: 'Insurance Certificate',
                          hintStyle:
                              TextStyle(color: Color(0xFF999999), fontSize: 12),
                          border: InputBorder.none),
                    ),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF999999),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 12)),
                    onPressed: handleFileUpload,
                    icon: const Icon(
                      Icons.cancel,
                      size: 15,
                    ),
                    label: const Text("Cancle"),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: DottedBorder(
            color: const Color(0xFFdddddd),
            strokeWidth: 1,
            dashPattern: const [5, 6],
            child: Container(
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _controller,
                      readOnly: true,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.check_box,
                            color: Colors.green,
                          ),
                          hintText: 'Insurance Certificate',
                          hintStyle:
                              TextStyle(color: Color(0xFF999999), fontSize: 12),
                          border: InputBorder.none),
                    ),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF999999),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 12)),
                    onPressed: handleFileUpload,
                    icon: const Icon(
                      Icons.cancel,
                      size: 15,
                    ),
                    label: const Text("Cancle"),
                  ),
                ],
              ),
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
    showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Vehicle make",
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
            ListTile(
              title: const Text('Lafayette'),
              leading: Radio<SingingCharacter>(
                value: SingingCharacter.lafayette,
                groupValue: _character,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Thomas Jefferson'),
              leading: Radio<SingingCharacter>(
                value: SingingCharacter.jefferson,
                groupValue: _character,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
            ),
          ]),
        );
      },
    );
  }

  vehiclemodeBottomSheet() {
    showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Vehicle model",
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
            ListTile(
              title: const Text('Lafayette'),
              leading: Radio<SingingCharacter>(
                value: SingingCharacter.lafayette,
                groupValue: _character,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Thomas Jefferson'),
              leading: Radio<SingingCharacter>(
                value: SingingCharacter.jefferson,
                groupValue: _character,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
            ),
          ]),
        );
      },
    );
  }
}
