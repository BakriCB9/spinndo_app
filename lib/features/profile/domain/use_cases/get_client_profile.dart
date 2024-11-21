import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:snipp/core/error/failure.dart';
import 'package:snipp/features/profile/domain/entities/client_profile.dart';
import 'package:snipp/features/profile/domain/repository/profile_repository.dart';
@lazySingleton

class GetClientProfile {
final ProfileRepository _profileRepository;

  GetClientProfile(this._profileRepository);

  Future<Either<Failure,ClientProfile>>  call()=>_profileRepository.getClient();
}