class LocationData {
  String location;
  double latitude;
  double longitude;

  LocationData({
    required this.location,
    required this.latitude,
    required this.longitude,
  });
}

LocationData parseLocationString(String locationString) {
  // Split the input string using the '#' character
  List<String> parts = locationString.split('#');

  // Ensure that the string has the correct format
  if (parts.length != 3) {
    throw const FormatException("Invalid location string format");
  }

  // Extract the values
  String location = parts[0];
  double latitude = double.parse(parts[1]);
  double longitude = double.parse(parts[2]);

  // Create and return a LocationData object
  return LocationData(
    location: location,
    latitude: latitude,
    longitude: longitude,
  );
}
