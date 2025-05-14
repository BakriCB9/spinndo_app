import 'package:app/core/constant.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/utils/app_shared_prefrence.dart';
import 'package:app/core/utils/error_network_widget.dart';
import 'package:app/core/utils/ui_utils.dart';
import 'package:app/features/discount/presentation/view_model/cubit/discount_view_model_cubit.dart';
import 'package:app/features/google_map/domain/entity/marker_location.dart';
import 'package:app/features/google_map/presentation/view_model/cubit/google_map_cubit.dart';
import 'package:app/features/service/presentation/screens/show_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:app/core/widgets/loading_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:location/location.dart';

enum MapType { showMarkers, chosseLocation }

class GoogleMapScreen extends StatefulWidget {
  final MapType mapType;
  String? nameOfCountry;
  LocationData? currentLocation;

  GoogleMapScreen(
      {super.key,
      required this.mapType,
      this.currentLocation,
      this.nameOfCountry});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.mapType == MapType.chosseLocation) {
      return const GoogleMapLocation();
    } else {
      // return const  SizedBox();
      return GoogleMapMarker(
        name: widget.nameOfCountry,
        currentLocation: widget.currentLocation,
      );
    }
  }
}

class GoogleMapLocation extends StatefulWidget {
  const GoogleMapLocation({super.key});

  @override
  State<GoogleMapLocation> createState() => _GoogleMapLocationState();
}

class _GoogleMapLocationState extends State<GoogleMapLocation> {
  late GoogleMapCubit googleMapCubit;
  @override
  void initState() {
    googleMapCubit = serviceLocator.get<GoogleMapCubit>()
      ..getCurrentLocation()
      ..loadMapStyle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
        floatingActionButton: BlocListener<GoogleMapCubit, GoogleMapState>(
          bloc: googleMapCubit,
          listenWhen: (pre, cur) {
            if (pre.getNameOfCountry != cur.getNameOfCountry) return true;
            return false;
          },
          listener: (context, state) {
            if (state.getNameOfCountry is BaseLoadingState) {
              UIUtils.showLoadingDialog(context);
            } else if (state.getNameOfCountry is BaseSuccessState) {
              UIUtils.hideLoading(context);
              Navigator.of(context).pop([
                googleMapCubit.selectedLocation!.latitude,
                googleMapCubit.selectedLocation!.longitude,
                googleMapCubit.country!.cityName,
                googleMapCubit.country!.address
              ]);
            } else if (state.getNameOfCountry is BaseErrorState) {
              final message = state.getNameOfCountry as BaseErrorState;
              UIUtils.hideLoading(context);
              UIUtils.showMessage(message.error!);
            }
          },
          child: FloatingActionButton(
              onPressed: () {
                if (googleMapCubit.selectedLocation != null) {
                  googleMapCubit.getCountryAndCityNameFromCrocd(
                      googleMapCubit.selectedLocation!.latitude,
                      googleMapCubit.selectedLocation!.longitude);
                }
              },
              child: const Icon(Icons.save)),
        ),
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColorDark,
          actions: [
            IconButton(
                onPressed: () {
                  if (googleMapCubit.selectedLocation != null) {
                    googleMapCubit.initCurrentLocation();
                  }
                },
                icon: const Icon(Icons.location_on))
          ],
          title: Text(
            localization.googleMap,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: BlocSelector<GoogleMapCubit, GoogleMapState, BaseState>(
            selector: (state) {
              return state.currentLocationState!;
            },
            bloc: googleMapCubit,
            builder: (context, state) {
              if (state is BaseLoadingState) {
                return Center(
                    child: LoadingIndicator(Theme.of(context).primaryColor));
              } else if (state is BaseSuccessState) {
                return BlocBuilder<GoogleMapCubit, GoogleMapState>(
                    bloc: googleMapCubit,
                    buildWhen: (previous, current) {
                      if (current.isSelected == true) {
                        return true;
                      }
                      return false;
                    },
                    builder: (context, state) {
                      return GoogleMap(
                        zoomControlsEnabled: false,
                        markers: googleMapCubit.markerLocationData.map((e) {
                          return e;
                        }).toSet(),
                        style: googleMapCubit.mapStyle,
                        onTap: (argument) {
                          googleMapCubit.selectLocation(argument);
                        },
                        onMapCreated: (controller) async {
                          googleMapCubit.googleMapController = controller;
                          googleMapCubit.initCurrentLocation();
                        },
                        initialCameraPosition: CameraPosition(
                            target: googleMapCubit.currentLocation ??
                                const LatLng(0, 0),
                            zoom: 15),
                      );
                    });
              } else if (state is BaseErrorState) {
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
                                        googleMapCubit.getCurrentLocation();
                                      },
                                      child: Text(localization.tryagain)))
                            ])));
              } else {
                return const SizedBox();
              }
            }));
  }
}

