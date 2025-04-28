// import 'package:dio/dio.dart';
// import 'package:injectable/injectable.dart';
// import 'package:app/core/constant.dart';
// import 'package:app/features/drawer/data/model/log_out_response.dart';
//
// import 'drawer_remote_data_source.dart';
//
// @Singleton(as: DrawerRemoteDataSource)
// class DrawerApiRemoteDataSource implements DrawerRemoteDataSource {
//   final Dio _dio;
//
//   DrawerApiRemoteDataSource({required Dio dio}) : _dio = dio;
//
//   @override
//   Future<LogOutResponse>logout() async {
//     try {
//       final response = await _dio.post(ApiConstant.logoutEndPoint,
//       options:Options(headers: {
//         "Content-Type": "application/json",
//         "Authorization": "Bearer $shar"
//       }));
//       print(response);
//       print("asdasd");
//       return LoginResponse.fromJson(response.data);
//     } catch (exception) {
//       var message = 'Failed to login';
//
//       if (exception is DioException) {
//         final response = LoginResponse.fromJson(exception.response?.data);
//         if (response.message != null) message = response.message!;
//       }
//       throw RemoteAppException(message);
//     }
//   }
//
//
// }

import 'package:app/core/constant.dart';
import 'package:app/core/error/app_exception.dart';
import 'package:app/features/drawer/data/data_source/remote/drawer_remote_data_source.dart';
import 'package:app/features/drawer/data/model/change_password_request.dart';
import 'package:app/features/drawer/data/model/change_password_response.dart';
import 'package:app/main.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: DrawerRemoteDataSource)
class DrawerRemoteDataSourceImpl implements DrawerRemoteDataSource {
  Dio _dio;
  DrawerRemoteDataSourceImpl(this._dio);
  @override
  Future<String> changePassword(ChangePasswordRequest changeRequest) async {
    try {
      final userToken = sharedPref.getString(CacheConstant.tokenKey);
      print('the token is $userToken');
      print('the data is ${changeRequest.toJson()}');
      final ans = await _dio.post(ApiConstant.changePassword,
          data: changeRequest.toJson(),
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $userToken"
          }));
      print(
          'we success here rooorrororr *************************************');
      final result = ChangePasswordResponse.fromJson(ans.data);
      return result.message ?? '';
    } catch (exception) {
      print('the exception is now $exception');
      String message = 'failed try again';
      if (exception is DioException) {
        final errorMessage = exception.response?.data['message'];
        print('the error messge baakakakakakakr is $errorMessage');
        if (errorMessage != null) message = errorMessage;
      }
      print('the message is s s s s ss $message');
      throw RemoteAppException(message);
    }
  }
}
