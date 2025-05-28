import 'package:app/core/constant.dart';
import 'package:app/core/error/app_exception.dart';
import 'package:app/core/utils/app_shared_prefrence.dart';
import 'package:app/features/drawer/data/data_source/remote/drawer_remote_data_source.dart';
import 'package:app/features/drawer/data/model/change_email/change_email_request.dart';
import 'package:app/features/drawer/data/model/change_email/change_email_response.dart';
import 'package:app/features/drawer/data/model/change_password_request.dart';
import 'package:app/features/drawer/data/model/change_password_response.dart';
import 'package:app/main.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: DrawerRemoteDataSource)
class DrawerRemoteDataSourceImpl implements DrawerRemoteDataSource {
  Dio _dio;
  SharedPreferencesUtils _sharedPreferencesUtils;
  DrawerRemoteDataSourceImpl(this._dio, this._sharedPreferencesUtils);
  @override
  Future<String> changePassword(ChangePasswordRequest changeRequest) async {
    try {
      final userToken = sharedPref.getString(CacheConstant.tokenKey);

      final ans = await _dio.post(ApiConstant.changePassword,
          data: changeRequest.toJson(),
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $userToken"
          }));

      final result = ChangePasswordResponse.fromJson(ans.data);
      return result.message ?? '';
    } catch (exception) {
      String message = 'failed try again';
      if (exception is DioException) {
        final errorMessage = exception.response?.data['message'];

        if (errorMessage != null) message = errorMessage;
      }

      throw RemoteAppException(message);
    }
  }

  @override
  Future<ChangeEmailResponse> changeEmail(
      ChangeEmailRequest changeEmailRequest) async {
    final userToken = _sharedPreferencesUtils.getString(CacheConstant.tokenKey);
    final response = await _dio.post(ApiConstant.changeEmail,
        data: changeEmailRequest.toJson(),
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $userToken"
        }));
    _sharedPreferencesUtils.saveData(
        key: CacheConstant.emailKey, value: changeEmailRequest.newEmail);
    return ChangeEmailResponse.fromJson(response.data);
  }
}
