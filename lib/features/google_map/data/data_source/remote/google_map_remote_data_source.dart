import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class GoogleMapRemoteDataSource {
  Future<List<String>> getAddressFromCoordinates(double lat, double long);
  Future<LatLng> getCountryLatLng(String countryName) ;
}
