import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:app/core/error/failure.dart';
import 'package:app/features/auth/domain/entities/country.dart';
import 'package:app/features/auth/domain/repository/auth_repository.dart';

@singleton
class Getcountryname {
  final AuthRepository _authRepository;

  Getcountryname(this._authRepository);
  Future<Either<Failure, Country>> call(double lat, double long) =>
      _authRepository.getAddressFromCoordinates(lat, long);
}
