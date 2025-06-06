import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:app/features/auth/data/models/reset_password_request.dart';
import 'package:app/features/auth/data/models/reset_password_response.dart';

import '../../../../core/error/failure.dart';
import '../repository/auth_repository.dart';

@injectable
class ResetPasswordUseCase {
  final AuthRepository _authRepository;

  ResetPasswordUseCase(this._authRepository);

  Future<Either<Failure, ResetPasswordResponse>> call(
          ResetPasswordRequest requestData) =>
      _authRepository.resetPassword(requestData);
}
