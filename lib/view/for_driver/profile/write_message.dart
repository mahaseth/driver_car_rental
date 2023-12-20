import 'package:flutter/material.dart';
import 'package:myride/utils/utils.dart';
import 'package:myride/view_model/admin_support_viewModel.dart';
import 'package:provider/provider.dart';

class WriteMessage extends StatefulWidget {
  const WriteMessage({super.key});

  @override
  State<WriteMessage> createState() => _WriteMessageState();
}

class _WriteMessageState extends State<WriteMessage> {
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  void sendMessage() async {
    AdminSupportPanel provider =
        Provider.of<AdminSupportPanel>(context, listen: false);
    Map map = {
      "subject": subjectController.text,
      "message": messageController.text
    };
    await provider.sendMessageAdmin(context, map);
    subjectController.clear();
    messageController.clear();
    context.showSnackBar(message: "Message sent");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _buildTopSection(),
            _buildMessageSection(),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              if (subjectController.text.isEmpty ||
                  messageController.text.isEmpty) {
                context.showErrorSnackBar(message: "Please fill all details");
                return;
              }
              sendMessage();
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 44,
              decoration: BoxDecoration(
                  color: const Color(0xFF00B74C),
                  borderRadius: BorderRadius.circular(10)),
              child: const Center(
                  child: Text(
                "Send Message",
                style: TextStyle(fontSize: 14, color: Colors.white),
              )),
            ),
          ),
        ),
      ),
    );
  }

  _buildTopSection() {
    return Stack(
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              "assets/icon/background.png",
              fit: BoxFit.fill,
            )),
        Positioned(
          bottom: 13,
          left: 0,
          right: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back)),
              const SizedBox(
                height: 50,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  "Write Message to Admin",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(
                width: 40,
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildMessageSection() {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0, left: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Text("Subject"),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 40,
            child: TextField(
              controller: subjectController,
              decoration: const InputDecoration(
                labelText: 'Subject',
                border: OutlineInputBorder(), // This adds the outline border
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          const Text("Message"),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: messageController,
            maxLines: 5,
            decoration: const InputDecoration(
              labelText: 'Write a message',
              border: OutlineInputBorder(), // This adds the outline border
            ),
          ),
        ],
      ),
    );
  }
}
