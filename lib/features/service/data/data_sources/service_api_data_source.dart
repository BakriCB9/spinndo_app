import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:snipp/features/auth/data/data_sources/local/auth_local_data_source.dart';

import 'service_data_source.dart';

@Singleton(as: ServiceDataSource)
class ServiceApiDataSource implements ServiceDataSource {
  final Dio _dio;
  final AuthLocalDataSource _authLocalDataSource;

  ServiceApiDataSource(this._authLocalDataSource, this._dio);

  // @override
  // Future<LoginResponse> login(LoginRequest requestBody) async {
  //   try {
  //     final response = await _dio.post(ApiConstant.loginEndPoint,
  //         data: requestBody.toJson());
  //
  //     return LoginResponse.fromJson(response.data);
  //   } catch (exception) {
  //     var message = 'Failed to login';
  //
  //     if (exception is DioException) {
  //       final response = LoginResponse.fromJson(exception.response?.data);
  //       if (response.message != null) message = response.message!;
  //     }
  //     throw RemoteAppException(message);
  //   }
  // }


}
