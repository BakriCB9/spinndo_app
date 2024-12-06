import 'package:location/location.dart';
import 'package:app/core/error/app_exception.dart';

class LocationService {
  static Location location = Location();

  static Future<void> checkAndRequestLocationService() async {
    var isServiceEnabld = await location.serviceEnabled();
    if (!isServiceEnabld) {
      isServiceEnabld = await location.requestService();
      if (!isServiceEnabld) {
        throw GoogleMapAppException();
      }
    }
  }

  static Future<void> checkAndRequestLocationPermission() async {
    var permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.deniedForever) {
      throw GoogleMapAppException();
    }
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        throw GoogleMapAppException();
      }
    }
  }

  static Future<LocationData> getLocationData() async {
    await checkAndRequestLocationService();

    await checkAndRequestLocationPermission();
    return await location.getLocation();
  }
}
