import 'package:app/core/utils/app_shared_prefrence.dart';
import 'package:app/features/auth/data/models/upgeade_regiest_service_provider.dart';
import 'package:app/main.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:app/core/constant.dart';
import 'package:app/features/auth/data/models/register_response.dart';
import 'package:app/features/auth/data/models/register_service_provider_request.dart';
import 'package:app/features/auth/data/models/register_service_provider_response.dart';
import 'package:app/features/auth/data/models/resend_code_request.dart';
import 'package:app/features/auth/data/models/resend_code_response.dart';
import 'package:app/features/auth/data/models/reset_password_request.dart';
import 'package:app/features/auth/data/models/reset_password_response.dart';
import 'package:app/features/auth/data/models/verify_code_request.dart';
import 'package:app/features/auth/data/models/verify_code_response.dart';
import 'package:app/features/service/data/models/get_all_category_response/get_all_category_response.dart';

import '../../models/login_request.dart';
import '../../models/login_response.dart';
import '../../models/register_request.dart';
import 'auth_remote_data_source.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthAPIRemoteDataSource implements AuthRemoteDataSource {
  final Dio _dio;
  final SharedPreferencesUtils? _sharedPreferencesUtils;

  AuthAPIRemoteDataSource(this._dio, this._sharedPreferencesUtils);

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

  @override
  Future<RegisterServiceProviderResponse> registerService(
      RegisterServiceProviderRequest requestBody) async {
    var requestSend = await requestBody.toFormData();

    for (int i = 0; i < requestBody.images.length; i++) {
      requestSend.files.add(MapEntry(
          'service[images][$i]', // Field name expected by the server
          await MultipartFile.fromFile(
            requestBody.images[i]!.path,
            filename: requestBody.images[i]!.path.split('/').last,
          )));
    }
    final response = await _dio
        .post(ApiConstant.registerServiceProviderEndPoint, data: requestSend);
    return RegisterServiceProviderResponse.fromJson(response.data);
  }

  @override
  Future<String> updgradeAccount(
      UpgradeRegiestServiceProviderRequest requestBody) async {
    var requestSend = await requestBody.toFormData();
    for (int i = 0; i < requestBody.images.length; i++) {
      requestSend.files.add(
        MapEntry(
          'service[images][$i]', // Field name expected by the server
          await MultipartFile.fromFile(
            requestBody.images[i]!.path,
            filename: requestBody.images[i]!.path.split('/').last,
          ),
        ),
      );
    }

    final lang = sharedPref.getString('language');
    final userToken = sharedPref.getString(CacheConstant.tokenKey);
    final response = await _dio.post(ApiConstant.upgradeAccount,
        data: requestSend,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $userToken",
          "Accept-Language": '$lang'
        }));

    return response.data['status'];
  }

  @override
  Future<ResendCodeResponse> resendCode(ResendCodeRequest requestBody) async {
    final response = await _dio.post(ApiConstant.resendCodeEndPoint,
        data: requestBody.toJson());
    return ResendCodeResponse.fromJson(response.data);
  }

  @override
  Future<ResetPasswordResponse> resetPassword(
      ResetPasswordRequest requestBody) async {
    final response = await _dio.post(ApiConstant.resetPasswordEndPoint,
        data: requestBody.toJson());
    return ResetPasswordResponse.fromJson(response.data);
  }

  @override
  Future<GetAllCategoryResponse> getAllCategory() async {
    final response = await _dio.get(
      ApiConstant.getAllCategory,
    );

    return GetAllCategoryResponse.fromJson(response.data);
  }

  @override
  Future<List<String>> getAddressFromCoordinates(
      double lat, double long) async {
    final String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=${ApiConstant.googleMapApiKey}';

    final response = await _dio.get(url);

    final data = response.data;

    if (data['status'] == 'OK' && data['results'].isNotEmpty) {
      var address = data['results'][4]['formatted_address'];
      var cityName = data['results'][0]['address_components'][1]['long_name'];
      return [cityName, address];
    } else {
      return [];
    }
  }
}
