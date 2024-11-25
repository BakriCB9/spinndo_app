import 'package:dartz/dartz.dart';
import 'package:snipp/core/error/failure.dart';
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
import 'package:snipp/features/auth/domain/entities/country.dart';
import 'package:snipp/features/service/domain/entities/categories.dart';

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

  Future<Either<Failure, Country>> getAddressFromCoordinates(double lat,
      double long);
}
