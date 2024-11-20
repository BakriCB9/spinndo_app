import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:snipp/core/di/service_locator.dart';
import 'package:snipp/core/error/app_exception.dart';
import 'package:snipp/core/utils/location_service.dart';
import 'package:snipp/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:snipp/model.dart';

class Mapss extends StatefulWidget {
  static const String routeName = '/map';

  const Mapss({super.key});

  @override
  State<Mapss> createState() => _MapssState();
}

final _authCubit = serviceLocator.get<AuthCubit>();

class _MapssState extends State<Mapss> {
  late CameraPosition initialCameraPosition;
  late LocationService locationService;
  // late Location location;
  bool isFirstCall=true;

  @override
  void initState() {
    initialCameraPosition = CameraPosition(
      target: LatLng(28.312489817005737, 29.495984785207053),
      zoom: 1,
    );
    // location = Location();
    locationService=LocationService();
    // updateMyLocation();
    super.initState();
  }

  void dispose() {
    googleMapController!.dispose();
    super.dispose();
  }

  Set<Marker> markers = {};
   GoogleMapController? googleMapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Map"),
      ),
      body: Stack(
        children: [
          GoogleMap(
            // zoomControlsEnabled: false,
            markers: markers,
            onTap: (argument) async {
              _authCubit.lat = argument.latitude;
              _authCubit.lang = argument.longitude;
//print("dassssssssssssssssssssssssssaaaa");
             // List<Placemark> placemarks = await placemarkFromCoordinates(argument.latitude, argument.longitude);

              // print("name");
              // print(placemarks[0].name);
              // print("street");
              // print(placemarks[0].street);
              // print("isoCountryCode");
              // print(placemarks[0].isoCountryCode);
              // print("country");
              // print(placemarks[0].country);
              // print("postalCode");
              // print(placemarks[0].postalCode);
              // print("administrativeArea");
              // print(placemarks[0].administrativeArea);
              // print("subAdministrativeArea");
              // print(placemarks[0].subAdministrativeArea);
              // print("locality");
              // print(placemarks[0].locality);
              // print("subLocality");
              // print(placemarks[0].subLocality);
              // print("thoroughfare");
              // print(placemarks[0].thoroughfare);
              // print("subThoroughfare");
              // print(placemarks[0].subThoroughfare);
              // places.add(PlaceModel(
              //     id: 1,
              //     name: "your current location",
              //     latLng: LatLng(_authCubit.lat ?? 31, _authCubit.lang ?? 41)));
              // initMarkers();
              // setState(() {});
              try {
                final addressData = await getAddressFromCoordinates(argument.latitude, argument.longitude);

                // Extract address components (example: formatted address)
                print("Address: ${addressData['formatted_address']}");
                print("Name: ${addressData['address_components'][0]['long_name']}"); // Street name, etc.

                // Add location to places list
                places.add(PlaceModel(
                  id: 1,
                  name: addressData['formatted_address'] ?? "Unknown location",
                  latLng: LatLng(_authCubit.lat ?? 31, _authCubit.lang ?? 41),
                ));

                initMarkers();
                setState(() {});
              } catch (e) {
                print("Error fetching address: $e");
              }
            },
            onMapCreated: (controller) {
              googleMapController = controller;
              getLocationData();
            },
            initialCameraPosition: initialCameraPosition,
            // cameraTargetBounds: CameraTargetBounds(
            //   LatLngBounds(
            //     southwest: LatLng(24.84363152706268, 25.762095463302018),
            //     northeast: LatLng(28.224121357993656, 31.123423735434987),
            //   ),
            // ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: () async {
                LocationData cc = await locationService.getLocationData();

                CameraPosition newLocation = CameraPosition(
                    target: LatLng(cc.latitude ?? 25, cc.longitude ?? 55),
                    zoom: 15);

                googleMapController!
                    .animateCamera(CameraUpdate.newCameraPosition(newLocation));
                _authCubit.lat = cc.latitude;
                _authCubit.lang = cc.longitude;
                places.add(PlaceModel(
                    id: 1,
                    name: "your current location",
                    latLng:
                        LatLng(_authCubit.lat ?? 31, _authCubit.lang ?? 41)));
                initMarkers();
                setState(() {});
              },
              child: Text(
                "Get Current Location",
              ),
            ),
          ),
        ],
      ),
    );
  }

  void initMarkers() {
    var myMarker = places
        .map(
          (e) => Marker(
            position: e.latLng,
            infoWindow: InfoWindow(title: e.name),
            markerId: MarkerId(
              e.id.toString(),
            ),
          ),
        )
        .toSet();
    markers.addAll(myMarker);
  }


  void getLocationData() async{
try{
  LocationData ccc= await locationService.getLocationData();
  if(isFirstCall){
    var cameraPosition=CameraPosition(target: LatLng(ccc.latitude!,ccc.longitude!),zoom: 17);
    googleMapController?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    isFirstCall=false;

  }else{
    googleMapController?.animateCamera(CameraUpdate.newLatLng(LatLng(ccc.latitude!, ccc.longitude!)));

  }
  // var myLocationMarker=Marker(markerId: MarkerId("my location"),position: LatLng(ccc.latitude!, ccc.longitude!));
  // markers.add(myLocationMarker);
  _authCubit.lat = ccc.latitude;
  _authCubit.lang = ccc.longitude;
  places.add(PlaceModel(
      id: 1,
      name: "your current location",
      latLng:
      LatLng(ccc.latitude!, ccc.longitude!)));
  initMarkers();
  setState(() {

  });
}on GoogleMapAppException catch (e){}
catch(e){}

  }

  // void updateMyLocation() async {
  //  await locationService.checkAndRequestLocationService();
  //   var hasPermission = await locationService.checkAndRequestLocationPermission();
  //   if (hasPermission) {
  //   getLocationData();
  //   } else {
  //     //
  //   }
  // }
}
//world view 0 ->3
//country view 4->6
//city view 10->12
//street view 13->17
//building view 18->20

Future<Map<String, dynamic>> getAddressFromCoordinates(double latitude, double longitude) async {
  final String apiKey = 'AIzaSyDLKgjHRJUu_v5A0GLTIddfD-B0tXAiKoQ';  // Replace with your API key
  final String url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey';

  try {
    Dio dio = Dio();
    final response = await dio.get(url);

    if (response.statusCode == 200) {
      // Parse the JSON response
      final data = response.data;


      if (data['status'] == 'OK' && data['results'].isNotEmpty) {
        var address = data['results'][0];
        return address; // Return the first result
      } else {
        throw Exception('No results found');
      }
    } else {
      throw Exception('Failed to load geocoding data');
    }
  } catch (e) {
    throw Exception('Error fetching address: $e');
  }
}
