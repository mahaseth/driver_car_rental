import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myride/utils/distance_utils.dart';
import 'package:myride/view_model/driver_status_provider.dart';
import 'package:myride/view_model/trip_viewModel.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../view/for_driver/map_section/map_screen.dart';

class TripWebSocket {
  static WebSocketChannel? channel;
  static bool isDuty = true;
  static int driverId = -1;

  webSocketInit(int id, BuildContext context) {
    debugPrint("Started $id");
    driverId = id;
    if (channel != null || driverId == -1) return;
    channel = WebSocketChannel.connect(
      Uri.parse('ws://3.109.183.75:7401/ws/trip-notify/$id'),
    );
    TripWebSocket().listenSocket(context);
  }

  void listenSocket(context) {
    debugPrint("Listen");

    channel!.stream.listen((message) async {
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
          DriverStatusProvider driverStatus =
              Provider.of<DriverStatusProvider>(context, listen: false);
          if (driverStatus.isRidingValue) {
            return;
          }

          if (await checkDistanceCondition(context, map)) return;

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MapScreenDriver(
                        map: map,
                        screenIndex: 0,
                      )));
        }
      } catch (e) {
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

  void closeChannel() {
    debugPrint("Channel Closed");
    if (channel == null) return;
    channel!.sink.close();
    channel = null;
  }

  Future<bool> checkDistanceCondition(context, map) async {
    TripViewModel viewModel =
        Provider.of<TripViewModel>(context, listen: false);

    await viewModel.getCurrentTrip(context, map["trip_id"]);

    var start = await getCurrentLocation();
    var destination = LatLng(viewModel.currentTrip?.destinationLat ?? 0.0,
        viewModel.currentTrip?.destinationLong ?? 0.0);
    double distanceDouble = calculateDistance(start, destination);
    if (distanceDouble > 5.0) {
      return true;
    }
    return false;
  }
}
