import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:snipp/features/auth/presentation/cubit/auth_cubit.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/utils/map_helper/geocoding_service.dart';
import '../../../../core/utils/map_helper/google_map_service.dart';
import '../../domain/entities/google_map_marker.dart';
import '../cubit/service_cubit.dart';

class ServiceMapScreen extends StatefulWidget {
  static const String routeName = '/serviceMap';

  const ServiceMapScreen({super.key});

  @override
  State<ServiceMapScreen> createState() => _ServiceMapScreenState();
}

class _ServiceMapScreenState extends State<ServiceMapScreen> {
  late CameraPosition initialCameraPosition;
  final _serviceCubit = serviceLocator.get<ServiceCubit>();
  final _authCubit = serviceLocator.get<AuthCubit>();

  @override
  void initState() {
    initialCameraPosition = CameraPosition(
      target: _serviceCubit.filterLocation!,
      zoom: 10,
    );
    initMarkers();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Set<Marker> markers = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Google Map",style: Theme.of(context).textTheme.titleLarge,),
        backgroundColor: Theme.of(context).primaryColorDark,
      ),
      body: GoogleMap(
        zoomControlsEnabled: false,
        minMaxZoomPreference: MinMaxZoomPreference(8, 50),
        markers: markers,
        initialCameraPosition: initialCameraPosition,
        style: _authCubit.mapStyle,
      ),
    );
  }

  void initMarkers() {
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
