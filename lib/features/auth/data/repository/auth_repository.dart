import 'package:snipp/features/auth/data/data_sources/auth_data_source.dart';
import 'package:snipp/features/auth/data/models/login_request.dart';
import 'package:snipp/features/auth/data/models/login_response.dart';
import 'package:snipp/features/auth/data/models/register_request.dart';
import 'package:snipp/features/auth/data/models/register_response.dart';
import 'package:snipp/features/auth/data/models/verify_code_request.dart';
import 'package:snipp/features/auth/data/models/verify_code_response/verify_code_response.dart';

class AuthRepository {
  final AuthDataSource _authDataSource;

  AuthRepository(this._authDataSource);

  Future<LoginResponse> login(LoginRequest requestData) async {
    return _authDataSource.login(requestData);
  }

  Future<RegisterResponse> register(RegisterRequest requestData) async {
    return _authDataSource.register(requestData);
  }
  Future<VerifyCodeResponse> verifyCode(VerifyCodeRequest requestData) async {
    return _authDataSource.verifyCode(requestData);
  }
}
