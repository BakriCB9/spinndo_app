



import 'package:app/core/error/failure.dart';
import 'package:app/features/profile/data/models/client_update/update_client_request.dart';
import 'package:app/features/profile/data/models/client_update/update_client_response.dart';
import 'package:app/features/profile/domain/repository/profile_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UpdateClientProfile {
  final ProfileRepository _profileRepository;

  UpdateClientProfile(this._profileRepository);
  Future<Either<Failure, UpdateClientResponse>> call(
      UpdateClientRequest updateRequest) =>
      _profileRepository.updateClientProfile(updateRequest);
}