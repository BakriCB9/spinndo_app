// import 'package:dio/dio.dart';
// import 'package:injectable/injectable.dart';
// import 'package:snipp/core/constant.dart';
// import 'package:snipp/features/drawer/data/model/log_out_response.dart';
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
