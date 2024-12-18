import 'dart:io';

import 'package:app/features/profile/data/models/client_update/update_account_profile.dart';
import 'package:app/features/profile/data/models/client_update/update_client_response.dart';
import 'package:app/features/profile/data/models/image_profile_photo/image_profile_response.dart';
import 'package:app/features/profile/data/models/provider_update/update_provider_request.dart';
import 'package:app/features/profile/data/models/provider_update/update_provider_response.dart';
import 'package:dartz/dartz.dart';
import 'package:app/core/error/failure.dart';

import 'package:app/features/profile/domain/entities/client_profile.dart';
import 'package:app/features/profile/domain/entities/provider_profile/provider_profile.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ClientProfile>> getClient();
  Future<Either<Failure, ProviderProfile>> getServiceProvider();
  Either<Failure, String> getUserRole();

  Future<Either<Failure, UpdateClientResponse>> updateClientProfile(
      UpdateAccountProfile updateRequest);
  Future<Either<Failure, UpdateProviderResponse>> updateProviderProfile(
      UpdateProviderRequest updateRequest, int typeEdit);
  Future<Either<Failure, ImageProfileResponse>> addImageProfile(File iamge);
}