class GoogleMapMarker extends StatefulWidget {
  String? name;
  LocationData? currentLocation;
  GoogleMapMarker({this.currentLocation, this.name, super.key});

  @override
  State<GoogleMapMarker> createState() => _GoogleMapMarkerState();
}

class _GoogleMapMarkerState extends State<GoogleMapMarker> {
  Set<Marker> markers = {};
  final googleMapCubit = serviceLocator.get<GoogleMapCubit>()..loadMapStyle();
  @override
  initState() {
    super.initState();
    if (widget.name != null) {
      googleMapCubit.getLatLngCountry(widget.name!);
    }
    initMarkers();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Directionality.of(context) == TextDirection.rtl
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Text(
            localization.googleMap,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColorDark,
      ),
      body: BlocBuilder<GoogleMapCubit, GoogleMapState>(
        bloc:googleMapCubit,
        builder: (context, state) {
          if (state.getLatlangcountry is BaseLoadingState) {
            return const Center(
              child: LoadingIndicator(ColorManager.primary),
            );
          } else if (state.getLatlangcountry is BaseErrorState) {
            final message = state.getLatlangcountry as BaseErrorState;
            return ErrorNetworkWidget(
                message: message.error!,
                onTap: () {
                  googleMapCubit.getLatLngCountry(widget.name!);
                });
          } else if (state.getLatlangcountry is BaseSuccessState) {
            final CameraPosition cameraPosition = CameraPosition(
                target: (state.getLatlangcountry as BaseSuccessState).data,
                zoom: 7);
            return GoogleMap(
              zoomControlsEnabled: false,
              minMaxZoomPreference: const MinMaxZoomPreference(0, 50),
              markers: markers,
              //cameraTargetBounds: CameraTargetBounds(_serviceCubit.filterBounds),
              initialCameraPosition: cameraPosition,
              style: googleMapCubit.mapStyle,
            );
          } else {
            CameraPosition initCameraPosition = CameraPosition(
                target: LatLng(widget.currentLocation!.latitude!,
                    widget.currentLocation!.longitude!),
                zoom: 12);
            return GoogleMap(
              zoomControlsEnabled: false,
              minMaxZoomPreference: const MinMaxZoomPreference(0, 50),
              markers: markers,
              //cameraTargetBounds: CameraTargetBounds(_serviceCubit.filterBounds),
              initialCameraPosition: initCameraPosition,
              style: googleMapCubit.mapStyle,
            );
          }
        },
      ),
    );
  }

  initMarkers() {
    markers = markerLocationData.map((e) {
      return Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(e.color),
        position: e.latLng,
        infoWindow: InfoWindow(title: e.name),
        onTap: () {
          if (isLogIn() == null) {
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
      );
    }).toSet();
  }
}

String? isLogIn() {
  final sharedpref = serviceLocator.get<SharedPreferencesUtils>();
  return sharedpref.getData(key: CacheConstant.tokenKey) as String?;
}
