import 'package:flutter/material.dart';
import 'package:myride/services/razor_pay.dart';

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({super.key});

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wallet"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                columnWiseText("Balance", "Rs 1000"),
                columnWiseText("Available Withdraw", "Rs 400"),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buttonCustom(
                    const Icon(
                      Icons.add,
                      size: 40,
                      color: Colors.white,
                    ),
                    "Recharge", () {
                  showRecharegDialog(context);
                }),
                buttonCustom(
                    const Icon(
                      Icons.monetization_on_outlined,
                      size: 40,
                      color: Colors.white,
                    ),
                    "Withdraw", () {
                  _showWithDrawDialog(context);
                }),
                buttonCustom(
                    const Icon(
                      Icons.settings,
                      size: 40,
                      color: Colors.white,
                    ),
                    "Manage",
                    () {}),
              ],
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      if (index % 2 == 0) {
                        return cardViewItem(
                            Icon(
                              Icons.add,
                              color: Colors.green,
                            ),
                            "Trip Amount",
                            "Trip id #23212",
                            "Rs 200");
                      } else if (index % 5 == 0) {
                        return cardViewItem(
                            Icon(
                              Icons.monetization_on,
                              color: Colors.green,
                            ),
                            "Bonus",
                            "Trip id #23212",
                            "Rs 200");
                      } else if (index % 3 == 0) {
                        return cardViewItem(
                            Icon(
                              Icons.money_off_csred_rounded,
                              color: Colors.red,
                            ),
                            "Fine",
                            "Reason :- OverSpeed",
                            "Rs 200",
                            colors: Colors.red);
                      } else if (index % 7 == 0) {
                        return cardViewItem(
                            Icon(
                              Icons.money_off_csred_rounded,
                              color: Colors.red,
                            ),
                            "Trip deduction",
                            "Trip id #23212",
                            "Rs 200",
                            colors: Colors.red);
                      } else {
                        return cardViewItem(
                            Icon(
                              Icons.money_off_csred_rounded,
                              color: Colors.red,
                            ),
                            "Withdrawal",
                            "02-Jan-2024 10:30 PM",
                            "Rs 200",
                            colors: Colors.red);
                      }
                    }))
          ],
        ),
      ),
    );
  }

  TextEditingController controller = TextEditingController();

  void showRecharegDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        bool isLoading = false;
        return StatefulBuilder(
          builder: (context, changeState) {
            return AlertDialog(
              title: Text('Enter the Amount'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: controller,
                    decoration: InputDecoration(labelText: 'Amount'),
                  ),
                  SizedBox(height: 16),
                  isLoading
                      ? Center(child: CircularProgressIndicator())
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                String couponCode = controller.text;
                                debugPrint(couponCode);
                                changeState(() {
                                  isLoading = true;
                                });

                                RazorPayUtils razor = RazorPayUtils();

                                razor.initRazorPay(int.parse(controller.text));
                                razor.createOrder(int.parse(controller.text));
                                changeState(() {
                                  isLoading = false;
                                });

                                Navigator.pop(context);
                              },
                              child: Text('Add'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                // Close the dialog
                              },
                              child: Text('Cancel'),
                            ),
                          ],
                        ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showWithDrawDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        bool isLoading = false;
        return StatefulBuilder(
          builder: (context, changeState) {
            return AlertDialog(
              title: Text('Enter the Amount'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: controller,
                    decoration: InputDecoration(labelText: 'Amount'),
                  ),
                  SizedBox(height: 16),
                  isLoading
                      ? Center(child: CircularProgressIndicator())
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                String couponCode = controller.text;
                                debugPrint(couponCode);
                                changeState(() {
                                  isLoading = true;
                                });

                                changeState(() {
                                  isLoading = false;
                                });

                                Navigator.pop(context);
                              },
                              child: Text('Withdraw'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                // Close the dialog
                              },
                              child: Text('Cancel'),
                            ),
                          ],
                        ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget cardViewItem(icon, title, subtitle, amt,
      {Color colors = Colors.green}) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        child: ListTile(
          leading: icon,
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: Text(
            amt,
            style: TextStyle(color: colors, fontSize: 18),
          ),
        ),
      ),
    );
  }

  Widget buttonCustom(Icon icon, String title, function) {
    return GestureDetector(
      onTap: function,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.blue[200],
                borderRadius: BorderRadius.circular(10)),
            child: icon,
          ),
          SizedBox(
            height: 10,
          ),
          Text(title)
        ],
      ),
    );
  }

  Widget columnWiseText(String title, String value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        Text(
          value,
          style: const TextStyle(fontSize: 24),
        )
      ],
    );
  }
}
