import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:app/core/error/failure.dart';
import 'package:app/features/auth/domain/entities/country.dart';
import 'package:app/features/auth/domain/repository/auth_repository.dart';

@injectable
class Getcountryname {
  final AuthRepository _authRepository;

  Getcountryname(this._authRepository);
  Future<Either<Failure, Country>> call(double lat, double long) =>
      _authRepository.getAddressFromCoordinates(lat, long);
}
