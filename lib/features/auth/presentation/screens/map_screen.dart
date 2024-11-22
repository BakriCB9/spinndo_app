import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:snipp/core/di/service_locator.dart';
import 'package:snipp/core/models/google_map_model.dart';
import 'package:snipp/core/utils/map_helper/geocoding_service.dart';
import 'package:snipp/core/utils/map_helper/google_map_service.dart';
import 'package:snipp/core/utils/map_helper/location_service.dart';
import 'package:snipp/features/auth/presentation/cubit/auth_cubit.dart';

class MapScreen extends StatefulWidget {
  static const String routeName = '/map';

  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

final _authCubit = serviceLocator.get<AuthCubit>();

class _MapScreenState extends State<MapScreen> {
  late CameraPosition initialCameraPosition;
  late LocationService locationService;
  late LatLng currentLatLng;
  late LatLng selectedLatLng;

  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      target: LatLng(34.971491695077844, 38.576888740408094),
      zoom: 10,
    );
    locationService = LocationService();
    super.initState();
  }

  @override
  void dispose() {
    googleMapController!.dispose();
    super.dispose();
  }

  Set<Marker> markers = {};
  GoogleMapController? googleMapController;
  String regionName="";
  String regionName2="";
  var ll;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: ()  {
          showModalBottomSheet(backgroundColor: Colors.white,context: context, builder: (context) {
            return Column(
              children: [
                InkWell(
                  child: const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Select Current Location"),
                      Icon(Icons.add_location,color: Colors.blue,)
                    ],
                  ),
                  onTap: ()async{

         currentLatLng=  await GoogleMapService.initCurrentLocation(googleMapController!);
         initMarkers(markers);
         _authCubit.lat=currentLatLng.latitude;
         _authCubit.lang=currentLatLng.longitude;

         ll=await GeocodingService.getAddressFromCoordinates(currentLatLng.latitude,currentLatLng.longitude);
         _authCubit.location=ll['address_components'][1]['long_name'];

                    Navigator.of(context).pop();
         setState(() {

         });
                  },
                ),
                InkWell(
                  child:  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Select $regionName  Location $regionName2"),
                      const Icon(Icons.directions,color: Colors.blue)
                    ],
                  ),
                  onTap: (){


                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },);
        },
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: const Icon(
          Icons.save,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        title: const Text("Google Map"),
      ),
      body: GoogleMap(
        zoomControlsEnabled: false,
        // minMaxZoomPreference: MinMaxZoomPreference(8, 50),
        markers: markers,
        onTap: (argument) async {
        selectedLatLng=await  GoogleMapService.selectLocation(argument);
        initMarkers(markers);
        _authCubit.lat=selectedLatLng.latitude;
        _authCubit.lang=selectedLatLng.longitude;

     ll=await GeocodingService.getAddressFromCoordinates(selectedLatLng.latitude,selectedLatLng.longitude);
        _authCubit.location=ll['address_components'][2]['long_name'];
        print(_authCubit.location);
        print(selectedLatLng.latitude);
        setState(() {

        });
        },
        onMapCreated: (controller)async {
          googleMapController = controller;

          currentLatLng=  await GoogleMapService.initCurrentLocation(googleMapController!);
          initMarkers(markers);
          _authCubit.lat=currentLatLng.latitude;
          _authCubit.lang=currentLatLng.longitude;

          ll=await GeocodingService.getAddressFromCoordinates(currentLatLng.latitude,currentLatLng.longitude);
          _authCubit.location=ll['address_components'][1]['long_name'];
          setState(() {});
          // getLocationData();
        },
        initialCameraPosition: initialCameraPosition,
        // cameraTargetBounds: CameraTargetBounds(
        //   LatLngBounds(
        //     southwest: LatLng(32.59463582246123, 36.27484717601601),
        //     northeast: LatLng(37.22580755668586, 42.13458933992312),
        //   ),
        // ),
      ),
    );
  }

  static void initMarkers(Set<Marker>markers) {
    var myMarker = markerLocationData
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



//world view 0 ->3
//country view 4->6
//city view 10->12
//street view 13->17
//building view 18->20


}
