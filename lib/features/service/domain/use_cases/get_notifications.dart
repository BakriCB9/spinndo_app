import 'package:app/core/error/failure.dart';
import 'package:app/features/service/domain/entities/notifications.dart';
import 'package:app/features/service/domain/repository/service_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetNotifications {
  final ServiceRepository _serviceRepository;

  GetNotifications(this._serviceRepository);

  Future<Either<Failure, List<Notifications>>> call() =>
      _serviceRepository.getAllNotification();
}
