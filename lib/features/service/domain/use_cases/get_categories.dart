import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:app/features/service/domain/entities/categories.dart';
import 'package:app/features/service/domain/repository/service_repository.dart';

import '../../../../core/error/failure.dart';

@lazySingleton
class GetCategories {
  final ServiceRepository _serviceRepository;

  GetCategories(this._serviceRepository);

  Future<Either<Failure, List<Categories>>> call() =>
      _serviceRepository.getCategories();
}
