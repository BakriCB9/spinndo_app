import 'package:dio/dio.dart';

import 'package:snipp/core/api_constant.dart';
import 'package:snipp/core/error/app_exception.dart';
import 'package:snipp/features/auth/data/models/login_response.dart';
import 'package:snipp/features/auth/data/models/register_response.dart';
import 'package:snipp/features/auth/data/models/verify_code_request.dart';
import 'package:snipp/features/auth/data/models/verify_code_response/verify_code_response.dart';

import '../models/login_request.dart';
import '../models/register_request.dart';
import 'auth_remote_data_source.dart';

class AuthAPIRemoteDataSource implements AuthRemoteDataSource {
  final _dio = Dio(BaseOptions(
    baseUrl: ApiConstant.baseUrl,
    receiveDataWhenStatusError: true,
  ));

  @override
  Future<LoginResponse> login(LoginRequest requestBody) async {
   try{ final response =
        await _dio.post(ApiConstant.loginEndPoint, data: requestBody.toJson());
    return LoginResponse.fromJson(response.data);
  }catch(exception){
     var  message='Failed to login';
     if(exception is DioException){
       final response= LoginResponse.fromJson( exception.response?.data);
    if(response.message!=null)message=response.message!;

     }       throw RemoteAppException(message);

   }

  }

  @override
  Future<RegisterResponse> register(RegisterRequest requestBody) async {
   try {
     final response = await _dio.post(ApiConstant.registerClientEndPotint,
         data: requestBody.toJson());
     return RegisterResponse.fromJson(response.data);
   }catch(exception){
     var  message='Failed to register';
     if(exception is DioException){
       final errorMessage=exception.response?.data['message'];
       if(errorMessage!=null)message=errorMessage;


     }       throw RemoteAppException(message);

   }}
  @override
  Future<VerifyCodeResponse> verifyCode(VerifyCodeRequest requestBody) async {
    final response = await _dio.post(ApiConstant.verifyCodeEndPoint,
        data: requestBody.toJson());
    return VerifyCodeResponse.fromJson(response.data);
  }
}
