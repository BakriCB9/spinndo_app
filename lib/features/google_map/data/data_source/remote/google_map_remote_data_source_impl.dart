import 'package:app/core/constant.dart';
import 'package:app/features/google_map/data/data_source/remote/google_map_remote_data_source.dart';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: GoogleMapRemoteDataSource)
class GoogleMapRemoteDataSourceImpl extends GoogleMapRemoteDataSource {
  final Dio _dio;
  GoogleMapRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<List<String>> getAddressFromCoordinates(
      double lat, double long) async {
    final String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=${ApiConstant.googleMapApiKey}';

    final response = await _dio.get(url);

    final data = response.data;

    if (data['status'] == 'OK' && data['results'].isNotEmpty) {
      var address = data['results'][4]['formatted_address'];
      var cityName = data['results'][0]['address_components'][1]['long_name'];
      return [cityName, address];
    } else {
      return [];
    }
  }

  @override
  Future<LatLng> getCountryLatLng(String countryName) async {
    const String url = 'https://maps.googleapis.com/maps/api/geocode/json';

    // Send the request
    final response = await _dio.get(
      url,
      queryParameters: {
        'address': countryName,
        'key': CacheConstant.googleMapKey,
      },
    );

    // Parse the response
    final data = response.data;

    final geometry = data['results'][0]['geometry'];
    final lat = geometry['location']['lat'];
    final lng = geometry['location']['lng'];

    return LatLng(lat, lng);
  }
  //   try {
  //     // Build the Geocoding API URL
  //     const String url = 'https://maps.googleapis.com/maps/api/geocode/json';

  //     // Send the request
  //     final response = await _dio.get(
  //       url,
  //       queryParameters: {
  //         'address': countryName,
  //         'key': CacheConstant.googleMapKey,
  //       },
  //     );

  //     // Parse the response
  //     if (response.statusCode == 200) {
  //       final data = response.data;

  //       if (data['status'] == 'OK') {
  //         final geometry = data['results'][0]['geometry'];
  //         final lat = geometry['location']['lat'];
  //         final lng = geometry['location']['lng'];

  //         return LatLng(lat, lng);
  //       } else {
  //         throw Exception('Error: ${data['status']}');
  //       }
  //     } else {
  //       throw Exception('Failed to fetch data: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     throw e;
  //   }
  // }
}
