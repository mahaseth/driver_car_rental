import 'package:flutter/material.dart';

class MessageInput extends StatefulWidget {
  final Function(String, bool) onSendMessage;

  MessageInput(this.onSendMessage);

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
