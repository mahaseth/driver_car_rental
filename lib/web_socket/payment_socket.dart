import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myride/utils/utils.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class PaymentWebSocket {
  static WebSocketChannel? channel;

  webSocketInit() {
    debugPrint("Started");
    channel = WebSocketChannel.connect(
      Uri.parse('ws://3.109.183.75:7401/ws/payment-notify/82'),
    );
  }

  void listenSocket(context) {
    debugPrint("Listen");
    channel!.stream.listen((message) {
      debugPrint("Received $message");
      Utils.showMyDialog("Payment Recieved", context);
    });
  }

  void addMessage() {
    Map data = {
      "payment": "true",
    };
    channel!.sink.add(json.encode(data));
  }
}
