import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapMarker {
  final int id;
  final String name;
  final LatLng latLng;
  final int providerId;
  final dynamic color;
  GoogleMapMarker(this.color,
      {required this.id, required this.name, required this.latLng ,required this.providerId,});
}

List<GoogleMapMarker> markerLocationData = [];
