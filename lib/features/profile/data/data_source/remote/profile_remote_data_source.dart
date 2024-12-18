import 'dart:io';

import 'package:app/features/profile/data/models/client_profile_respoonse/client_profile_respoonse.dart';
import 'package:app/features/profile/data/models/image_profile_photo/image_profile_response.dart';
<<<<<<< HEAD
import 'package:app/features/profile/data/models/provider_modle/provider_profile_modle.dart';
=======
import 'package:app/features/profile/data/models/provider_model/provider_profile_response.dart';
>>>>>>> 867d478a456712fd63cd4cde8d7d65678a96ae1d
import 'package:app/features/profile/data/models/provider_update/update_provider_request.dart';
import 'package:app/features/profile/data/models/provider_update/update_provider_response.dart';

import '../../models/client_update/update_account_profile.dart';
import '../../models/client_update/update_client_response.dart';

abstract class ProfileRemoteDataSource {
  Future<ClientProfileRespoonse> getClientProfile(
      int user_id, String user_token);
  Future<ProviderProfileResponse> getServiceProviderProfile(
      int user_id, String user_token);

  Future<UpdateClientResponse> updateClientProfile(
      UpdateAccountProfile updateRequest);
  Future<UpdateProviderResponse> updateProviderProfile(
      UpdateProviderRequest updateRequest, int typeEdit);
  Future<ImageProfileResponse> addImagePhoto(File image);
}
