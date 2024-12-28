import 'dart:io';

import 'package:app/features/profile/data/models/client_profile_respoonse/client_profile_respoonse.dart';
import 'package:app/features/profile/data/models/delete_image/delete_image.dart';
import 'package:app/features/profile/data/models/image_profile_photo/image_profile_response.dart';
import 'package:app/features/profile/data/models/provider_modle/provider_profile_modle.dart';
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
  Future<DeleteImageResponse>deleteImage();
}
