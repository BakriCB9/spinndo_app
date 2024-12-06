import 'package:app/features/auth/data/models/login_request.dart';
import 'package:app/features/auth/data/models/login_response.dart';
import 'package:app/features/auth/data/models/register_request.dart';
import 'package:app/features/auth/data/models/register_response.dart';
import 'package:app/features/auth/data/models/register_service_provider_request.dart';
import 'package:app/features/auth/data/models/register_service_provider_response.dart';
import 'package:app/features/auth/data/models/resend_code_request.dart';
import 'package:app/features/auth/data/models/resend_code_response.dart';
import 'package:app/features/auth/data/models/reset_password_request.dart';
import 'package:app/features/auth/data/models/reset_password_response.dart';
import 'package:app/features/auth/data/models/verify_code_request.dart';
import 'package:app/features/auth/data/models/verify_code_response.dart';
import 'package:app/features/auth/domain/entities/country.dart';
import 'package:app/features/service/data/models/get_all_category_response/get_all_category_response.dart';

abstract class AuthRemoteDataSource {
  Future<RegisterResponse> register(RegisterRequest requestBody);
  Future<LoginResponse> login(LoginRequest requestBody);
  Future<VerifyCodeResponse> verifyCode(VerifyCodeRequest requestBody);
  Future<RegisterServiceProviderResponse> registerService(
      RegisterServiceProviderRequest requestBody);
  Future<ResendCodeResponse> resendCode(ResendCodeRequest requestBody);
  Future<ResetPasswordResponse> resetPassword(ResetPasswordRequest requestBody);
  Future<GetAllCategoryResponse> getAllCategory();
  Future<List<String>> getAddressFromCoordinates(double lat, double long);
}
