import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:snipp/core/error/failure.dart';
import 'package:snipp/features/auth/data/models/register_service_provider_request.dart';
import 'package:snipp/features/auth/data/models/register_service_provider_response.dart';
import 'package:snipp/features/auth/domain/repository/auth_repository.dart';

@singleton
class RegisterService {
  final AuthRepository _authRepository;

  RegisterService(this._authRepository);

  Future<Either<Failure, RegisterServiceProviderResponse>> call(
          RegisterServiceProviderRequest requestData) =>
      _authRepository.registerService(requestData);
}
