import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myride/model/vehicleinfo.dart';
import 'package:myride/utils/utils.dart';
import 'package:myride/view/for_driver/map_section/map_screen.dart';
import 'package:myride/view_model/driverprofile_viewmodel.dart';
import 'package:myride/view_model/vehicleinfo_viewmodel.dart';
import 'package:provider/provider.dart';
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
      DriveProfileViewModel provider =
          Provider.of<DriveProfileViewModel>(context, listen: false);
      VehicleInfoViewModel providerVehicle =
          Provider.of<VehicleInfoViewModel>(context, listen: false);

      List<VehicleInfoo> vehicleList = providerVehicle.vehicleList;
      if (provider.driverProfile == null || vehicleList.isEmpty) return;
      addMessage(provider.driverProfile!.id ?? 96, vehicleList[0].id ?? 2);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MapScreenDriver(
                    map: map,
                  )));
      channel!.sink.close();
    });
  }

  void addMessage(int id, int vehicleId) {
    Map data = {
      "driver_id": id,
      "vehicle_id": vehicleId,
    };
    channel!.sink.add(json.encode(data));
  }
}
