import 'package:dio/dio.dart';

import 'package:snipp/core/api_constant.dart';
import 'package:snipp/features/auth/data/models/login_response.dart';
import 'package:snipp/features/auth/data/models/register_response.dart';
import 'package:snipp/features/auth/data/models/verify_code_request.dart';
import 'package:snipp/features/auth/data/models/verify_code_response/verify_code_response.dart';

import '../models/login_request.dart';
import '../models/register_request.dart';
import 'auth_data_source.dart';

class AuthAPIDataSource implements AuthDataSource {
  final _dio = Dio(BaseOptions(
    baseUrl: ApiConstant.baseUrl,
    receiveDataWhenStatusError: true,
  ));

  @override
  Future<LoginResponse> login(LoginRequest requestBody) async {
    final response =
        await _dio.post(ApiConstant.loginEndPoint, data: requestBody.toJson());
    return LoginResponse.fromJson(response.data);
  }

  @override
  Future<RegisterResponse> register(RegisterRequest requestBody) async {
    final response = await _dio.post(ApiConstant.registerClientEndPotint,
        data: requestBody.toJson());
    return RegisterResponse.fromJson(response.data);
  }
  @override
  Future<VerifyCodeResponse> verifyCode(VerifyCodeRequest requestBody) async {
    final response = await _dio.post(ApiConstant.verifyCodeEndPoint,
        data: requestBody.toJson());
    return VerifyCodeResponse.fromJson(response.data);
  }
}
