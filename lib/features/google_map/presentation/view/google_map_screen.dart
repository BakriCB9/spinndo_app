import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/utils/ui_utils.dart';
import 'package:app/features/discount/presentation/view_model/cubit/discount_view_model_cubit.dart';
import 'package:app/features/google_map/presentation/view_model/cubit/google_map_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:app/core/widgets/loading_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  @override
  Widget build(BuildContext context) {
    final googleMapCubit = BlocProvider.of<GoogleMapCubit>(context);
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
        floatingActionButton: BlocListener<GoogleMapCubit, GoogleMapState>(
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
