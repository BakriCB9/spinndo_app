import 'package:app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:app/features/profile/presentation/cubit/profile_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/widgets/loading_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpdateMapScreen extends StatelessWidget {
  static const String routeName = '/Umap';

  const UpdateMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _profileCubit.getCountryAndCityNameFromCrocd(
              _profileCubit.isCurrent
                  ? _profileCubit.currentLocation!.latitude
                  : _profileCubit.selectedLocation!.latitude,
              _profileCubit.isCurrent
                  ? _profileCubit.currentLocation!.longitude
                  : _profileCubit.selectedLocation!.longitude);
          Navigator.pop(context);
        },
        child: Icon(
          Icons.save,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        actions: [
          IconButton(
              onPressed: () {
                _profileCubit.initCurrentLocation();
                _profileCubit.initMarkerAddress();
                _profileCubit.isCurrent = true;
              },
              icon: Icon(Icons.location_on))
        ],
        title: Text(
          localization.googleMap,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: BlocBuilder<ProfileCubit,ProfileStates>(
        bloc: _profileCubit,
        buildWhen: (previous, current) {
          if (current is GetUpdatedLocationSuccess ||
              current is GetUpdatedLocationLoading ||
              current is GetUpdatedLocationErrorr) return true;
          return false;
        },
        builder: (context, state) {
          if (state is GetUpdatedLocationLoading) {
            return Center(
              child: LoadingIndicator(Theme.of(context).primaryColor),
            );
          } else if (state is GetUpdatedLocationSuccess) {
            return BlocBuilder<ProfileCubit,ProfileStates>(
              bloc: _profileCubit,
              buildWhen: (previous, current) {
                if (current is SelectedLocationUpdatedState) return true;
                return false;
              },
              builder: (context, state) {
                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    GoogleMap(
                      // cameraTargetBounds: CameraTargetBounds(LatLngBounds(southwest: southwest, northeast: northeast)),
                      zoomControlsEnabled: false,
                      // minMaxZoomPreference: MinMaxZoomPreference(8, 50),
                      markers: _profileCubit.markers,
                      style: _profileCubit.mapStyle,
                      onTap: (argument) {
                        _profileCubit.selectLocation(argument);

                        _profileCubit.initMarkerAddress();
                        _profileCubit.isCurrent = false;
                      },
                      onMapCreated: (controller) async {
                        _profileCubit.isCurrent = true;

                        _profileCubit.googleMapController = controller;
                        _profileCubit.initCurrentLocation();
                        _profileCubit.initMarkerAddress();
                      },
                      initialCameraPosition: CameraPosition(
                          target:
                          _profileCubit.currentLocation ?? const LatLng(0, 0),
                          zoom: 14),
                    ),
                  ],
                );
              },
            );
          } else if (state is GetUpdatedLocationErrorr) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

final _profileCubit = serviceLocator.get<ProfileCubit>();
