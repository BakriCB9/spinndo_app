import 'package:app/core/error/failure.dart';
import 'package:app/features/service/domain/entities/notifications.dart';
import 'package:app/features/service/domain/entities/package.dart';
import 'package:app/features/service/domain/repository/service_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetPackages{
  final ServiceRepository _serviceRepository;

  GetPackages(this._serviceRepository);

  Future<Either<Failure, List<Packages>>> call() =>
      _serviceRepository.getAllPackages();
}
