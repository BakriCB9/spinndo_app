import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:app/core/error/failure.dart';
import 'package:app/features/auth/data/models/data.dart';
import 'package:app/features/auth/data/models/login_request.dart';
import 'package:app/features/auth/domain/repository/auth_repository.dart';

@injectable
class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);
  Future<Either<Failure, Data>> call(LoginRequest requestData) =>
      _authRepository.login(requestData);
}
