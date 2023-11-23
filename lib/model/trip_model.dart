class TripModel {
  bool isActive;
  String status;
  String source;
  String destination;
  String distance;
  String timing;
  int otpCount;
  int customer;
  int driver;
  int cab;
  int rideType;
  double sourceLat = 0.0;
  double sourceLong = 0.0;
  double destinationLat = 0.0;
  double destinationLong = 0.0;
  int id;

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
    required this.cab,
    required this.rideType,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    List<String> source = json['source'].split('#');
    List<String> destination = json['destination'].split('#');

    String destinationText = destination[0];
    String sourceText = source[0];

    TripModel model = TripModel(
      isActive: json['is_active'] ?? false,
      status: json['status'] ?? "",
      source: sourceText,
      destination: destinationText,
      distance: json['distance'] ?? "",
      timing: json['timing'] ?? "",
      otpCount: json['otp'] ?? 0,
      customer: json['customer'] ?? 0,
      driver: json['driver'] ?? 0,
      cab: json['cab'] ?? 0,
      rideType: json['ride_type']?["cab_type"]?["id"] ?? 0,
      id: json['id'] ?? 0,
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
      'cab': cab,
      'ride_type': rideType,
    };
  }
}
