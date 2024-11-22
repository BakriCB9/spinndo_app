import 'package:dio/dio.dart';

class GeocodingService {


  static Future<Map<String, dynamic>> getAddressFromCoordinates(
      double latitude, double longitude) async {
    const String apiKey =
        'AIzaSyDLKgjHRJUu_v5A0GLTIddfD-B0tXAiKoQ'; // Replace with your API key
    final String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey';

    try {
      Dio dio = Dio();
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        // Parse the JSON response
        final data = response.data;

        if (data['status'] == 'OK' && data['results'].isNotEmpty) {
          var address = data['results'][0];
          // regionName=data['results'][4]['address_components'][1]['long_name'];
          // regionName2=data['results'][4]['address_components'][1]['short_name'];
          // print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
          // print(regionName);
          // print(regionName2);
          // print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
          return address;
          // Return the first result
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