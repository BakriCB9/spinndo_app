import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapModel {
  final int id;
  final String name;
  final LatLng latLng;

  GoogleMapModel({required this.id, required this.name, required this.latLng});
}
