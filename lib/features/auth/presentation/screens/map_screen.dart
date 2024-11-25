import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:snipp/core/di/service_locator.dart';
import 'package:snipp/core/widgets/loading_indicator.dart';
import 'package:snipp/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:snipp/features/auth/presentation/cubit/auth_states.dart';

class MapScreen extends StatelessWidget {
  static const String routeName = '/map';

  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("Google Map"),
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        bloc: _authCubit,
        buildWhen: (previous, current) {
          if (current is GetCurrentLocationSuccess ||
              current is GetCurrentLocationLoading ||
              current is GetCurrentLocationErrorr) return true;
          return false;
        },
        builder: (context, state) {
          if (state is GetCurrentLocationLoading) {
            return  Center(
              child: LoadingIndicator(Theme.of(context).primaryColor),
            );
          } else if (state is GetCurrentLocationSuccess) {
            return BlocBuilder<AuthCubit, AuthState>(
              bloc: _authCubit,
              buildWhen: (previous, current) {
                if (current is SelectedLocationState) return true;
                return false;
              },
              builder: (context, state) {
                return Stack(alignment: Alignment.bottomCenter,
                  children: [
                    GoogleMap(
                      zoomControlsEnabled: false,
                      // minMaxZoomPreference: MinMaxZoomPreference(8, 50),
                      markers: _authCubit.markers,
                      onTap: (argument) {
                        _authCubit.selectLocation(argument);

                        _authCubit.initMarkerAddress();
                        _authCubit.isCurrent = false;
                      },
                      onMapCreated: (controller) async {
                        _authCubit.googleMapController = controller;

                        _authCubit.initCurrentLocation();
                        _authCubit.initMarkerAddress();
                      },
                      initialCameraPosition: CameraPosition(
                          target:
                              _authCubit.currentLocation ?? const LatLng(0, 0),
                          zoom: 14),
                    ),
                    Positioned(
                      bottom: 50.h,
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                _authCubit.initCurrentLocation();
                                _authCubit.initMarkerAddress();
                                _authCubit.isCurrent = true;
                              },
                              child:  Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text("get current location",style: TextStyle(color: Colors.black,fontSize: 26.sp),),
                              )),
                          SizedBox(width: 50.w,),
                          ElevatedButton(
                              onPressed: () {
                                _authCubit.initCurrentLocation();
                                _authCubit.initMarkerAddress();
                                _authCubit.getCountryAndCityNameFromCrocd(
                                    _authCubit.isCurrent
                                        ? _authCubit.currentLocation!.latitude
                                        : _authCubit.selectedLocation!.latitude,
                                    _authCubit.isCurrent
                                        ? _authCubit.currentLocation!.longitude
                                        : _authCubit.selectedLocation!.longitude);
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child:  Text("Save Choosen location",style: TextStyle(color: Colors.black,fontSize: 26.sp),),
                              )),
                        ],
                      ),
                    )
                  ],
                );
              },
            );
          } else if (state is GetCurrentLocationErrorr) {
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

final _authCubit = serviceLocator.get<AuthCubit>();
