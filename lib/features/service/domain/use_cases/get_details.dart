import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:snipp/core/error/failure.dart';
import 'package:snipp/features/profile/domain/entities/provider_profile/provider_profile.dart';
import 'package:snipp/features/profile/domain/repository/profile_repository.dart';
import 'package:snipp/features/service/domain/repository/service_repository.dart';

@lazySingleton
class GetServiceProfile {
  final ServiceRepository _serviceRepository;

  GetServiceProfile(this._serviceRepository);

  Future<Either<Failure, ProviderProfile>> call(int id ) =>
      _serviceRepository.showDetails(id);
}
