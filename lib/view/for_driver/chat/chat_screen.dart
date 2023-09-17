// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:myride/constant/app_screen_size.dart';
import 'package:myride/constant/app_text_style.dart';

class Message {
  final String text;
  final bool isMe;

  Message({required this.text, required this.isMe});
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Message> _messages = [];

  void _addMessage(String text, bool isMe) {
    setState(() {
      _messages.add(Message(text: text, isMe: isMe));
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
                const Text("Mrinmay", style: AppTextStyle.phoneverifytext),
                Image.asset(
                  'assets/icon/profile_avatar.png',
                  width: 60,
                  height: 60,
                ),
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

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;

  const MessageBubble({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue : Colors.grey,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class MessageInput extends StatefulWidget {
  final Function(String, bool) onSendMessage;

  const MessageInput(this.onSendMessage, {super.key});

  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    final text = _controller.text;
    if (text.isNotEmpty) {
      widget.onSendMessage(text, true); // Assuming it's sent by the user
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.withOpacity(0.2)),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: 'Type a message...'),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Image.asset('assets/icon/send.png'),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}
