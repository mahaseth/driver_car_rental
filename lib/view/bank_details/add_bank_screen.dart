import 'package:flutter/material.dart';
import 'package:myride/constant/app_color.dart';
import 'package:myride/constant/app_screen_size.dart';
import 'package:myride/model/bank_model.dart';
import 'package:myride/view/bank_details/add_bank_detail.dart';
import 'package:myride/view/bank_details/show_bank_detail.dart';
import 'package:myride/view_model/bank_view_model.dart';
import 'package:provider/provider.dart';

class EmptyBankScreen extends StatefulWidget {
  const EmptyBankScreen({super.key});

  @override
  State<EmptyBankScreen> createState() => _EmptyBankScreenState();
}

class _EmptyBankScreenState extends State<EmptyBankScreen> {
  BankAccountModel? model;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() {
    BankViewModel bankViewModel =
        Provider.of<BankViewModel>(context, listen: false);
    bankViewModel.getBankDetail(context);
  }

  void readData() {
    BankViewModel bankViewModel =
        Provider.of<BankViewModel>(context, listen: true);
    setState(() {
      model = bankViewModel.bankModel;
    });
  }

  @override
  Widget build(BuildContext context) {
    readData();
    if (model != null) {
      return BankAccountDetailScreen(model: model);
    }

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset("assets/icon/add_bank_account.png"),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                width: AppSceenSize.getWidth(context) * 0.7,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddBankAccountScreen(),
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Appcolors.primaryGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Text(
                    "ADD Bank Account",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
