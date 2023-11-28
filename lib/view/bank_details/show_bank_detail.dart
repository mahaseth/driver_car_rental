import 'package:flutter/material.dart';
import 'package:myride/constant/app_color.dart';
import 'package:myride/constant/app_screen_size.dart';
import 'package:myride/model/bank_model.dart';
import 'package:myride/view/bank_details/add_bank_detail.dart';
import 'package:myride/view_model/bank_view_model.dart';
import 'package:provider/provider.dart';

class BankAccountDetailScreen extends StatefulWidget {
  final BankAccountModel? model;

  const BankAccountDetailScreen({super.key, required this.model});

  @override
  State<BankAccountDetailScreen> createState() =>
      _BankAccountDetailScreenState();
}

class _BankAccountDetailScreenState extends State<BankAccountDetailScreen> {
  final TextEditingController accountNumber = TextEditingController();
  final TextEditingController ifscCode = TextEditingController();
  final TextEditingController bankHolderName = TextEditingController();
  bool isLoading = false;

  BankAccountModel? get bankData => widget.model;

  @override
  void initState() {
    super.initState();
    accountNumber.text = bankData?.account ?? "";
    ifscCode.text = bankData?.ifsc ?? "";
    bankHolderName.text = bankData?.name ?? "";
  }

  void readData() {
    BankViewModel bankViewModel =
        Provider.of<BankViewModel>(context, listen: true);
    setState(() {
      accountNumber.text = bankViewModel.bankModel?.account ?? "";
      ifscCode.text = bankViewModel.bankModel?.ifsc ?? "";
      bankHolderName.text = bankViewModel.bankModel?.name ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    readData();
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                updateValues();
                              },
                              icon: Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (inContext) {
                                      return AlertDialog(
                                        title:
                                            const Text('Delete Bank Details'),
                                        content: const Text(
                                            'Are you sure you want to delete your bank details'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              BankViewModel bankViewModel =
                                                  Provider.of<BankViewModel>(
                                                      context,
                                                      listen: false);

                                              bankViewModel.deleteBankDetail(
                                                  context,
                                                  bankViewModel.bankModel?.id ??
                                                      1);
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Delete'),
                                          ),
                                        ],
                                      );
                                    });
                              },
                              icon: Icon(Icons.delete)),
                        ],
                      ),
                const SizedBox(
                  height: 25,
                ),
                customTextField(accountNumber, "Account Number"),
                const SizedBox(
                  height: 10,
                ),
                customTextField(ifscCode, "IFSC Code"),
                const SizedBox(
                  height: 10,
                ),
                customTextField(bankHolderName, "Bank Account holder\'s Name"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  updateValues() async {
    BankViewModel bankViewModel =
        Provider.of<BankViewModel>(context, listen: false);

    Map map = {
      'account': accountNumber.text,
      'ifsc': ifscCode.text,
      'name': bankHolderName.text,
      "id": bankViewModel.bankModel?.id ?? 1
    };
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddBankAccountScreen(
            map: map,
          ),
        ));
  }

  buttonWidget(label, onSubmit) {
    return SizedBox(
      width: AppSceenSize.getWidth(context) * 0.4,
      height: 50,
      child: ElevatedButton(
        onPressed: onSubmit,
        style: ElevatedButton.styleFrom(
          backgroundColor: Appcolors.primaryGreen,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  toggleLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  customTextField(controller, label) {
    return TextFormField(
      readOnly: true,
      style: const TextStyle(color: Color(0xff151414)),
      decoration: InputDecoration(
        labelText: label,
        // hintText: hintText,
        labelStyle: const TextStyle(color: Colors.black),
        hintStyle: const TextStyle(color: Colors.black),

        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xff151414), // Custom box border color
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Color(0xff151414), width: 1),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff151414), width: 1),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff151414), width: 1),
        ),
        contentPadding: const EdgeInsets.all(14.0),
      ),
      controller: controller,
    );
  }
}
