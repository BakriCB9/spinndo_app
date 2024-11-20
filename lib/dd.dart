
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Vfd {
  final int id;
  final String name;
  final LatLng latLng;

  Vfd({required this.id, required this.name, required this.latLng});


}

List<Vfd> aa =[];
main(){
  Set<Marker> markers = {};

  var myMarker = aa
      .map(
        (e) => Marker(
      position: e.latLng,
      infoWindow: InfoWindow(title: e.name),
      markerId: MarkerId(
        e.id.toString(),
      ),
    ),
  ).toSet();
  markers.addAll(myMarker);

  print("object");
  print(aa);
  print(aa[0].name);
  print(aa[1].name);
  print("object");
  List<String>a=["a","b"];
  print(a);
}