// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:app/core/widgets/loading_indicator.dart';
// import 'package:app/features/auth/presentation/cubit/auth_cubit.dart';
// import 'package:app/features/auth/presentation/cubit/auth_states.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// class MapScreen extends StatelessWidget {
//   static const String routeName = '/map';

//   const MapScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final _authCubit = BlocProvider.of<AuthCubit>(context);
//     final localization = AppLocalizations.of(context)!;
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _authCubit.getCountryAndCityNameFromCrocd(
//               _authCubit.isCurrent
//                   ? _authCubit.currentLocation!.latitude
//                   : _authCubit.selectedLocation!.latitude,
//               _authCubit.isCurrent
//                   ? _authCubit.currentLocation!.longitude
//                   : _authCubit.selectedLocation!.longitude);
//           Navigator.pop(context);
//         },
//         child: Icon(
//           Icons.save,
//         ),
//       ),
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).primaryColorDark,
//         actions: [
//           IconButton(
//               onPressed: () {
//                 _authCubit.initCurrentLocation();
//                 _authCubit.initMarkerAddress();
//                 _authCubit.isCurrent = true;
//               },
//               icon: Icon(Icons.location_on))
//         ],
//         title: Text(
//           localization.googleMap,
//           style: Theme.of(context).textTheme.titleLarge,
//         ),
//       ),
//       body: BlocBuilder<AuthCubit, AuthState>(
//         bloc: _authCubit,
//         buildWhen: (previous, current) {
//           if (current is GetCurrentLocationSuccess ||
//               current is GetCurrentLocationLoading ||
//               current is GetCurrentLocationErrorr) return true;
//           return false;
//         },
//         builder: (context, state) {
//           if (state is GetCurrentLocationLoading) {
//             return Center(
//               child: LoadingIndicator(Theme.of(context).primaryColor),
//             );
//           } else if (state is GetCurrentLocationSuccess) {
//             return BlocBuilder<AuthCubit, AuthState>(
//               bloc: _authCubit,
//               buildWhen: (previous, current) {
//                 if (current is SelectedLocationState) return true;
//                 return false;
//               },
//               builder: (context, state) {
//                 return Stack(
//                   alignment: Alignment.bottomCenter,
//                   children: [
//                     GoogleMap(
//                       // cameraTargetBounds: CameraTargetBounds(LatLngBounds(southwest: southwest, northeast: northeast)),
//                       zoomControlsEnabled: false,
//                       // minMaxZoomPreference: MinMaxZoomPreference(8, 50),
//                       markers: _authCubit.markers,
//                       style: _authCubit.mapStyle,
//                       onTap: (argument) {
//                         _authCubit.selectLocation(argument);

//                         _authCubit.initMarkerAddress();
//                         _authCubit.isCurrent = false;
//                       },
//                       onMapCreated: (controller) async {
//                         _authCubit.isCurrent = true;

//                         _authCubit.googleMapController = controller;
//                         _authCubit.initCurrentLocation();
//                         _authCubit.initMarkerAddress();
//                       },
//                       initialCameraPosition: CameraPosition(
//                           target:
//                               _authCubit.currentLocation ?? const LatLng(0, 0),
//                           zoom: 14),
//                     ),
//                   ],
//                 );
//               },
//             );
//           } else if (state is GetCurrentLocationErrorr) {
//             return Center(
//               child: Text(state.message),
//             );
//           } else {
//             return const SizedBox();
//           }
//         },
//       ),
//     );
//   }
// }

// // final _authCubit = serviceLocator.get<AuthCubit>();
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/widgets/loading_indicator.dart';
import 'package:app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:app/features/auth/presentation/cubit/auth_states.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MapScreen extends StatelessWidget {
  static const String routeName = '/map';

  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _authCubit = BlocProvider.of<AuthCubit>(context);
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _authCubit.getCountryAndCityNameFromCrocd(
              _authCubit.isCurrent
                  ? _authCubit.currentLocation!.latitude
                  : _authCubit.selectedLocation!.latitude,
              _authCubit.isCurrent
                  ? _authCubit.currentLocation!.longitude
                  : _authCubit.selectedLocation!.longitude);
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
                _authCubit.initCurrentLocation();
                _authCubit.initMarkerAddress();
                _authCubit.isCurrent = true;
              },
              icon: Icon(Icons.location_on))
        ],
        title: Text(
          localization.googleMap,
          style: Theme.of(context).textTheme.titleLarge,
        ),
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
            return Center(
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
                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    GoogleMap(
                      // cameraTargetBounds: CameraTargetBounds(LatLngBounds(southwest: southwest, northeast: northeast)),
                      zoomControlsEnabled: false,
                      // minMaxZoomPreference: MinMaxZoomPreference(8, 50),
                      markers: _authCubit.markers,
                      style: _authCubit.mapStyle,
                      onTap: (argument) {
                        _authCubit.selectLocation(argument);

                        _authCubit.initMarkerAddress();
                        _authCubit.isCurrent = false;
                      },
                      onMapCreated: (controller) async {
                        _authCubit.isCurrent = true;

                        _authCubit.googleMapController = controller;
                        _authCubit.initCurrentLocation();
                        _authCubit.initMarkerAddress();
                      },
                      initialCameraPosition: CameraPosition(
                          target:
                              _authCubit.currentLocation ?? const LatLng(0, 0),
                          zoom: 14),
                    ),
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
// final _authCubit = serviceLocator.get<AuthCubit>();
