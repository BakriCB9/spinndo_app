import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snipp/core/constant.dart';

@module
abstract class RegisterModule {

  @lazySingleton
  Dio get dio => Dio(BaseOptions(
    baseUrl: ApiConstant.baseUrl,
    receiveDataWhenStatusError: true,
  ));

  @preResolve
  Future<SharedPreferences> get sharedPrefrences => SharedPreferences.getInstance();
}