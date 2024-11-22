import 'package:location/location.dart';
import 'package:snipp/core/error/app_exception.dart';

class LocationService {
  Location location = Location();

  Future<void> checkAndRequestLocationService() async {
    var isServiceEnabld = await location.serviceEnabled();
    if (!isServiceEnabld) {
      isServiceEnabld = await location.requestService();
      if (!isServiceEnabld) {
        throw GoogleMapAppException();
      }
    }

  }

  Future<void> checkAndRequestLocationPermission() async {
    var permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.deniedForever) {
      throw GoogleMapAppException();
    }
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
     if( permissionStatus!=PermissionStatus.granted)
       {
         throw GoogleMapAppException();

       }
    }

  }
  Future<LocationData> getLocationData( )async{
    await checkAndRequestLocationService();

    await checkAndRequestLocationPermission();
    return await location.getLocation();

  }
}
