import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:app/features/auth/data/models/register_request.dart';
import 'package:app/features/auth/data/models/register_response.dart';
import 'package:app/features/auth/domain/repository/auth_repository.dart';

import '../../../../core/error/failure.dart';

@singleton
class Register {
  final AuthRepository _authRepository;

  Register(this._authRepository);

  Future<Either<Failure, RegisterResponse>> call(RegisterRequest requestData) =>
      _authRepository.register(requestData);
}
