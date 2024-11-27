import 'package:dartz/dartz.dart';
import 'package:snipp/core/error/failure.dart';
import 'package:snipp/features/profile/data/models/provider_model/data.dart';

import 'package:snipp/features/profile/domain/entities/client_profile.dart';
import 'package:snipp/features/profile/domain/entities/provider_profile/provider_profile.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ClientProfile>> getClient();
  Future<Either<Failure, ProviderProfile>> getServiceProvider();
  Either<Failure, String> getUserRole();
}
