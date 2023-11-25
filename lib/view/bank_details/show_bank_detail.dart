import 'package:flutter/material.dart';
import 'package:myride/constant/app_color.dart';
import 'package:myride/constant/app_screen_size.dart';
import 'package:myride/model/bank_model.dart';
import 'package:myride/utils/utils.dart';
import 'package:myride/view_model/bank_view_model.dart';
import 'package:myride/view_model/driverprofile_viewmodel.dart';
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
  bool isReadable = true;
  String editText = "Edit";

  BankAccountModel? get bankData => widget.model;

  @override
  void initState() {
    super.initState();
    accountNumber.text = bankData?.account ?? "";
    ifscCode.text = bankData?.ifsc ?? "";
    bankHolderName.text = bankData?.name ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                customTextField(accountNumber, "Account Number"),
                const SizedBox(
                  height: 10,
                ),
                customTextField(ifscCode, "IFSC Code"),
                const SizedBox(
                  height: 10,
                ),
                customTextField(bankHolderName, "Bank Account holder\'s Name"),
                const SizedBox(
                  height: 25,
                ),
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buttonWidget(editText, () {
                            setState(() {
                              isReadable = !isReadable;
                              editText = isReadable ? "Edit" : "Save";
                            });
                            if (isReadable) {
                              // updateValues();
                              context.showErrorSnackBar(
                                  message: "Bidyut working on it");
                            }
                          }),
                          buttonWidget(
                            "Delete",
                            () async {
                              // BankViewModel bankViewModel =
                              //     Provider.of<BankViewModel>(context,
                              //         listen: false);
                              // bankViewModel.deleteBankDetail(
                              //     context, bankViewModel.bankModel?.id ?? 1);
                              context.showErrorSnackBar(
                                  message: "Bidyut working on it");
                            },
                          )
                        ],
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  updateValues() async {
    toggleLoading();

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
    await bankViewModel.editBankDetail(
        context, map, bankViewModel.bankModel?.id ?? 1);
    await bankViewModel.getBankDetail(context);
    toggleLoading();
    Navigator.of(context).pop();
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
      readOnly: isReadable,
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
