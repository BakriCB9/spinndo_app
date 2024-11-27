import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapMarker {
  final int id;
  final String name;
  final LatLng latLng;

  GoogleMapMarker({required this.id, required this.name, required this.latLng});
}

List<GoogleMapMarker> markerLocationData = [];
