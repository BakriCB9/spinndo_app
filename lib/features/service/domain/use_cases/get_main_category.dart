import 'package:app/core/error/failure.dart';
import 'package:app/features/service/domain/entities/main_category/all_category_main_entity.dart';
import 'package:app/features/service/domain/repository/service_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
@injectable
class GetMainCategory {
  final ServiceRepository _serviceRepository;

  GetMainCategory(this._serviceRepository);

  Future<Either<Failure,GetAllCategoryMainEntity >> call() =>
      _serviceRepository.getAllMainCategory();
}