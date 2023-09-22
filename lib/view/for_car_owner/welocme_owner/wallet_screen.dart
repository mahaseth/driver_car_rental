import 'package:flutter/material.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  TextStyle get headingStyle =>
      const TextStyle(fontSize: 20, color: Colors.grey);

  TextStyle get valueStyle => const TextStyle(
      fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold);

  Widget spacing({double height = 10}) {
    return SizedBox(
      height: height,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                spacing(),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Total Balance",
                        style: headingStyle,
                      ),
                      spacing(),
                      Text(
                        "₹0",
                        style: valueStyle,
                      )
                    ],
                  ),
                ),
                spacing(height: 40),
                const Divider(
                  color: Color.fromARGB(255, 206, 204, 204),
                  thickness: 2,
                ),
                spacing(height: 20),
                Text(
                  "Amount Added (Unutilised)",
                  style: headingStyle,
                ),
                spacing(),
                Text(
                  "₹0",
                  style: valueStyle,
                ),
                spacing(height: 20),
                const Divider(
                  color: Color.fromARGB(255, 206, 204, 204),
                  thickness: 2,
                ),
                spacing(height: 20),
                Text(
                  "Total Balance",
                  style: headingStyle,
                ),
                spacing(),
                Text(
                  "₹0",
                  style: valueStyle,
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
