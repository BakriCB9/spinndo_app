import 'package:app/core/error/failure.dart';
import 'package:app/features/google_map/domain/repository/google_map_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:injectable/injectable.dart';

@injectable
class GetLatlngCountryUseCase {
  GoogleMapRepository _googleMapRepository;
  GetLatlngCountryUseCase(this._googleMapRepository);
  Future<Either<Failure, LatLng>> call(String name) =>
      _googleMapRepository.getCountryLatLng(name);
}
