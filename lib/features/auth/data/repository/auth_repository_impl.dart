import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:snipp/core/error/app_exception.dart';
import 'package:snipp/core/error/failure.dart';
import 'package:snipp/features/auth/data/data_sources/local/auth_local_data_source.dart';
import 'package:snipp/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:snipp/features/auth/data/models/data.dart';
import 'package:snipp/features/auth/data/models/login_request.dart';
import 'package:snipp/features/auth/data/models/register_request.dart';
import 'package:snipp/features/auth/data/models/register_response.dart';
import 'package:snipp/features/auth/data/models/register_service_provider_request.dart';
import 'package:snipp/features/auth/data/models/register_service_provider_response.dart';
import 'package:snipp/features/auth/data/models/resend_code_request.dart';
import 'package:snipp/features/auth/data/models/resend_code_response.dart';
import 'package:snipp/features/auth/data/models/reset_password_request.dart';
import 'package:snipp/features/auth/data/models/reset_password_response.dart';
import 'package:snipp/features/auth/data/models/verify_code_request.dart';
import 'package:snipp/features/auth/domain/repository/auth_repository.dart';

@Singleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;

  AuthRepositoryImpl(this._authRemoteDataSource, this._authLocalDataSource);

  @override
  Future<Either<Failure, Data>> login(LoginRequest requestData) async {
    try {
      final response = await _authRemoteDataSource.login(requestData);
      await _authLocalDataSource.saveToken(response.data!.token);
      await _authLocalDataSource.saveUserId(response.data!.id);
      await _authLocalDataSource.saveUserRole(response.data!.role);

      return Right(response.data!);
    } on AppException catch (exception) {
      return Left(RemotFailure(exception.message));
    }
  }

  @override
  Future<Either<Failure, RegisterResponse>> register(
      RegisterRequest requestData) async {
    try {
      final response = await _authRemoteDataSource.register(requestData);
          // await _authLocalDataSource.saveToken(response.data!);

      return Right(response);
    } on AppException catch (exception) {
      return Left(RemotFailure(exception.message));
    }
  }

  @override
  Future<Either<Failure, Data>> verifyCode(
      VerifyCodeRequest requestData) async {
    try {
      final response = await _authRemoteDataSource.verifyCode(requestData);
      await _authLocalDataSource.saveToken(response.data!.token);
      await _authLocalDataSource.saveUserId(response.data!.id);
      await _authLocalDataSource.saveUserRole(response.data!.role);

      return Right(response.data!);
    } on AppException catch (exception) {
      return Left(RemotFailure(exception.message));
    }
  }

  @override
  Future<Either<Failure, RegisterServiceProviderResponse>> registerService(
      RegisterServiceProviderRequest requestData) async {
    try {
      final response = await _authRemoteDataSource.registerService(requestData);
      return Right(response);
    } on AppException catch (exception) {
      return Left(RemotFailure(exception.message));
    }
  }

  @override
  Future<Either<Failure, ResendCodeResponse>> resendCode(ResendCodeRequest requestData)  async {
    try {
      final response = await _authRemoteDataSource.resendCode(requestData);

      return Right(response);
    } on AppException catch (exception) {
      return Left(RemotFailure(exception.message));
    }
  }

  @override
  Future<Either<Failure, ResetPasswordResponse>> resetPassword(ResetPasswordRequest requestData)  async {
    try {
      final response = await _authRemoteDataSource.resetPassword(requestData);

      return Right(response);
    } on AppException catch (exception) {
      return Left(RemotFailure(exception.message));
    }
  }
}
