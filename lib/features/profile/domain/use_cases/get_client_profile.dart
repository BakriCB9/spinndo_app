import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:snipp/core/error/failure.dart';
import 'package:snipp/features/profile/domain/entities/client.dart';
import 'package:snipp/features/profile/domain/repository/profile_repository.dart';
@lazySingleton

class GetClientProfile {
final ProfileRepository _profileRepository;

  GetClientProfile(this._profileRepository);

  Future<Either<Failure,Client>>  call()=>_profileRepository.getClient();
}