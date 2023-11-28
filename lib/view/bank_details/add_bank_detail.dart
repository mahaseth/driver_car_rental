import 'package:flutter/material.dart';
import 'package:myride/constant/app_color.dart';
import 'package:myride/constant/app_screen_size.dart';
import 'package:myride/utils/utils.dart';
import 'package:myride/view_model/bank_view_model.dart';
import 'package:myride/view_model/driverprofile_viewmodel.dart';
import 'package:provider/provider.dart';

class AddBankAccountScreen extends StatefulWidget {
  final Map? map;

  const AddBankAccountScreen({super.key, this.map});

  @override
  State<AddBankAccountScreen> createState() => _AddBankAccountScreenState();
}

class _AddBankAccountScreenState extends State<AddBankAccountScreen> {
  final TextEditingController accountNumber = TextEditingController();
  final TextEditingController ifscCode = TextEditingController();
  final TextEditingController bankHolderName = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.map != null) {
      accountNumber.text = widget.map?["account"];
      ifscCode.text = widget.map?["ifsc"];
      bankHolderName.text = widget.map?["name"];
    }
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
                SizedBox(
                  height: 10,
                ),
                customTextField(ifscCode, "IFSC Code"),
                SizedBox(
                  height: 10,
                ),
                customTextField(bankHolderName, "Bank Account holder\'s Name"),
                SizedBox(
                  height: 25,
                ),
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : SizedBox(
                        width: AppSceenSize.getWidth(context) * 0.7,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (checkEmptyCondition()) {
                              context.showErrorSnackBar(
                                  message: "Please fill all details");
                              return;
                            }
                            toggleLoading();

                            DriveProfileViewModel provider =
                                Provider.of<DriveProfileViewModel>(context,
                                    listen: false);
                            Map map = {
                              'account': accountNumber.text,
                              'ifsc': ifscCode.text,
                              'name': bankHolderName.text,
                              'driver': provider.currDriverProfile?.id ?? 96,
                            };
                            BankViewModel bankViewModel =
                                Provider.of<BankViewModel>(context,
                                    listen: false);
                            if (widget.map != null) {
                              await bankViewModel.editBankDetail(
                                  context, map, widget.map?["id"]);
                            } else {
                              await bankViewModel.saveBankDetail(context, map);
                            }
                            await bankViewModel.getBankDetail(context);
                            toggleLoading();
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Appcolors.primaryGreen,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          child: const Text(
                            "Add Bank Account",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
              ],
            ),
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

  customTextField(controller, label) {
    return TextFormField(
      style: const TextStyle(color: Color(0xff151414)),
      decoration: InputDecoration(
        labelText: label,
        // hintText: hintText,
        labelStyle: TextStyle(color: Colors.black),
        hintStyle: TextStyle(color: Colors.black),

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

  bool checkEmptyCondition() {
    return textEmpty(accountNumber) | textEmpty(ifscCode) ||
        textEmpty(bankHolderName);
  }

  bool textEmpty(TextEditingController controller) {
    return controller.text.isEmpty;
  }
}
