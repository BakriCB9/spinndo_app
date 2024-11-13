import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:snipp/core/error/app_exception.dart';
import 'package:snipp/core/error/failure.dart';
import 'package:snipp/features/auth/data/data_sources/local/auth_local_data_source.dart';
import 'package:snipp/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:snipp/features/auth/data/models/login_request.dart';
import 'package:snipp/features/auth/data/models/register_request.dart';
import 'package:snipp/features/auth/data/models/register_response.dart';
import 'package:snipp/features/auth/data/models/register_service_provider_request.dart';
import 'package:snipp/features/auth/data/models/register_service_provider_response.dart';
import 'package:snipp/features/auth/data/models/verify_code_request.dart';
import 'package:snipp/features/auth/data/models/verify_code_response.dart';
import 'package:snipp/features/auth/domain/entities/user.dart';
import 'package:snipp/features/auth/domain/repository/auth_repository.dart';

@Singleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;

  AuthRepositoryImpl(this._authRemoteDataSource, this._authLocalDataSource);

  @override
  Future<Either<Failure, User>> login(LoginRequest requestData) async {
    try {
      final response = await _authRemoteDataSource.login(requestData);
      await _authLocalDataSource.saveToken(response.data!.token);

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
      // await _authLocalDataSource.saveToken(response.data!.token);

      return Right(response);
    } on AppException catch (exception) {
      return Left(RemotFailure(exception.message));
    }
  }

  Future<Either<Failure, User>> verifyCode(
      VerifyCodeRequest requestData) async {
    try {
      final response = await _authRemoteDataSource.verifyCode(requestData);
      await _authLocalDataSource.saveToken(response.data!.token);

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
}
