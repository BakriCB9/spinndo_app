import 'package:app/core/constant.dart';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeocodingService {
  static final Dio _dio = Dio();
  static final String _apiKey = 'AIzaSyDLKgjHRJUu_v5A0GLTIddfD-B0tXAiKoQ';
  // static Future<Map<String, dynamic>> getAddressFromCoordinates(
  //     double latitude, double longitude) async {
  //   final String url =
  //       'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$_apiKey';
  //
  //   try {
  //     final response = await _dio.get(url);
  //
  //     if (response.statusCode == 200) {
  //       final data = response.data;
  //
  //       if (data['status'] == 'OK' && data['results'].isNotEmpty) {
  //         var address = data['results'][0];
  //
  //         return address;
  //       } else {
  //         throw Exception('No results found');
  //       }
  //     } else {
  //       throw Exception('Failed to load geocoding data');
  //     }
  //   } catch (e) {
  //     throw Exception('Error fetching address: $e');
  //   }
  // }
  static Future<String> getAddressFromCoordinates(
      double lat, double long) async {
    final String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=${ApiConstant.googleMapApiKey}';

    try {
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        final data = response.data;

        if (data['status'] == 'OK' && data['results'].isNotEmpty) {
          // print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
          // print(data['results']);
          // print(lat);print(long);
          // print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
          // var cityName =
          //     data['results'][4]['address_components'][2]['long_name'];
          // var countryName =
          //     data['results'][4]['address_components'][5]['long_name'];
          // var regionName =
          // data['results'][4]['address_components'][1]['long_name'];
          var cityName =
              data['results'][0]['address_components'][1]['long_name'];
          return cityName;
        } else {
          throw Exception('No results found');
        }
      } else {
        throw Exception('Failed to load geocoding data');
      }
    } catch (e) {
      throw Exception('Error fetching address: $e');
    }
  }

  static Future<LatLng> getCountryLatLng(String countryName) async {
    try {
      // Build the Geocoding API URL
      final String url = 'https://maps.googleapis.com/maps/api/geocode/json';

      // Send the request
      final response = await _dio.get(
        url,
        queryParameters: {
          'address': countryName,
          'key': _apiKey,
        },
      );

      // Parse the response
      if (response.statusCode == 200) {
        final data = response.data;

        if (data['status'] == 'OK') {
          final geometry = data['results'][0]['geometry'];
          final lat = geometry['location']['lat'];
          final lng = geometry['location']['lng'];

          return LatLng(lat, lng);

          print('Latitude: $lat, Longitude: $lng');
        } else {
          throw Exception('Error: ${data['status']}');
        }
      } else {
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      throw e;
      print('Error: $e');
    }
  }

  static Future<LatLngBounds> getCountryBounds(String countryName) async {
    try {
      // Build the Geocoding API URL
      final String url = 'https://maps.googleapis.com/maps/api/geocode/json';

      // Send the request
      final response = await _dio.get(
        url,
        queryParameters: {
          'address': countryName,
          'key': _apiKey,
        },
      );

      // Parse the response
      if (response.statusCode == 200) {
        final data = response.data;

        if (data['status'] == 'OK') {
          final geometry = data['results'][0]['geometry'];
          final northLat = geometry['bounds']['northeast']['lat'];
          final northLng = geometry['bounds']['northeast']['lng'];
          final southLat = geometry['bounds']['southwest']['lat'];
          final southLng = geometry['bounds']['southwest']['lng'];

          return LatLngBounds(
              northeast: LatLng(northLat, northLng),
              southwest: LatLng(southLat, southLng));
        } else {
          throw Exception('Error: ${data['status']}');
        }
      } else {
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      throw e;
      print('Error: $e');
    }
  }
  static Future<LatLngBounds> getCurrentLocationBounds(
      double lat, double long) async {
    final String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=${ApiConstant.googleMapApiKey}';

    try {
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        final data = response.data;

        if (data['status'] == 'OK' && data['results'].isNotEmpty) {

          final geometry = data['results'][5]['geometry'];
          final northLat = geometry['bounds']['northeast']['lat'];
          final northLng = geometry['bounds']['northeast']['lng'];
          final southLat = geometry['bounds']['southwest']['lat'];
          final southLng = geometry['bounds']['southwest']['lng'];

          return LatLngBounds(
              northeast: LatLng(northLat, northLng),
              southwest: LatLng(southLat, southLng));
        } else {
          throw Exception('No results found');
        }
      } else {
        throw Exception('Failed to load geocoding data');
      }
    } catch (e) {
      throw Exception('Error fetching address: $e');
    }
  }

}
