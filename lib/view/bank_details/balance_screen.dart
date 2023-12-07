import 'package:flutter/material.dart';
import 'package:myride/model/driverprofile.dart';
import 'package:myride/model/payment_model.dart';
import 'package:myride/services/razor_pay.dart';
import 'package:myride/view/bank_details/bank_details_screen.dart';
import 'package:myride/view/bank_details/show_bank_account.dart';
import 'package:myride/view_model/bank_view_model.dart';
import 'package:myride/view_model/driverprofile_viewmodel.dart';
import 'package:myride/view_model/payment_viewModel.dart';
import 'package:provider/provider.dart';

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({super.key});

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  DriverProfile? driver;
  List<PaymentModel> paymentList = [];

  @override
  void initState() {
    super.initState();
    readData();
  }

  void readData() async {
    DriveProfileViewModel driverProvider =
        Provider.of<DriveProfileViewModel>(context, listen: false);

    PaymentViewModel paymentViewModel =
        Provider.of<PaymentViewModel>(context, listen: false);
    await paymentViewModel.getPaymentHistory();
    setState(() {
      driver = driverProvider.currDriverProfile;
      paymentList = paymentViewModel.paymentList;
    });
  }

  void fetchData() async {
    DriveProfileViewModel driverProvider =
        Provider.of<DriveProfileViewModel>(context, listen: true);

    PaymentViewModel paymentViewModel =
        Provider.of<PaymentViewModel>(context, listen: true);

    setState(() {
      driver = driverProvider.currDriverProfile;
      paymentList = paymentViewModel.paymentList;
    });
  }

  @override
  Widget build(BuildContext context) {
    fetchData();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Wallet"),
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
                columnWiseText("Balance", "Rs ${driver?.walletBalance ?? 0}"),
                columnWiseText(
                    "Available Withdraw", "Rs ${driver?.walletBalance ?? 0}"),
              ],
            ),
            const SizedBox(
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
                  showRechargeDialog(context);
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
                    "Manage", () async {
                  BankViewModel bankViewModel =
                      Provider.of<BankViewModel>(context, listen: false);
                  await bankViewModel.getBankDetail(context);

                  if (bankViewModel.bankModel == null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const BankDetailsScreen();
                        },
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ShowBankAccount(
                            model: bankViewModel.bankModel,
                          );
                        },
                      ),
                    );
                  }
                }),
              ],
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: paymentList.length,
                    itemBuilder: (context, index) {
                      PaymentModel model = paymentList[index];
                      if (model.transactionType == "credit" &&
                          model.isSuccess) {
                        return cardViewItem(
                            const Icon(
                              Icons.add,
                              color: Colors.green,
                            ),
                            "Recharge",
                            // "Trip Amount",
                            "Trip id #${model.orderId}",
                            "Rs ${model.amount}");
                      } else if (model.transactionType == "credit") {
                        return cardViewItem(
                            const Icon(
                              Icons.add,
                              color: Colors.green,
                            ),
                            "Recharge",
                            // "Trip Amount",
                            "Trip id #${model.orderId}",
                            "Rs ${model.amount}",
                            status: "Failed");
                      } else if (index % 3 == 0) {
                        return cardViewItem(
                            const Icon(
                              Icons.money_off_csred_rounded,
                              color: Colors.red,
                            ),
                            "Fine",
                            "Reason :- OverSpeed",
                            "Rs 200",
                            colors: Colors.red);
                      } else if (index % 7 == 0) {
                        return cardViewItem(
                            const Icon(
                              Icons.money_off_csred_rounded,
                              color: Colors.red,
                            ),
                            "Trip deduction",
                            "Trip id #23212",
                            "Rs 200",
                            colors: Colors.red);
                      } else {
                        return cardViewItem(
                            const Icon(
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

  void showRechargeDialog(BuildContext screenContext) {
    showDialog(
      context: screenContext,
      builder: (BuildContext context) {
        bool isLoading = false;
        return StatefulBuilder(
          builder: (context, changeState) {
            return AlertDialog(
              title: const Text('Enter the Amount'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: controller,
                    decoration: const InputDecoration(labelText: 'Amount'),
                  ),
                  const SizedBox(height: 16),
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
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

                                DriveProfileViewModel provider =
                                    Provider.of<DriveProfileViewModel>(context,
                                        listen: false);

                                razor.initRazorPay(
                                    int.parse(controller.text),
                                    provider.driverProfile?.id ?? -1,
                                    screenContext);
                                razor.createOrder(int.parse(controller.text));
                                changeState(() {
                                  isLoading = false;
                                });

                                Navigator.pop(context);
                              },
                              child: const Text('Add'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                // Close the dialog
                              },
                              child: const Text('Cancel'),
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
              title: const Text('Enter the Amount'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: controller,
                    decoration: const InputDecoration(labelText: 'Amount'),
                  ),
                  const SizedBox(height: 16),
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
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
                              child: const Text('Withdraw'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                // Close the dialog
                              },
                              child: const Text('Cancel'),
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
      {Color colors = Colors.green, String? status}) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        child: ListTile(
          leading: icon,
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: Column(
            children: [
              Text(
                amt,
                style: TextStyle(color: colors, fontSize: 18),
              ),
              status != null
                  ? Text(
                      status,
                      style: const TextStyle(color: Colors.red, fontSize: 14),
                    )
                  : const SizedBox.shrink()
            ],
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
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.blue[200],
                borderRadius: BorderRadius.circular(10)),
            child: icon,
          ),
          const SizedBox(
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
