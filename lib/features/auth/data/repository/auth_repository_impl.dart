import 'package:dartz/dartz.dart';
import 'package:snipp/core/error/app_exception.dart';
import 'package:snipp/core/error/failure.dart';
import 'package:snipp/features/auth/data/data_sources/local/auth_local_data_source.dart';
import 'package:snipp/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:snipp/features/auth/data/models/login_request.dart';
import 'package:snipp/features/auth/data/models/register_request.dart';
import 'package:snipp/features/auth/data/models/register_response.dart';
import 'package:snipp/features/auth/data/models/verify_code_request.dart';
import 'package:snipp/features/auth/data/models/verify_code_response.dart';

import '../models/login_response.dart';

class AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;

  AuthRepository(this._authRemoteDataSource, this._authLocalDataSource);

  Future<Either<Failure,LoginResponse>> login(LoginRequest requestData) async {
    try {
      final response = await _authRemoteDataSource.login(requestData);
      if (response.data!.token != null) {
        await _authLocalDataSource.saveToken(response.data!.token!);
        return Right(response);
      } else {
        return Left(RemotFailure("message"));
      }
    } on AppException catch(exception){
      return Left(RemotFailure(exception.message));
    }
  }

  Future<RegisterResponse> register(RegisterRequest requestData) async {
    return _authRemoteDataSource.register(requestData);
  }

  Future<Either<Failure,VerifyCodeResponse>> verifyCode(VerifyCodeRequest requestData) async {
    try {
      final response = await _authRemoteDataSource.verifyCode(requestData);
      if (response.data!.token != null) {
        await _authLocalDataSource.saveToken(response.data!.token!);
        return Right(response);
      } else {
        return Left(RemotFailure("message"));
      }
    } on AppException catch(exception){
      return Left(RemotFailure(exception.message));
    }
  }
}
