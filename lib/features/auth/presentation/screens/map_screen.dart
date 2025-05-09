import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/utils/ui_utils.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:app/core/widgets/loading_indicator.dart';
import 'package:app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:app/features/auth/presentation/cubit/auth_states.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MapScreen extends StatefulWidget {
  static const String routeName = '/map';
  AuthCubit? authCubit;
  MapScreen({this.authCubit, super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final _drawerCubit = serviceLocator.get<DrawerCubit>();
  @override
  initState() {
    super.initState();

    widget.authCubit?.getCurrentLocation();
    widget.authCubit
        ?.loadMapStyle(_drawerCubit.themeMode == ThemeMode.dark ? true : false);
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
        floatingActionButton: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is GetLocationCountryLoading) {
              UIUtils.showLoadingDialog(context);
            } else if (state is GetLocationCountrySuccess) {
              UIUtils.hideLoading(context);
              Navigator.of(context)
                  .pop([authCubit.selectedLocation, authCubit.country]);
            } else if (state is GetLocationCountryErrorr) {
              UIUtils.hideLoading(context);
              UIUtils.showMessage(state.message);
            }
          },
          child: FloatingActionButton(
              onPressed: () {
                if (authCubit.selectedLocation != null) {
                  authCubit.getCountryAndCityNameFromCrocd(
                      authCubit.selectedLocation!.latitude,
                      authCubit.selectedLocation!.longitude);
                }
              },
              child: const Icon(Icons.save)),
        ),
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColorDark,
          actions: [
            IconButton(
                onPressed: () {
                  if (authCubit.selectedLocation != null) {
                    authCubit.initCurrentLocation();
                  }
                },
                icon: const Icon(Icons.location_on))
          ],
          title: Text(
            localization.googleMap,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: BlocBuilder<AuthCubit, AuthState>(
            bloc: authCubit,
            buildWhen: (previous, current) {
              if (current is GetCurrentLocationSuccess ||
                  current is GetCurrentLocationLoading ||
                  current is GetCurrentLocationErrorr) return true;
              return false;
            },
            builder: (context, state) {
              if (state is GetCurrentLocationLoading) {
                return Center(
                    child: LoadingIndicator(Theme.of(context).primaryColor));
              } else if (state is GetCurrentLocationSuccess) {
                return BlocBuilder<AuthCubit, AuthState>(
                  bloc: authCubit,
                  buildWhen: (previous, current) {
                    if (current is SelectedLocationState) return true;
                    return false;
                  },
                  builder: (context, state) {
                    return GoogleMap(
                      zoomControlsEnabled: false,
                      markers: authCubit.markerLocationData.map((e) {
                        return Marker(
                            icon:
                                BitmapDescriptor.defaultMarkerWithHue(e.color),
                            position: e.latLng,
                            infoWindow: InfoWindow(title: e.name),
                            markerId: MarkerId(e.id.toString()));
                      }).toSet(),
                      style: authCubit.mapStyle,
                      onTap: (argument) {
                        authCubit.selectLocation(argument);
                      },
                      onMapCreated: (controller) async {
                        authCubit.googleMapController = controller;
                        authCubit.initCurrentLocation();
                      },
                      initialCameraPosition: CameraPosition(
                          target:
                              authCubit.currentLocation ?? const LatLng(0, 0),
                          zoom: 15),
                    );
                  },
                );
              } else if (state is GetCurrentLocationErrorr) {
                return Center(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.location_off_rounded,
                                color: ColorManager.primary,
                                size: 300.w,
                              ),
                              Text(localization.giveAccessPersmissionLocation,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  textAlign: TextAlign.center),
                              SizedBox(height: 50.h),
                              SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        authCubit.getCurrentLocation();
                                      },
                                      child: Text(localization.tryagain)))
                            ])));
              } else {
                return const SizedBox();
              }
            }));
  }
}
