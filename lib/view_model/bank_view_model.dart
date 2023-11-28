import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:myride/model/bank_model.dart';
import 'package:myride/repository/bank_repo.dart';
import 'package:myride/utils/utils.dart';

class BankViewModel extends ChangeNotifier {
  final _bankRepo = BankAccountRepo();

  BankAccountModel? bankModel;

  Future<void> saveBankDetail(BuildContext context, Map map) async {
    try {
      final response = await _bankRepo.saveBankDetail(context, map);
      log("RESPONSE GET Bank $response");

      notifyListeners();
    } catch (e) {
      Utils.showMyDialog(
          "Error in fetching Bank details ${e.toString()}", context);
      log('Error GET Bank $e');
    }
  }

  Future<void> editBankDetail(BuildContext context, Map map, int id) async {
    try {
      final response = await _bankRepo.editBankDetail(context, map, id);
      log("RESPONSE GET Bank $response");

      notifyListeners();
    } catch (e) {
      Utils.showMyDialog(
          "Error in fetching Bank details ${e.toString()}", context);
      log('Error GET Bank $e');
    }
  }

  Future<void> deleteBankDetail(BuildContext context, int id) async {
    try {
      final response = await _bankRepo.deleteBankDetail(context, id);
      log("RESPONSE delete Bank $response");
      bankModel = null;
      notifyListeners();
    } catch (e) {
      Utils.showMyDialog(
          "Error in fetching Bank details ${e.toString()}", context);
      log('Error delete Bank $e');
    }
  }

  Future<void> getBankDetail(BuildContext context) async {
    try {
      final response = await _bankRepo.getBankDetail(context);

      log("RESPONSE Bank $response");
      if (response == null) return;
      try {
        bankModel = BankAccountModel.fromJson(response[0]);
      } catch (e) {
        return;
      }
      notifyListeners();
    } catch (e) {
      Utils.showMyDialog(
          "Error in while fetching the Bank ${e.toString()}", context);
      log('Error cab-class $e');
    }
  }
}
