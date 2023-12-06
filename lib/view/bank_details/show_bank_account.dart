import 'package:flutter/material.dart';
import 'package:myride/model/bank_model.dart';
import 'package:myride/utils/utils.dart';
import 'package:myride/view/bank_details/bank_details_screen.dart';

class ShowBankAccount extends StatefulWidget {
  final BankAccountModel? model;

  const ShowBankAccount({super.key, this.model});

  @override
  State<ShowBankAccount> createState() => _ShowBankAccountState();
}

class _ShowBankAccountState extends State<ShowBankAccount> {
  final TextEditingController accountNumber = TextEditingController();
  final TextEditingController ifscCode = TextEditingController();
  final TextEditingController bankHolderName = TextEditingController();
  final TextEditingController bankName = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.model != null) {
      accountNumber.text = widget.model?.account ?? "";
      ifscCode.text = widget.model?.ifsc ?? "";
      bankHolderName.text = widget.model?.name ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Bank Account Details"),
        ),
        bottomNavigationBar: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return BankDetailsScreen(
                    model: widget.model,
                  );
                },
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            width: double.infinity,
            height: 50,
            color: const Color(0xFF00B74C),
            padding: const EdgeInsets.all(16),
            child: const Center(
              child: Text(
                'EDIT',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const Text(
                  "Here you can see the details of the bank account you have added."),
              const SizedBox(
                height: 25,
              ),
              textEditingView("Account Holder Number", accountNumber, "Name"),
              textEditingView("Bank Account Number", ifscCode, "Number"),
              textEditingView("IFSC Code", bankHolderName, "IFSC Code"),
              textEditingView("Bank Name", bankName, "Bank name"),
            ],
          ),
        ),
      ),
    );
  }

  textEditingView(title, controller, hinText) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: const TextStyle(fontSize: 12),
          ),
          trailing: SizedBox(
            width: 150,
            child: TextField(
              readOnly: true,
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hinText,
              ),
            ),
          ),
          onTap: () {},
        ),
        customDivider(),
      ],
    );
  }
}
