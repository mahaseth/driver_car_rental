import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../view/for_driver/map_section/map_screen.dart';

class TripWebSocket {
  static WebSocketChannel? channel;

  webSocketInit(int id, BuildContext context) {
    debugPrint("Started $id");
    if (channel != null) return;
    channel = WebSocketChannel.connect(
      Uri.parse('ws://3.109.183.75:7401/ws/trip-notify/$id'),
    );
    TripWebSocket().listenSocket(context);
  }

  void listenSocket(context) {
    debugPrint("Listen");

    channel!.stream.listen((message) {
      try {
        Map map = jsonDecode(message);
        debugPrint("Message $map");
        if (map["driver_id"] != null || map["status"] == "DRIVER_REJECTED") {
          return;
        }
        if (map["status"] == "CANCELLED") {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(const SnackBar(
              content: Text(
                "Ride has been cancelled by customer",
                style: TextStyle(color: Colors.white),
                maxLines: 2,
              ),
              backgroundColor: Colors.red,
            ));
          Navigator.of(context).popUntil((route) {
            if (route is MaterialPageRoute) {
              String screenName = "(BuildContext) => WelcomeScreenOwner";

              bool condition = ("${route.builder.runtimeType}" == screenName);
              return condition;
            }
            return false;
          });
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MapScreenDriver(
                        map: map,
                        screenIndex: 0,
                      )));
        }
      } catch (e, stack) {
        debugPrint("There is a error in accpeting $e");
      }
    });
  }

  void addMessage(int id, int vehicleId, String status) async {
    Map data = {
      "driver_id": id,
      "vehicle_id": vehicleId,
      "status": status,
    };
    channel!.sink.add(json.encode(data));
  }

  void cancelRideMessage() {
    Map map = {
      "status": "DRIVER_REJECTED",
    };

    channel!.sink.add(json.encode(map));
  }
}
