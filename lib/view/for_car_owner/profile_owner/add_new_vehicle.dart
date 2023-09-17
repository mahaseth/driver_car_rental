import 'package:flutter/material.dart';

class AddNewVehicle extends StatefulWidget {
  const AddNewVehicle({super.key});

  @override
  State<AddNewVehicle> createState() => _AddNewVehicleState();
}

class _AddNewVehicleState extends State<AddNewVehicle> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _buildTopSection(),
            _buildFormSection(),
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
                  icon: const Icon(Icons.arrow_back)),
              const SizedBox(
                height: 50,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
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
              const SizedBox(
                width: 40,
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildFormSection() {
    return const Padding(
      padding: EdgeInsets.only(right: 20.0, left: 20.0),
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
          FractionallySizedBox(
            widthFactor: 0.48,
            child: Padding(
              padding: EdgeInsets.all(8.0),
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
        ],
      ),
    );
  }
}
