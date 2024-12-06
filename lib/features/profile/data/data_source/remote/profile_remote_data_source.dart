import 'package:app/features/profile/data/models/client_profile_respoonse/client_profile_respoonse.dart';
import 'package:app/features/profile/data/models/provider_model/provider_profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ClientProfileRespoonse> getClientProfile(
      int user_id, String user_token);
  Future<ProviderProfileResponse> getServiceProviderProfile(
      int user_id, String user_token);
}
