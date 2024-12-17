import 'package:app/core/error/failure.dart';

import 'package:app/features/profile/data/models/provider_update/update_provider_request.dart';
import 'package:app/features/profile/data/models/provider_update/update_provider_response.dart';
import 'package:app/features/profile/domain/repository/profile_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UpdateProviderProfile {
  final ProfileRepository _profileRepository;

  UpdateProviderProfile(this._profileRepository);
  Future<Either<Failure, UpdateProviderResponse>> call(
      UpdateProviderRequest updateRequest,int typeEdit) =>
      _profileRepository.updateProviderProfile(updateRequest, typeEdit);
}