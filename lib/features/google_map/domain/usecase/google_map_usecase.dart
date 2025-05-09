import 'package:app/core/error/failure.dart';
import 'package:app/features/google_map/domain/entity/country_entity.dart';
import 'package:app/features/google_map/domain/repository/google_map_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class GoogleMapUsecase {
  final GoogleMapRepository _googleMapRepository;
  GoogleMapUsecase(this._googleMapRepository);
  Future<Either<Failure, CountryEntity>> call(double lat, double long) =>
      _googleMapRepository.getAddressFromCoordinates(lat, long);
}
