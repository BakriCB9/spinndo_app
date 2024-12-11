import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapMarker {
  final int id;
  final String name;
  final LatLng latLng;
final dynamic color;
  GoogleMapMarker(this.color, {required this.id, required this.name, required this.latLng});
}

List<GoogleMapMarker> markerLocationData = [];
