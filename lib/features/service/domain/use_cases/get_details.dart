import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:app/core/error/failure.dart';
import 'package:app/features/profile/domain/entities/provider_profile/provider_profile.dart';
import 'package:app/features/profile/domain/repository/profile_repository.dart';
import 'package:app/features/service/domain/repository/service_repository.dart';

@injectable
class GetServiceProfile {
  final ServiceRepository _serviceRepository;

  GetServiceProfile(this._serviceRepository);

  Future<Either<Failure, ProviderProfile>> call(int id) =>
      _serviceRepository.showDetails(id);
}
