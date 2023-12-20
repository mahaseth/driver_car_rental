import 'package:myride/model/vehicleinfo.dart';

class TripModel {
  bool isActive;
  String status;
  String source;
  String destination;
  double distance;
  String timing;
  int otpCount;
  int customer;
  int driver;
  VehicleModel cabData;
  int rideType;
  double sourceLat = 0.0;
  double sourceLong = 0.0;
  double destinationLat = 0.0;
  double destinationLong = 0.0;
  int id;
  int amount;
  String driverProfilePic;
  String? carIcon;
  String? paymentMode;

  TripModel({
    required this.isActive,
    required this.id,
    required this.status,
    required this.source,
    required this.destination,
    required this.distance,
    required this.timing,
    required this.otpCount,
    required this.customer,
    required this.driver,
    required this.cabData,
    required this.rideType,
    required this.amount,
    required this.driverProfilePic,
    this.carIcon,
    this.paymentMode,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    print(json.toString());
    List<String> source = json['source'].split('#');
    List<String> destination = json['destination'].split('#');

    String destinationText = destination[0];
    String sourceText = source[0];

    TripModel model = TripModel(
      isActive: json['is_active'] ?? false,
      status: json['status'] ?? "",
      driverProfilePic: json['driver_profile_pic'] ?? "",
      source: sourceText,
      destination: destinationText,
      distance: json['distance'] ?? 0.0,
      amount: json['amount'].round() ?? 0,
      timing: json['timing'] ?? "",
      otpCount: json['otp'] ?? 0,
      customer: json['customer'] ?? 0,
      driver: json['driver'] ?? 0,
      cabData: json['cab'] == null
          ? VehicleModel()
          : VehicleModel.fromJson(json['cab']),
      rideType: json['ride_type']?["cab_type"]?["id"] ?? 0,
      id: json['id'] ?? 0,
      carIcon: json['ride_type']?["icon"] ?? "",
      paymentMode: json['payment_choice'] ?? "OTHER",
    );
    try {
      model.sourceLat = double.tryParse(source[1]) ?? 0.0;
      model.sourceLong = double.tryParse(source[2]) ?? 0.0;

      model.destinationLat = double.tryParse(destination[1]) ?? 0.0;
      model.destinationLong = double.tryParse(destination[2]) ?? 0.0;
    } catch (e) {
      print("Formating issue in location in model class");
    }
    return model;
  }

  Map<String, dynamic> toJson() {
    return {
      'is_active': isActive,
      'status': status,
      'source': source,
      'destination': destination,
      'distance': distance,
      'timing': timing,
      'otp_count': otpCount,
      'customer': customer,
      'driver': driver,
      'ride_type': rideType,
    };
  }
}
