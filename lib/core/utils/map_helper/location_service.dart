import 'package:app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:location/location.dart';
import 'package:app/core/error/app_exception.dart';
import 'package:permission_handler/permission_handler.dart' as perm;

class LocationService {
  static Location location = Location();

  static Future<bool> checkAndRequestLocationService() async {
    var isServiceEnabld = await location.serviceEnabled();
    if (!isServiceEnabld) {
      isServiceEnabld = await location.requestService();
      if (!isServiceEnabld) {
        return false;
      }
    }
    return true;
  }

  // static Future<Either<Failure, LocationData>>
  //     checkAndRequestLocationPermission() async {
  //   // var permissionStatus = await location.hasPermission();

  //   // if (permissionStatus == PermissionStatus.denied) {
  //   //   permissionStatus = await location.requestPermission();

  //   //   if (permissionStatus != PermissionStatus.granted) {
  //   //     await perm.openAppSettings();
  //   //     return left(Failure(''));
  //   //   }
  //   // }
  //   // final ans = await checkAndRequestLocationService();
  //   // if (!ans) {
  //   //   return left(Failure(''));
  //   // }
  //   // return right(await location.getLocation());
  // }

  static Future<Either<Failure, LocationData>> getLocationData() async {
   
var permissionStatus = await location.hasPermission();

    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();

      if (permissionStatus != PermissionStatus.granted) {
        await perm.openAppSettings();
        return left(Failure(''));
      }
    }
    final ans = await checkAndRequestLocationService();
    if (!ans) {
      return left(Failure(''));
    }
    return right(await location.getLocation());
    
    
  }
}
