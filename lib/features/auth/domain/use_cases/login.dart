import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:snipp/core/error/failure.dart';
import 'package:snipp/features/auth/data/models/data.dart';
import 'package:snipp/features/auth/data/models/login_request.dart';
import 'package:snipp/features/auth/data/models/login_response.dart';
import 'package:snipp/features/auth/domain/entities/user.dart';
import 'package:snipp/features/auth/domain/repository/auth_repository.dart';
@singleton

class Login {
  final AuthRepository _authRepository;

  Login(this._authRepository);
 Future<Either<Failure, User>> call(LoginRequest requestData)=>_authRepository.login(requestData);
}