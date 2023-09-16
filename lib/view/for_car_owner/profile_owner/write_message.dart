import 'package:flutter/material.dart';

class WriteMessage extends StatefulWidget {
  const WriteMessage({super.key});

  @override
  State<WriteMessage> createState() => _WriteMessageState();
}

class _WriteMessageState extends State<WriteMessage> {
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
            onTap: (){
             
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 44,
              decoration: BoxDecoration(
                  color: Color(0xFF00B74C),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
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
                  icon: Icon(Icons.arrow_back)),
                  SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.only(left:20.0),
                child: Text(
                  "Write Message to Admin",
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


  _buildMessageSection() {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0, left: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text("Subject"),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 40,
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Vehicle Change',
                border: OutlineInputBorder(), // This adds the outline border
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Text("Message"),
          SizedBox(
            height: 10,
          ),
          TextField(
            maxLines: 5,
            decoration: InputDecoration(
              labelText: 'Vehicle Change',
              border: OutlineInputBorder(), // This adds the outline border
            ),
          ),
        ],
      ),
    );
  }
}
