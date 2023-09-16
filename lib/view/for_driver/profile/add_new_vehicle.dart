import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddNewVehicle extends StatefulWidget {
  const AddNewVehicle({super.key});

  @override
  State<AddNewVehicle> createState() => _AddNewVehicleState();
}

class _AddNewVehicleState extends State<AddNewVehicle> {
  TextEditingController _controller = TextEditingController();
  String _uploadedFileName = '';

  void handleFileUpload() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        setState(() {
          _uploadedFileName = result.files.single.name!;
        });
      }
    } on PlatformException catch (e) {
      print('Error while picking a file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildTopSection(),
              _buildFormSection(),
            ],
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
          bottom: 13,
          left: 0,
          right: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back)),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Add New Vehicle",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      "SAVE",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 40,
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildFormSection() {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0, left: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Vehicle info",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 14,
          ),
          Text("Vehicle make"),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 40,
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Jack',
                border: OutlineInputBorder(), // This adds the outline border
              ),
            ),
          ),
          SizedBox(
            height: 14,
          ),
          Text("Vehicle Type"),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 40,
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Austin',
                border: OutlineInputBorder(), // This adds the outline border
              ),
            ),
          ),
          SizedBox(
            height: 14,
          ),
          Text("Vehicle Plate Number"),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 40,
            child: TextField(
              decoration: InputDecoration(
                labelText: '8DF2G811',
                border: OutlineInputBorder(), // This adds the outline border
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Upload Certificate*",
            style: TextStyle(fontSize: 20),
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _controller,
                  readOnly: true,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.check_box,
                        color: Colors.grey,
                      ),
                      hintText: 'Insurance Certificate',
                      hintStyle:
                          TextStyle(color: Color(0xFF999999), fontSize: 12),
                      border: InputBorder.none),
                ),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    primary: Color(0xFF00B74C),
                    padding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 12)),
                onPressed: handleFileUpload,
                icon: Icon(
                  Icons.upload,
                  size: 15,
                ),
                label: Text("Upload"),
              ),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _controller,
                  readOnly: true,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.check_box,
                        color: Colors.grey,
                      ),
                      hintText: 'Insurance Certificate',
                      hintStyle:
                          TextStyle(color: Color(0xFF999999), fontSize: 12),
                      border: InputBorder.none),
                ),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    primary: Color(0xFF00B74C),
                    padding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 12)),
                onPressed: handleFileUpload,
                icon: Icon(
                  Icons.upload,
                  size: 15,
                ),
                label: Text("Upload"),
              ),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _controller,
                  readOnly: true,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.check_box,
                        color: Colors.grey,
                      ),
                      hintText: 'Registration Certificate',
                      hintStyle:
                          TextStyle(color: Color(0xFF999999), fontSize: 12),
                      border: InputBorder.none),
                ),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    primary: Color(0xFF00B74C),
                    padding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 12)),
                onPressed: handleFileUpload,
                icon: Icon(
                  Icons.upload,
                  size: 15,
                ),
                label: Text("Upload"),
              ),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _controller,
                  readOnly: true,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.check_box,
                        color: Colors.grey,
                      ),
                      hintText: 'MOT Certificate',
                      hintStyle:
                          TextStyle(color: Color(0xFF999999), fontSize: 12),
                      border: InputBorder.none),
                ),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    primary: Color(0xFF00B74C),
                    padding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 12)),
                onPressed: handleFileUpload,
                icon: Icon(
                  Icons.upload,
                  size: 15,
                ),
                label: Text("Upload"),
              ),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _controller,
                  readOnly: true,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.check_box,
                        color: Colors.grey,
                      ),
                      hintText: 'Additional Document',
                      hintStyle:
                          TextStyle(color: Color(0xFF999999), fontSize: 12),
                      border: InputBorder.none),
                ),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    primary: Color(0xFF00B74C),
                    padding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 12)),
                onPressed: handleFileUpload,
                icon: Icon(
                  Icons.upload,
                  size: 15,
                ),
                label: Text("Upload"),
              ),
            ],
          ),
          FractionallySizedBox(
            widthFactor: 0.48,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Row(
                  children: [
                    Icon(
                      Icons.add_circle_outline,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text("Add More vehicle")
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
