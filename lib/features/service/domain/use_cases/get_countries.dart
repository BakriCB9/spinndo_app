import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:app/features/service/domain/entities/countries.dart';
import 'package:app/features/service/domain/repository/service_repository.dart';

import '../../../../core/error/failure.dart';

@injectable
class GetCountries {
  final ServiceRepository _serviceRepository;

  GetCountries(this._serviceRepository);

  Future<Either<Failure, List<Countries>>> call() =>
      _serviceRepository.getCountries();
}
