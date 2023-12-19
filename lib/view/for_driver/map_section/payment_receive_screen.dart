import 'package:flutter/material.dart';
import 'package:myride/constant/app_color.dart';
import 'package:myride/constant/app_screen_size.dart';
import 'package:myride/model/trip_model.dart';
import 'package:myride/repository/payment_repo.dart';
import 'package:myride/view/for_driver/map_section/rating.dart';
import 'package:myride/view_model/trip_viewModel.dart';
import 'package:provider/provider.dart';

class TipsScreen extends StatefulWidget {
  const TipsScreen({super.key});

  @override
  State<TipsScreen> createState() => _TipsScreenState();
}

class _TipsScreenState extends State<TipsScreen> {
  // int tipIndex = 0;

  TripModel? model;
  String imageUrl = "";

  @override
  void initState() {
    super.initState();
    readData();
  }

  void readData() async {
    TripViewModel provider = Provider.of<TripViewModel>(context, listen: false);

    int amt = (provider.currentTrip?.amount ?? 0);
    Map map = {"amount": amt * 100, "trip_id": provider.currentTrip?.id ?? 297};
    await RazorPayRepo().createQrCode(map);
    setState(() {
      model = provider.currentTrip!;
      imageUrl = RazorPayRepo.qrImage;
    });
  }

  Widget paymentShowView() {
    if (model == null) {
      return const Center(child: CircularProgressIndicator());
    }
    TextStyle style = const TextStyle(
        color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold);
    TripViewModel viewModel =
        Provider.of<TripViewModel>(context, listen: false);
    if ((viewModel.currentTrip?.paymentMode ?? "") == "QR_CODE" ||
        (viewModel.currentTrip?.paymentMode ?? "") == "CASH") {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              "Take cash or show Qr Code to customer for ₹${model?.amount ?? 0}",
              style: style,
            ),
            Image.network(
              imageUrl,
              height: 500,
              width: 250,
            )
          ],
        ),
      );
    } else {
      return Text(
        "Please don't accpet any payments",
        style: style,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // readData();

    return Scaffold(
        backgroundColor: Appcolors.mainbg,
        appBar: AppBar(
          shadowColor: const Color.fromARGB(0, 255, 193, 7),
          centerTitle: true,
          backgroundColor: Appcolors.mainbg,
          title: const Text("Payment"),
        ),
        body: Container(
          height: AppSceenSize.getHeight(context) * 0.75,
          width: AppSceenSize.getWidth(context) * 0.90,
          margin: EdgeInsets.only(
              left: AppSceenSize.getWidth(context) * 0.05,
              top: AppSceenSize.getHeight(context) * 0.05),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              paymentShowView(),
              const SizedBox(height: 10.0),
              Container(
                width: AppSceenSize.getWidth(context) * 0.90,
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF28B910),
                  ),
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RatingScreen(),
                        ));
                  },
                  child: const Text('Paid'),
                ),
              ),
            ],
          ),
        ));
  }
}
