import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:app/core/error/failure.dart';
import 'package:app/features/profile/data/models/provider_model/data.dart';
import 'package:app/features/profile/domain/entities/provider_profile/provider_profile.dart';
import 'package:app/features/profile/domain/repository/profile_repository.dart';

@lazySingleton
class GetProviderProfile {
  final ProfileRepository _profileRepository;

  GetProviderProfile(this._profileRepository);

  Future<Either<Failure, ProviderProfile>> call() =>
      _profileRepository.getServiceProvider();
}
