import 'package:dartz/dartz.dart';
import 'package:app/core/error/failure.dart';
import 'package:app/features/profile/data/models/provider_model/data.dart';

import 'package:app/features/profile/domain/entities/client_profile.dart';
import 'package:app/features/profile/domain/entities/provider_profile/provider_profile.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ClientProfile>> getClient();
  Future<Either<Failure, ProviderProfile>> getServiceProvider();
  Either<Failure, String> getUserRole();
}
