import 'package:app/core/constant.dart';
import 'package:app/core/utils/ui_utils.dart';
import 'package:app/features/service/presentation/screens/show_details.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:app/features/auth/presentation/cubit/auth_cubit.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/utils/map_helper/geocoding_service.dart';
import '../../../../core/utils/map_helper/google_map_service.dart';
import '../../domain/entities/google_map_marker.dart';
import '../cubit/service_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  Set<Marker> markers = {};

  @override
  void initState() {
    initialCameraPosition = CameraPosition(
        target: _serviceCubit.filterLocation!,
        zoom: _serviceCubit.isCity ? 12 : 6);
    // markers.addAll([Marker(markerId: MarkerId('1'),position: LatLng(37.0989075, 36.1721064) ),Marker(markerId: MarkerId('2'),position: LatLng(37.0989105, 36.1721026)),Marker(markerId: MarkerId('3'),position: LatLng(36.297607719898224, 33.50574174037673))]);
    initMarkers();
    for (int i = 0; i < markerLocationData.length; i++) {
      print(
          'the value of marker is ###########################################  $i   ${markerLocationData[i].latLng}');
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          localization.googleMap,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Theme.of(context).primaryColorDark,
      ),
      body: GoogleMap(
        zoomControlsEnabled: false,
        minMaxZoomPreference: MinMaxZoomPreference(0, 50),
        markers: markers,
        cameraTargetBounds: CameraTargetBounds(_serviceCubit.filterBounds),
        initialCameraPosition: initialCameraPosition,
        style: _authCubit.mapStyle,
      ),
    );
  }

  void initMarkers() {
    //markers.clear();
    Set<Marker> myMarker = markerLocationData
        .map(
          (e) => Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(e.color),
        position: e.latLng,
        infoWindow: InfoWindow(title: e.name),
        onTap: () {
          if (sharedPref.getString(CacheConstant.tokenKey) == null) {
            UIUtils.showMessage("You have to Sign in first");
            return;
          }
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ShowDetails(id: e.providerId!),
            ),
          );
        },
        markerId: MarkerId(
          e.id.toString(),
        ),
      ),
    )
        .toSet();
    print(
        'the aux Marker is  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&  ${myMarker.length}');
    markers.addAll(myMarker);

    print(
        'the marker main is ########################################    ${markers.length}');
  }

//world view 0 ->3
//country view 4->6
//city view 10->12
//street view 13->17
//building view 18->20
}
