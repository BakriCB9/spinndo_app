import 'package:snipp/features/profile/data/models/client_profile_respoonse/client_profile_respoonse.dart';
import 'package:snipp/features/profile/data/models/provider_model/provider_model.dart';

abstract class ProfileRemoteDataSource {
 Future<ClientProfileRespoonse> getClientProfile();
 Future<ProviderResponse> getServiceProviderProfile();

}