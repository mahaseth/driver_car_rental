import 'package:flutter/material.dart';
import 'package:myride/constant/app_text_style.dart';
import 'package:myride/view/for_driver/payment-amount/payment.dart';

class AdditionalScreen extends StatefulWidget {
  const AdditionalScreen({super.key});

  @override
  State<AdditionalScreen> createState() => _AdditionalScreenState();
}

class _AdditionalScreenState extends State<AdditionalScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  int _selectedIndex = 0;
  bool light0 = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MaterialStateProperty<Icon?> thumbIcon =
        MaterialStateProperty.resolveWith<Icon?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return const Icon(Icons.check);
        }
        return const Icon(Icons.close);
      },
    );
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Stack(
                children: [
                  Container(
                    child: Column(
                      children: [Image.asset("assets/images/headerbg.png")],
                    ),
                  ),
                   IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: Icon(Icons.arrow_back)),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.10,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      padding: EdgeInsets.symmetric(
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
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PaymentScreen(),
                                            ));
                                      },
                                      child: Text(
                                        "Welcome, Manas",
                                        style: AppTextStyle.welcommehead,
                                      )),
                                  Text(
                                    "Kolkata | #837494",
                                    style: AppTextStyle.welcomesubheading,
                                  )
                                ],
                              ),
                              Icon(Icons.notifications_none)
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            _buildBodySection()
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/truck-fast.png"),
            label: 'Route',
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/map.png"),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/user-square.png"),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor:
            Color(0xFF058F2C), // Change this to your desired active color
      ),
    );
  }

  _buildBodySection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(
                'Booking Date :-   ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("12/6/2023  to 13/06/2023"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset('assets/icon/car.png'),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'MARUTI SUZUKI',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text("sWIFT vDI"),
                          SizedBox(
                            width: 70,
                          ),
                          Text("₹160/hr"),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text('Veh.No :   WB 21 DV 1264'),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Includes 120 kms with Fuel',
                  ),
                  Text(
                    "Total duration: 1 day 3hrs",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Total Earning:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("3500/-"),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                'Pick-up Location :-',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                " Drive, Hyderabad, Hyderabad \nWednesday, August 2, 2023, 02:30 PM",
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                'Drop-Off  Location :-',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                " Drive, Hyderabad, Hyderabad \nWednesday, August 2, 2023, 02:30 PM",
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color(0xFF127331).withOpacity(0.2)),
                child: Center(
                    child: Text(
                  'Download Tax Invoice ',
                  style: TextStyle(fontSize: 20),
                )),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color(0xFFED1212).withOpacity(0.2)),
                child: Center(
                    child: Text(
                  'Report An Accident ',
                  style: TextStyle(fontSize: 20),
                )),
              )
            ],
          ),
        ],
      ),
    );
  }
}
