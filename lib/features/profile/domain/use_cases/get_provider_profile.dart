import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:snipp/core/error/failure.dart';
import 'package:snipp/features/profile/data/models/provider_model/data.dart';
import 'package:snipp/features/profile/domain/entities/provider_profile/provider_profile.dart';
import 'package:snipp/features/profile/domain/repository/profile_repository.dart';

@lazySingleton
class GetProviderProfile {
  final ProfileRepository _profileRepository;

  GetProviderProfile(this._profileRepository);

  Future<Either<Failure, ProviderProfile>> call() =>
      _profileRepository.getServiceProvider();
}
