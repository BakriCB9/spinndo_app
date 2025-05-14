import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:app/core/error/failure.dart';
import 'package:app/features/auth/data/models/data.dart';
import 'package:app/features/auth/data/models/verify_code_request.dart';
import 'package:app/features/auth/domain/repository/auth_repository.dart';

@injectable
class VerifyCodeUseCase {
  final AuthRepository _authRepository;

  VerifyCodeUseCase(this._authRepository);
  Future<Either<Failure, Data>> call(VerifyCodeRequest requestData) =>
      _authRepository.verifyCode(requestData);
}
