import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:snipp/core/error/app_exception.dart';
import 'package:snipp/core/utils/map_helper/geocoding_service.dart';
import 'package:snipp/core/utils/map_helper/location_service.dart';

import '../../models/google_map_model.dart';

class GoogleMapService {


  static Future<LatLng> initCurrentLocation(GoogleMapController googleMapController) async {
    try {
      LocationData getCurrentLocation = await LocationService.getLocationData();

      CameraPosition newLocation = CameraPosition(
          target: LatLng(
              getCurrentLocation.latitude!, getCurrentLocation.longitude!),
          zoom: 15);
      googleMapController
          .animateCamera(CameraUpdate.newCameraPosition(newLocation));

      markerLocationData.add(GoogleMapModel(
          id: 1,
          name: "your current location",
          latLng: LatLng(getCurrentLocation.latitude!,getCurrentLocation.longitude!)));
      print("asddddddddddddddddddd");

      print(getCurrentLocation);
print("asddddddddddddddddddd");
      return LatLng(getCurrentLocation.latitude!, getCurrentLocation.longitude!);
    } on GoogleMapAppException catch (e) {
      rethrow ;

    } catch (e) {
      rethrow ;

    }
  }

  static Future<LatLng> selectLocation(LatLng selectedLocation) async {


    try {


      markerLocationData.add(GoogleMapModel(
        id: 1,
        name: "ds",
        latLng: LatLng(selectedLocation.latitude, selectedLocation.longitude),
      ));

      return LatLng( selectedLocation.latitude,  selectedLocation.longitude);
    } catch (e) {
      rethrow;
    }
  }
}
