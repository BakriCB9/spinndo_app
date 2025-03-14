import 'package:app/core/error/apiResult.dart';
import 'package:app/features/service/data/models/get_services_response/get_services_response.dart';

abstract class RemoteDatasource {
  Future<String?> addToFav(String userId, String userToken);
  Future<String?> removeFromFav(String userId, String userToken);
  Future<GetServicesResponse> getAllFav(String userToken);
}
