import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myride/utils/utils.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class PaymentWebSocket {
  static WebSocketChannel? channel;

  webSocketInit(int tripId) {
    debugPrint("Started");
    channel = WebSocketChannel.connect(
      Uri.parse('ws://http://13.200.69.54/:7401/ws/payment-notify/$tripId'),
    );
  }

  void listenSocket(context) {
    debugPrint("Listen");
    channel!.stream.listen((message) {
      debugPrint("Received $message");
      Utils.showMyDialog("Payment Recieved", context);
      channel!.sink.close();
    });
  }

  void addMessage() {
    Map data = {
      "payment": "true",
    };
    channel!.sink.add(json.encode(data));
  }
}
