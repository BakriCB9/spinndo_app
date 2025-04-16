import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:app/features/service/data/models/get_services_request.dart';

import 'package:app/features/service/domain/entities/services.dart';
import 'package:app/features/service/domain/repository/service_repository.dart';

import '../../../../core/error/failure.dart';

@injectable
class GetServices {
  final ServiceRepository _serviceRepository;

  GetServices(this._serviceRepository);

  Future<Either<Failure, List<Services>>> call(
          GetServicesRequest requestBody) =>
      _serviceRepository.getServices(requestBody);
}
