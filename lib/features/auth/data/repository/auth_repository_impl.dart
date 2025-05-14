import 'package:app/core/constant.dart';
import 'package:app/core/network/remote/handle_dio_exception.dart';
import 'package:app/core/utils/app_shared_prefrence.dart';
import 'package:app/features/auth/data/models/upgeade_regiest_service_provider.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:app/core/error/app_exception.dart';
import 'package:app/core/error/failure.dart';
import 'package:app/features/auth/data/data_sources/local/auth_local_data_source.dart';
import 'package:app/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:app/features/auth/data/models/data.dart';
import 'package:app/features/auth/data/models/login_request.dart';
import 'package:app/features/auth/data/models/register_request.dart';
import 'package:app/features/auth/data/models/register_response.dart';
import 'package:app/features/auth/data/models/register_service_provider_request.dart';
import 'package:app/features/auth/data/models/register_service_provider_response.dart';
import 'package:app/features/auth/data/models/resend_code_request.dart';
import 'package:app/features/auth/data/models/resend_code_response.dart';
import 'package:app/features/auth/data/models/reset_password_request.dart';
import 'package:app/features/auth/data/models/reset_password_response.dart';
import 'package:app/features/auth/data/models/verify_code_request.dart';
import 'package:app/features/auth/domain/entities/country.dart';
import 'package:app/features/auth/domain/repository/auth_repository.dart';
import 'package:app/features/service/domain/entities/categories.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;
  final SharedPreferencesUtils _sharedPreferencesUtils;

  AuthRepositoryImpl(this._authRemoteDataSource, this._sharedPreferencesUtils,
      this._authLocalDataSource);

  @override
  Future<Either<Failure, Data>> login(LoginRequest requestData) async {
    try {
      final response = await _authRemoteDataSource.login(requestData);
      await _saveInfoUser(response);

      return Right(response.data!);
    } catch (e) {
      final exception = HandleException.exceptionType(e);
      return Left(Failure(exception));
    }
  }

  @override
  Future<Either<Failure, RegisterResponse>> register(
      RegisterRequest requestData) async {
    try {
      final response = await _authRemoteDataSource.register(requestData);

      return Right(response);
    } catch (e) {
      final exception = HandleException.exceptionType(e);
      return Left(Failure(exception));
    }
  }

  @override
  Future<Either<Failure, Data>> verifyCode(
      VerifyCodeRequest requestData) async {
    try {
      final response = await _authRemoteDataSource.verifyCode(requestData);
      await _saveInfoUser(response);

      return Right(response.data!);
    } catch (e) {
      final exception = HandleException.exceptionType(e);
      return Left(Failure(exception));
    }
  }

  @override
  Future<Either<Failure, RegisterServiceProviderResponse>> registerService(
      RegisterServiceProviderRequest requestData) async {
    try {
      final response = await _authRemoteDataSource.registerService(requestData);
      await _authLocalDataSource.saveUserUnCompliteAccount(
        requestData.email,
      );

      return Right(response);
    } catch (e) {
      final exception = HandleException.exceptionType(e);
      return Left(Failure(exception));
    }
  }

  @override
  Future<Either<Failure, ResendCodeResponse>> resendCode(
      ResendCodeRequest requestData) async {
    try {
      final response = await _authRemoteDataSource.resendCode(requestData);

      return Right(response);
    } catch (e) {
      final exception = HandleException.exceptionType(e);
      return Left(Failure(exception));
    }
  }

  @override
  Future<Either<Failure, ResetPasswordResponse>> resetPassword(
      ResetPasswordRequest requestData) async {
    try {
      final response = await _authRemoteDataSource.resetPassword(requestData);

      return Right(response);
    } catch (e) {
      final exception = HandleException.exceptionType(e);
      return Left(Failure(exception));
    }
  }

  @override
  Future<Either<Failure, List<Categories>>> getCategories() async {
    try {
      final getCategoriesResponse =
          await _authRemoteDataSource.getAllCategory();
      return Right(getCategoriesResponse.data!);
    } catch (e) {
      final exception = HandleException.exceptionType(e);
      return left(Failure(exception));
    }
  }

  @override
  Future<Either<Failure, Country>> getAddressFromCoordinates(
      double lat, double long) async {
    try {
      final response =
          await _authRemoteDataSource.getAddressFromCoordinates(lat, long);
      return response.isEmpty
          ? Right(Country(cityName: 'unKnown city', address: 'unknow address'))
          : Right(Country(cityName: response[0], address: response[1]));
    } catch (e) {
      final exception = HandleException.exceptionType(e);
      return Left(Failure(exception));
    }
  }

  @override
  Future<Either<Failure, String>> upgradeAccount(
      UpgradeRegiestServiceProviderRequest upgradeRequest) async {
    try {
      final response =
          await _authRemoteDataSource.updgradeAccount(upgradeRequest);
      _sharedPreferencesUtils.saveData(
          key: CacheConstant.userRole, value: "ServiceProvider");
      // _authLocalDataSource.saveUserRole("ServiceProvider");
      return Right(response);
    } on AppException catch (exception) {
      return Left(Failure(exception.message));
    }
  }

  Future<void> _saveInfoUser(dynamic response) async {
    await _sharedPreferencesUtils.saveData(
        key: CacheConstant.tokenKey, value: response.data!.token);
    await _sharedPreferencesUtils.saveData(
        key: CacheConstant.userId, value: response.data!.id);
    await _sharedPreferencesUtils.saveData(
        key: CacheConstant.userRole, value: response.data!.role);
    await _sharedPreferencesUtils.saveData(
        key: CacheConstant.imagePhoto, value: response.data!.imagePath);
    await _sharedPreferencesUtils.saveData(
        key: CacheConstant.emailKey, value: response.data!.email);
    await _sharedPreferencesUtils.saveData(
        key: CacheConstant.nameKey,
        value: response.data!.firstName! + " " + response.data!.lastName!);
  }
}
