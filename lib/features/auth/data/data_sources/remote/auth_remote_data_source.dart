import 'package:snipp/features/auth/data/models/login_request.dart';
import 'package:snipp/features/auth/data/models/login_response.dart';
import 'package:snipp/features/auth/data/models/register_request.dart';
import 'package:snipp/features/auth/data/models/register_response.dart';
import 'package:snipp/features/auth/data/models/verify_code_request.dart';
import 'package:snipp/features/auth/data/models/verify_code_response/verify_code_response.dart';

abstract class AuthRemoteDataSource {
  Future<RegisterResponse> register(RegisterRequest requestBody);
  Future<LoginResponse> login(LoginRequest requestBody);
  Future<VerifyCodeResponse> verifyCode(VerifyCodeRequest requestBody);
}
