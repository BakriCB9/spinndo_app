import 'package:dartz/dartz.dart';
import 'package:snipp/core/error/failure.dart';
import 'package:snipp/features/auth/data/models/login_request.dart';
import 'package:snipp/features/auth/data/models/register_request.dart';
import 'package:snipp/features/auth/data/models/register_response.dart';
import 'package:snipp/features/auth/data/models/register_service_provider_request.dart';
import 'package:snipp/features/auth/data/models/register_service_provider_response.dart';
import 'package:snipp/features/auth/data/models/verify_code_request.dart';
import 'package:snipp/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, RegisterResponse>> register(
      RegisterRequest requestData);

  Future<Either<Failure, RegisterServiceProviderResponse>> registerService(
      RegisterServiceProviderRequest requestData);

  Future<Either<Failure, User>> login(LoginRequest requestData);

  Future<Either<Failure, User>> verifyCode(VerifyCodeRequest requestData);
}
