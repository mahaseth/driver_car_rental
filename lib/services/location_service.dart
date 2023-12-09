import 'package:geolocator/geolocator.dart';

class LocationServices {
  late bool serviceEnabled;
  late LocationPermission permission;

  Future<String> checkPermissions() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return "No Error";
  }

  Future<Position> currentLocation() async {
    permission = await Geolocator.checkPermission();
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      await Geolocator.requestPermission();
      return Future.error('Location permissions are denied');
    }
    return await Geolocator.getCurrentPosition();
  }
}
