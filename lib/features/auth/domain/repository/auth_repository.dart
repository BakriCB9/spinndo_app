import 'package:app/features/auth/data/models/upgeade_regiest_service_provider.dart';
import 'package:dartz/dartz.dart';
import 'package:app/core/error/failure.dart';
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
import 'package:app/features/service/domain/entities/categories.dart';

abstract class AuthRepository {
  Future<Either<Failure, RegisterResponse>> register(
      RegisterRequest requestData);

  Future<Either<Failure, RegisterServiceProviderResponse>> registerService(
      RegisterServiceProviderRequest requestData);

  Future<Either<Failure, Data>> login(LoginRequest requestData);

  Future<Either<Failure, Data>> verifyCode(VerifyCodeRequest requestData);

  Future<Either<Failure, ResendCodeResponse>> resendCode(
      ResendCodeRequest requestData);

  Future<Either<Failure, ResetPasswordResponse>> resetPassword(
      ResetPasswordRequest requestData);

  Future<Either<Failure, List<Categories>>> getCategories();

  Future<Either<Failure, Country>> getAddressFromCoordinates(
      double lat, double long);
 Future<Either<Failure,String>>upgradeAccount(UpgradeRegiestServiceProviderRequest upgradeRequest);
}
