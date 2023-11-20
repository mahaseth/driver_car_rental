import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../view/for_driver/map_section/map_screen.dart';

class TripWebSocket {
  static WebSocketChannel? channel;

  webSocketInit(int id) {
    debugPrint("Started $id");
    channel = WebSocketChannel.connect(
      Uri.parse('ws://3.109.183.75:7401/ws/trip-notify/$id'),
    );
  }

  void listenSocket(context) {
    debugPrint("Listen");
    channel!.stream.listen((message) {
      Map map = jsonDecode(message);
      if (map["driver_id"] != null) return;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MapScreenDriver(
                    map: map,
                  )));
    });
  }

  void addMessage(int id, int vehicleId) async {
    Map data = {
      "driver_id": id,
      "vehicle_id": vehicleId,
    };
    channel!.sink.add(json.encode(data));
  }
}
