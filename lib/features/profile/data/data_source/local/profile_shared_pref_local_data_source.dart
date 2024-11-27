import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snipp/core/constant.dart';
import 'package:snipp/core/error/app_exception.dart';

import 'package:snipp/features/profile/data/data_source/local/profile_local_data_source.dart';

@Singleton(as: ProfileLocalDataSource)
class ProfileSharedPrefLocalDataSource implements ProfileLocalDataSource {
  final SharedPreferences _sharedPreferences;

  ProfileSharedPrefLocalDataSource(
      {required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;

  @override
  String getToken() {
    try {
      return _sharedPreferences.getString(CacheConstant.tokenKey)!;
    } catch (_) {
      throw LocalAppException('Failed to get token');
    }
  }

  @override
  int getUserId() {
    try {
      return _sharedPreferences.getInt(CacheConstant.userId)!;
    } catch (_) {
      throw LocalAppException('Failed to get User id');
    }
  }

  @override
  String getUserRole() {
    try {
      return _sharedPreferences.getString(CacheConstant.userRole)!;
    } catch (_) {
      throw LocalAppException('Failed to get role');
    }
  }
}
