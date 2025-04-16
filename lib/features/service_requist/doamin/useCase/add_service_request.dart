import 'package:app/core/error/apiResult.dart';
import 'package:app/features/service_requist/data/model/request_model/update_my_service_request.dart';
import 'package:app/features/service_requist/doamin/entity/get_service_entity.dart';
import 'package:app/features/service_requist/doamin/repositry/service_request_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddServiceRequestUseCase {
  ServiceRequestRepo _serviceRequestRepo;
  AddServiceRequestUseCase(this._serviceRequestRepo);
  Future<ApiResult<ServiceRequestEntity>> call(MyServiceRequest myservice) =>
      _serviceRequestRepo.create(myservice);
}
