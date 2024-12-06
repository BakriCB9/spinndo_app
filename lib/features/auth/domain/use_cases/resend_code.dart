import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:app/features/auth/data/models/resend_code_request.dart';
import 'package:app/features/auth/data/models/resend_code_response.dart';

import '../../../../core/error/failure.dart';
import '../repository/auth_repository.dart';

@singleton
class ResendCode {
  final AuthRepository _authRepository;

  ResendCode(this._authRepository);

  Future<Either<Failure, ResendCodeResponse>> call(
          ResendCodeRequest requestData) =>
      _authRepository.resendCode(requestData);
}
