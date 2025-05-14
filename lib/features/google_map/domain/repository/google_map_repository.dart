import 'package:app/core/error/failure.dart';
import 'package:app/features/google_map/domain/entity/country_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class GoogleMapRepository {
  Future<Either<Failure, CountryEntity>> getAddressFromCoordinates(
      double lat, double long);
  Future<Either<Failure, LatLng>> getCountryLatLng(String countryName);
}
