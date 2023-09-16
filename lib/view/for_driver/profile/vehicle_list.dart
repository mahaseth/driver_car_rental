import 'package:flutter/material.dart';

class VehicleList extends StatefulWidget {
  const VehicleList({super.key});

  @override
  State<VehicleList> createState() => _VehicleListState();
}

class _VehicleListState extends State<VehicleList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildTopSection(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("VEHICLE LIST"),
                  ),
                  _buildVehicleList(),
                ],
              )
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
          bottom: 2,
          left: 0,
          right: 0,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back)),
                  Text(
                    "Vehicle List",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 40,
                  color: Color(0xFF7676803D),
                  child: Flexible(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildVehicleList() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "assets/icon/vehicle2.png",
                            fit: BoxFit.fill,
                          ),
                          Row(
                            children: [
                              Text("Vehicle 1"),
                              Icon(Icons.more_vert)
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Plate Number",
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "wb58ax1264",
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            "Make:sandip",
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            height: 10,
                            width: 2,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Type:abc",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10.0, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Image.asset(
                                    "assets/icon/frame1.png",
                                    width: 60,
                                    height: 60,
                                  ),
                                  Text("Insurance")
                                ],
                              ),
                              Column(
                                children: [
                                  Image.asset(
                                    "assets/icon/frame2.png",
                                    width: 60,
                                    height: 60,
                                  ),
                                  Text("Registration")
                                ],
                              ),
                              Column(
                                children: [
                                  Image.asset(
                                    "assets/icon/frame3.png",
                                    width: 60,
                                    height: 60,
                                  ),
                                  Text("MOT")
                                ],
                              ),
                              Column(
                                children: [
                                  Image.asset(
                                    "assets/icon/frame4.png",
                                    width: 60,
                                    height: 60,
                                  ),
                                  Text("Additional")
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    
                    
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
