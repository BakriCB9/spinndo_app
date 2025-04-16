import 'package:app/core/constant.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => Dio(BaseOptions(
        baseUrl: ApiConstant.baseUrl,
        receiveDataWhenStatusError: true,

        // connectTimeout:const  Duration(seconds: 120),
        // receiveTimeout:const  Duration(seconds: 120)
      ));

  @preResolve
  Future<SharedPreferences> get sharedPrefrences =>
      SharedPreferences.getInstance();
}
