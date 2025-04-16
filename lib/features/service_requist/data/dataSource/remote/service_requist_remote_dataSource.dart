import 'package:app/features/service_requist/data/model/request_model/update_my_service_request.dart';
import 'package:app/features/service_requist/data/model/response_model/get_all_service_request_model/datum.dart';

abstract class ServiceRequistRemoteDatasource {
  Future<List<DataOfAllServiceRequest>> getAllRequest();
  Future<List<DataOfAllServiceRequest>> getMyServiceRequestOnly(int userId);
  Future<DataOfAllServiceRequest> updateMyRequest(
      int idOfservice, MyServiceRequest myservice);

  Future<String> deleteMyService(int idOfSerivce);
  Future<String> closeMyserviceRequest(String idOfSerivce);
  Future<DataOfAllServiceRequest> create(MyServiceRequest myservice);
}
