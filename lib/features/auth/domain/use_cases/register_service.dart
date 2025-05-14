import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:app/core/error/failure.dart';
import 'package:app/features/auth/data/models/register_service_provider_request.dart';
import 'package:app/features/auth/data/models/register_service_provider_response.dart';
import 'package:app/features/auth/domain/repository/auth_repository.dart';

@injectable
class RegisterServiceUseCase {
  final AuthRepository _authRepository;

  RegisterServiceUseCase(this._authRepository);

  Future<Either<Failure, RegisterServiceProviderResponse>> call(
          RegisterServiceProviderRequest requestData) =>
      _authRepository.registerService(requestData);
}
