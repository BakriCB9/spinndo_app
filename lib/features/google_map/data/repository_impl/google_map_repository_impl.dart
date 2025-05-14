import 'package:app/core/error/failure.dart';
import 'package:app/core/network/remote/handle_dio_exception.dart';
import 'package:app/features/google_map/data/data_source/remote/google_map_remote_data_source.dart';
import 'package:app/features/google_map/domain/entity/country_entity.dart';
import 'package:app/features/google_map/domain/repository/google_map_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: GoogleMapRepository)
class GoogleMapRepositoryImpl extends GoogleMapRepository {
  final GoogleMapRemoteDataSource _googleMapRemoteDataSource;

  GoogleMapRepositoryImpl(this._googleMapRemoteDataSource);

  @override
  Future<Either<Failure, CountryEntity>> getAddressFromCoordinates(
      double lat, double long) async {
    try {
      final response =
          await _googleMapRemoteDataSource.getAddressFromCoordinates(lat, long);
      return response.isEmpty
          ? Right(CountryEntity(
              cityName: 'unKnown city', address: 'unknow address'))
          : Right(CountryEntity(cityName: response[0], address: response[1]));
    } catch (e) {
      final exception = HandleException.exceptionType(e);
      return Left(Failure(exception));
    }
  }

  @override
  Future<Either<Failure, LatLng>> getCountryLatLng(String countryName) async {
    try {
      final response =
          await _googleMapRemoteDataSource.getCountryLatLng(countryName);
      return Right(response);
    } catch (e) {
      final exception = HandleException.exceptionType(e);
      return Left(Failure(exception));
    }
  }
}
