import 'package:flutter/material.dart';
import 'package:myride/view/for_driver/profile/write_message.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
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
              return WriteMessage();
            }));
          },
          child: Icon(Icons.edit),
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
                  icon: Icon(Icons.arrow_back)),
                  SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.only(left:20.0),
                child: Text(
                  "All Message",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
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
          itemCount: 4,
          separatorBuilder: (context, index) {
            return Divider(
              color: Colors.grey,
            );
          },
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    child: Text('K'),
                    radius: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Admin"),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                          ),
                          Text("1:58pm")
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(
                            "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint."),
                      )
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
