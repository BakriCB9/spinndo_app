import 'package:app/core/error/apiResult.dart';
import 'package:app/features/service_requist/data/model/request_model/update_my_service_request.dart';
import 'package:app/features/service_requist/doamin/entity/get_service_entity.dart';

abstract class ServiceRequestRepo {
  Future<ApiResult<List<ServiceRequestEntity>>> getServiceRequest(int? userId);
  Future<ApiResult<ServiceRequestEntity>> updateMyService(
      int idOfSerivce, MyServiceRequest serviceRequestEntity);

  Future<ApiResult<ServiceRequestEntity>> create(
      MyServiceRequest serviceRequestEntity);
  Future<ApiResult<String>> deleteService(int idOfService);
}
