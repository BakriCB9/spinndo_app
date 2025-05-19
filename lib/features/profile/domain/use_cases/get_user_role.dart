import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:app/core/error/failure.dart';
import 'package:app/features/profile/domain/repository/profile_repository.dart';

@lazySingleton
class GetUserRole {
  final ProfileRepository _profileRepository;

  GetUserRole(this._profileRepository);
  Either<Failure, String> call() => _profileRepository.getUserRole();
}
