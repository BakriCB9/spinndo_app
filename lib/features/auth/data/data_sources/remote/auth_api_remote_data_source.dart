import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:snipp/core/constant.dart';

import 'package:snipp/core/error/app_exception.dart';
import 'package:snipp/features/auth/data/models/register_response.dart';
import 'package:snipp/features/auth/data/models/register_service_provider_request.dart';
import 'package:snipp/features/auth/data/models/register_service_provider_response.dart';
import 'package:snipp/features/auth/data/models/resend_code_request.dart';
import 'package:snipp/features/auth/data/models/resend_code_response.dart';
import 'package:snipp/features/auth/data/models/reset_password_request.dart';
import 'package:snipp/features/auth/data/models/reset_password_response.dart';
import 'package:snipp/features/auth/data/models/verify_code_request.dart';
import 'package:snipp/features/auth/data/models/verify_code_response.dart';

import '../../models/login_request.dart';
import '../../models/login_response.dart';
import '../../models/register_request.dart';
import 'auth_remote_data_source.dart';

@Singleton(as: AuthRemoteDataSource)
class AuthAPIRemoteDataSource implements AuthRemoteDataSource {
  final Dio _dio;

  AuthAPIRemoteDataSource({required Dio dio}) : _dio = dio;

  @override
  Future<LoginResponse> login(LoginRequest requestBody) async {
    try {
      final response = await _dio.post(ApiConstant.loginEndPoint,
          data: requestBody.toJson());

      return LoginResponse.fromJson(response.data);
    } catch (exception) {
      var message = 'Failed to login';

      if (exception is DioException) {
        final response = LoginResponse.fromJson(exception.response?.data);
        if (response.message != null) message = response.message!;
      }
      throw RemoteAppException(message);
    }
  }

  @override
  Future<RegisterResponse> register(RegisterRequest requestBody) async {
    try {
      final response = await _dio.post(ApiConstant.registerClientEndPotint,
          data: requestBody.toJson());
      return RegisterResponse.fromJson(response.data);
    } catch (exception) {
      var message = 'Failed to register';
      if (exception is DioException) {
        final errorMessage = exception.response?.data['message'];

        if (errorMessage != null) message = errorMessage;
      }
      throw RemoteAppException(message);
    }
  }

  @override
  Future<VerifyCodeResponse> verifyCode(VerifyCodeRequest requestBody) async {
    try {
      final response = await _dio.post(ApiConstant.verifyCodeEndPoint,
          data: requestBody.toJson());
          print('the data response  GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG  is ${response.data}');
      return VerifyCodeResponse.fromJson(response.data);
    } catch (exception) {
      var message = 'Failed to verify Code';
      if (exception is DioException) {
        final errorMessage = exception.response?.data['message'];
        print('the error message is $errorMessage');
        if (errorMessage != null) message = errorMessage;
      }
      throw RemoteAppException(message);
    }
  }

  @override
  Future<RegisterServiceProviderResponse> registerService(
      RegisterServiceProviderRequest requestBody) async {
    try {
      final requestSend = await requestBody.toFormData();

      final response = await _dio
          .post(ApiConstant.registerServiceProviderEndPoint, data: requestSend);
      return RegisterServiceProviderResponse.fromJson(response.data);
    } catch (exception) {
      var message = 'Failed to register';
      if (exception is DioException) {
        final errorMessage = exception.response?.data['message'];
        print('the message error ${errorMessage}');
        print('the exception error ${exception}');
        if (errorMessage != null) message = errorMessage;
      }

      throw RemoteAppException(message);
    }
  }

  @override
  Future<ResendCodeResponse> resendCode(ResendCodeRequest requestBody)  async {
    try {
      final response = await _dio.post(ApiConstant.resendCodeEndPoint,
          data: requestBody.toJson());
      return ResendCodeResponse.fromJson(response.data);
    } catch (exception) {
      var message = 'Failed to resend code';
      if (exception is DioException) {
        final errorMessage = exception.response?.data['message'];

        if (errorMessage != null) message = errorMessage;
      }
      throw RemoteAppException(message);
    }
  }

  @override
  Future<ResetPasswordResponse> resetPassword(ResetPasswordRequest requestBody)  async {
    try {
      final response = await _dio.post(ApiConstant.resetPasswordEndPoint,
          data: requestBody.toJson());
      return ResetPasswordResponse.fromJson(response.data);
    } catch (exception) {
      var message = 'Failed to reset password';
      if (exception is DioException) {
        final errorMessage = exception.response?.data['message'];

        if (errorMessage != null) message = errorMessage;
      }
      throw RemoteAppException(message);
    }
  }
}
