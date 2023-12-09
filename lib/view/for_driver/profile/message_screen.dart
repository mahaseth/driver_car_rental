import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myride/model/admin_messageModel.dart';
import 'package:myride/view/for_driver/profile/write_message.dart';
import 'package:myride/view_model/admin_support_viewModel.dart';
import 'package:provider/provider.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  List<AdminMessageModel> messageList = [];

  @override
  void initState() {
    super.initState();
    readData();
  }

  void readData() async {
    AdminSupportPanel provider =
        Provider.of<AdminSupportPanel>(context, listen: false);
    await provider.getAllMessages(context);
    setState(() {
      messageList = provider.messageList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [_buildTopSection(), _buildListOfNotification()],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const WriteMessage();
            }));
          },
          child: const Icon(Icons.edit),
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
                  "All Message",
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

  _buildListOfNotification() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: ListView.separated(
          itemCount: messageList.length,
          separatorBuilder: (context, index) {
            return const Divider(
              color: Colors.grey,
            );
          },
          itemBuilder: (context, index) {
            AdminMessageModel model = messageList[index];
            String formattedDate =
                DateFormat('dd-MM-yyyy , h:mm a').format(model.createdAt);

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    child: Text('A'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(formattedDate),
                      Text("Subject :- ${model.subject}"),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Text(
                            model.message,
                            overflow: TextOverflow.clip,
                          ))
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
