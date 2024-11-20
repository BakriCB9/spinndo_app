import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:snipp/core/error/failure.dart';
import 'package:snipp/features/auth/data/models/data.dart';
import 'package:snipp/features/auth/data/models/verify_code_request.dart';
import 'package:snipp/features/auth/domain/repository/auth_repository.dart';

@singleton
class VerifyCode {
  final AuthRepository _authRepository;

  VerifyCode(this._authRepository);
  Future<Either<Failure, Data>> call(VerifyCodeRequest requestData) =>
      _authRepository.verifyCode(requestData);
}
