import 'package:snipp/features/profile/data/models/client_profile_respoonse/client_profile_respoonse.dart';

abstract class ProfileRemoteDataSource {
 Future<ClientProfileRespoonse> getClientProfile();
 Future<ClientProfileRespoonse> getServiceProviderProfile();

}