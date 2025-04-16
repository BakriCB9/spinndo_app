import 'package:app/core/error/apiResult.dart';
import 'package:app/features/service_requist/doamin/entity/get_service_entity.dart';
import 'package:app/features/service_requist/doamin/repositry/service_request_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetServiceRequestUseCase {
  ServiceRequestRepo serviceRequestRepo;
  GetServiceRequestUseCase(this.serviceRequestRepo);
  Future<ApiResult<List<ServiceRequestEntity>>> call(int? userId) =>
      serviceRequestRepo.getServiceRequest(userId);
}
