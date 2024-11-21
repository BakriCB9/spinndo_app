import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dio/dio.dart';

class MapWithDioBounds extends StatefulWidget {
  static const String routeName = '/asd';
  @override
  _MapWithDioBoundsState createState() => _MapWithDioBoundsState();
}

class _MapWithDioBoundsState extends State<MapWithDioBounds> {
  late GoogleMapController _mapController;
  LatLngBounds? _cameraBounds;

  // Initialize Dio
  final Dio _dio = Dio();
  final String _apiKey = 'AIzaSyDLKgjHRJUu_v5A0GLTIddfD-B0tXAiKoQ';

  @override
  void initState() {
    super.initState();
    // Fetch initial bounds for a country (e.g., India)
    _fetchBoundsForPlace("India");
  }

  Future<void> _fetchBoundsForPlace(String place) async {
    try {
      final response = await _dio.get(
        'https://maps.googleapis.com/maps/api/geocode/json',
        queryParameters: {
          'address': place,
          'key': _apiKey,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['results'].isNotEmpty) {
          final bounds = data['results'][0]['geometry']['bounds'];

          setState(() {
            _cameraBounds = LatLngBounds(
              southwest: LatLng(bounds['southwest']['lat'], bounds['southwest']['lng']),
              northeast: LatLng(bounds['northeast']['lat'], bounds['northeast']['lng']),
            );
          });
        } else {
          throw Exception('No results found for the place: $place');
        }
      } else {
        throw Exception('Failed to fetch bounds with status code: ${response.statusCode}');
      }setState(() {

      });
    } catch (e) {
      print('Error fetching bounds: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dynamic Bounds with Dio")),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(0, 0), // Default target (updated dynamically)
              zoom: 3,
            ),
            onMapCreated: (controller) {
              _mapController = controller;
            },
            cameraTargetBounds: _cameraBounds != null
                ? CameraTargetBounds(_cameraBounds!)
                : CameraTargetBounds.unbounded,
          ),
          Positioned(
            top: 20,
            left: 20,
            right: 20,
            child: TextField(
              decoration: InputDecoration(
                hintText: "Enter city or country",
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              onSubmitted: (value) {
                _fetchBoundsForPlace(value);
                setState(() {

                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
