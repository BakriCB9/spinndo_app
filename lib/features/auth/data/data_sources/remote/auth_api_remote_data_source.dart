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
import 'package:snipp/features/auth/domain/entities/country.dart';
import 'package:snipp/features/service/data/models/get_all_category_response/get_all_category_response.dart';

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
      print("ccccc");
      print(requestBody.toJson());
      final response = await _dio.post(ApiConstant.loginEndPoint,
          data: requestBody.toJson());
      print(response);
      print("asdasd");
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
      print(
          'the data response  GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG  is ${response.data}');
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
  Future<ResendCodeResponse> resendCode(ResendCodeRequest requestBody) async {
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
  Future<ResetPasswordResponse> resetPassword(
      ResetPasswordRequest requestBody) async {
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

  @override
  Future<GetAllCategoryResponse> getAllCategory() async {
    try {
      final response = await _dio.get(
        ApiConstant.getAllCategory,
      );

      return GetAllCategoryResponse.fromJson(response.data);
    } catch (exciption) {
      throw RemoteAppException("Failed to get categories");
    }
  }

  @override
  Future<List<String>> getAddressFromCoordinates(
      double lat, double long) async {
    final String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=${ApiConstant.googleMapApiKey}';

    try {
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        final data = response.data;

        if (data['status'] == 'OK' && data['results'].isNotEmpty) {
          var cityName =
              data['results'][0]['address_components'][1]['long_name'];
          var countryName =
              data['results'][0]['address_components'][4]['long_name'];

          return [countryName, cityName];
        } else {
          throw Exception('No results found');
        }
      } else {
        throw Exception('Failed to load geocoding data');
      }
    } catch (e) {
      throw Exception('Error fetching address: $e');
    }
  }
}
