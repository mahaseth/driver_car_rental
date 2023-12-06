import 'package:flutter/material.dart';
import 'package:myride/model/bank_model.dart';
import 'package:myride/utils/utils.dart';
import 'package:myride/view_model/bank_view_model.dart';
import 'package:myride/view_model/driverprofile_viewmodel.dart';
import 'package:provider/provider.dart';

class BankDetailsScreen extends StatefulWidget {
  final BankAccountModel? model;

  const BankDetailsScreen({super.key, this.model});

  @override
  State<BankDetailsScreen> createState() => _BankDetailsScreenState();
}

class _BankDetailsScreenState extends State<BankDetailsScreen> {
  final TextEditingController accountNumber = TextEditingController();
  final TextEditingController ifscCode = TextEditingController();
  final TextEditingController bankHolderName = TextEditingController();
  final TextEditingController bankName = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.model != null) {
      accountNumber.text = widget.model?.account ?? "";
      ifscCode.text = widget.model?.ifsc ?? "";
      bankHolderName.text = widget.model?.name ?? "";
    }
  }

  bool checkEmptyCondition() {
    return textEmpty(accountNumber) | textEmpty(ifscCode) ||
        textEmpty(bankHolderName);
  }

  bool textEmpty(TextEditingController controller) {
    return controller.text.isEmpty;
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
          onTap: () async {
            if (checkEmptyCondition()) {
              context.showErrorSnackBar(message: "Please fill all details");
              return;
            }

            DriveProfileViewModel provider =
                Provider.of<DriveProfileViewModel>(context, listen: false);
            Map map = {
              'account': accountNumber.text,
              'ifsc': ifscCode.text,
              'name': bankHolderName.text,
              'driver': provider.currDriverProfile?.id ?? 96,
            };
            BankViewModel bankViewModel =
                Provider.of<BankViewModel>(context, listen: false);
            if (widget.model != null) {
              await bankViewModel.editBankDetail(
                  context, map, widget.model?.id ?? -1);
            } else {
              await bankViewModel.saveBankDetail(context, map);
            }
            await bankViewModel.getBankDetail(context);
            toggleLoading();
            Navigator.of(context).pop();
          },
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  width: double.infinity,
                  height: 50,
                  color: const Color(0xFF00B74C),
                  padding: const EdgeInsets.all(16),
                  child: const Center(
                    child: Text(
                      'Submit',
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
                  "Enter your info exactly as it appears on your license so Kanan can verify your eligibility to route"),
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

  toggleLoading() {
    setState(() {
      isLoading = !isLoading;
    });
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
