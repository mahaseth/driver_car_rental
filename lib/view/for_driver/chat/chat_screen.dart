// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myride/constant/app_screen_size.dart';
import 'package:myride/constant/app_text_style.dart';
import 'package:myride/message_ui/message_bubble.dart';
import 'package:myride/message_ui/message_input_box.dart';
import 'package:myride/model/message_model.dart';
import 'package:myride/view_model/driverprofile_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatScreen extends StatefulWidget {
  final Map map;

  const ChatScreen({super.key, required this.map});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Message> _messages = [];

  Map get data => widget.map;

  final channel = WebSocketChannel.connect(
    Uri.parse('ws://3.109.183.75:7401/ws/chat/odbmowjgfsh82odqtm'),
  );

  void _addMessage(String text, bool isMe) {
    DriveProfileViewModel driverProvider =
        Provider.of<DriveProfileViewModel>(context, listen: false);
    Map msgData = {
      "message": text,
      "sender": driverProvider.currdriverProfile?.id ?? 96,
      "receiver": data["customer_id"] ?? 96,
    };
    channel.sink.add(json.encode(msgData));
  }

  @override
  void initState() {
    super.initState();
    webSocketInit();
  }

  void webSocketInit() {
    DriveProfileViewModel driverProvider =
        Provider.of<DriveProfileViewModel>(context, listen: false);
    int? id = driverProvider.currdriverProfile?.id ?? 96;

    channel.stream.listen((message) {
      Map data = jsonDecode(message);
      debugPrint("Received $message");
      if (id == data["sender"] || id == data["receiver"]) {
        setState(() {
          _messages.add(
              Message(text: data["message"], isMe: (id == data["sender"])));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _buildUserHeaderSection(),
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (ctx, index) {
                  final message = _messages[index];
                  return MessageBubble(
                    message: message.text,
                    isMe: message.isMe,
                  );
                },
              ),
            ),
            MessageInput(_addMessage),
          ],
        ),
      ),
    );
  }

  _buildUserHeaderSection() {
    return Container(
      width: AppSceenSize.getWidth(context) * 1,
      height: AppSceenSize.getHeight(context) * 0.20,
      color: const Color.fromRGBO(36, 46, 66, 1),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(data["name"], style: AppTextStyle.phoneverifytext),
                const CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 25,
                  child: Icon(
                    Icons.person,
                    size: 45,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
