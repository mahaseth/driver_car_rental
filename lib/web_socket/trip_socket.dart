import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myride/utils/utils.dart';
import 'package:myride/view/for_driver/map_section/map_screen.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class TripWebSocket {
  static WebSocketChannel? channel;

  webSocketInit() {
    debugPrint("Started");
    channel = WebSocketChannel.connect(
      Uri.parse('ws://3.109.183.75:7401/ws/trip-notify/96'),
    );
  }

  void listenSocket(context) {
    debugPrint("Listen");
    channel!.stream.listen((message) {
      Map map = jsonDecode(message);
      Utils.showMyDialog("Trip started", context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MapScreenDriver(
                    map: map,
                  )));
    });
  }

  void addMessage(int id) {
    Map data = {
      "driver_id": id,
      "vehicle_id": 2,
    };
    channel!.sink.add(json.encode(data));
  }
}
