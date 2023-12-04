import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:myride/model/admin_messageModel.dart';
import 'package:myride/repository/admin_support_repo.dart';
import 'package:myride/utils/utils.dart';

class AdminSupportPanel extends ChangeNotifier {
  final _adminRepo = AdminSupportRepo();

  List<AdminMessageModel> messageList = [];

  Future<void> sendMessageAdmin(BuildContext context, Map map) async {
    try {
      final response = await _adminRepo.sendAdminMessage(context, map);
      log("RESPONSE GET Bank $response");

      notifyListeners();
    } catch (e) {
      Utils.showMyDialog(
          "Error in fetching Bank details ${e.toString()}", context);
      log('Error GET Bank $e');
    }
  }

  Future<void> getAllMessages(BuildContext context) async {
    try {
      final response = await _adminRepo.getAdminMessages(context);

      log("RESPONSE Bank $response");
      if (response == null) return;
      try {
        List<dynamic> jsonList = response as List;
        messageList =
            jsonList.map((data) => AdminMessageModel.fromJson(data)).toList();
      } catch (e) {
        debugPrint("Error herer $e");
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
