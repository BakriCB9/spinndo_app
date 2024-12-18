import 'package:app/features/profile/domain/entities/provider_profile/provider_profile.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:app/core/error/failure.dart';
<<<<<<< HEAD
import 'package:app/features/profile/domain/entities/provider_profile/provider_profile.dart';
=======
>>>>>>> 867d478a456712fd63cd4cde8d7d65678a96ae1d
import 'package:app/features/profile/domain/repository/profile_repository.dart';

@lazySingleton
class GetProviderProfile {
  final ProfileRepository _profileRepository;

  GetProviderProfile(this._profileRepository);

  Future<Either<Failure, ProviderProfile>> call() =>
      _profileRepository.getServiceProvider();
}
