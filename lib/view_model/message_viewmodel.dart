import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:myride/repository/message_repo.dart';
import 'package:myride/utils/utils.dart';

import '../model/message_model.dart';

class MessageViewModel extends ChangeNotifier {
  final _messageRepo = MessageRepo();

  String roomKey = "";
  List<Message> messageList = [];

  Future<void> getMessageRoom(
      BuildContext context, int senderId, int receiverId) async {
    try {
      final response =
          await _messageRepo.getMessageRoom(context, senderId, receiverId);
      log("RESPONSE GET room Message $response");

      roomKey = response["room"]["room"];
      notifyListeners();
    } catch (e) {
      Utils.showMyDialog(
          "Error in fetching Room details ${e.toString()}", context);
      log('Error GET room Message $e');
    }
  }

  Future<void> getMessages(
      BuildContext context, int senderId, int specificId, String room) async {
    try {
      final response = await _messageRepo.getMessages(context, room);

      log("RESPONSE Cab-Class $response");
      if (response == null) return;

      messageList = List<Message>.from(
        response.map(
          (m) => Message.fromJson(m, senderId),
        ),
      );
      // messageList.removeWhere((message) => message.receiver != specificId);
      notifyListeners();
    } catch (e) {
      Utils.showMyDialog(
          "Error in while fetching the msg ${e.toString()}", context);
      log('Error cab-class $e');
    }
  }
}
