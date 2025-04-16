import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapModel {
  final int id;
  final String name;
  final LatLng latLng;
  final dynamic color;

  GoogleMapModel(this.color,
      {required this.id, required this.name, required this.latLng});
}
