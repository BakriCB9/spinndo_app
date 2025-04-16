import 'package:app/core/error/apiResult.dart';
import 'package:app/features/service_requist/doamin/repositry/service_request_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteServiceRequestUseCase {
  ServiceRequestRepo _serviceRequestRepo;
  DeleteServiceRequestUseCase(this._serviceRequestRepo);
  Future<ApiResult<String>> call(int idOfService) =>
      _serviceRequestRepo.deleteService(idOfService);
}
