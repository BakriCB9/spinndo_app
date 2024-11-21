import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snipp/core/constant.dart';
import 'package:snipp/core/error/app_exception.dart';
import 'package:snipp/features/auth/data/data_sources/local/auth_local_data_source.dart';

@Singleton(as: AuthLocalDataSource)
class AuthSharedPrefLocalDataSource implements AuthLocalDataSource {
  final SharedPreferences _sharedPreferences;

  AuthSharedPrefLocalDataSource({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;



  @override
  Future<void> saveToken(String token) async {
    try {
      await _sharedPreferences.setString(CacheConstant.tokenKey, token);
    } catch (_) {
      throw LocalAppException('Failed to store token');
    }
  }



  @override
  Future<void> saveUserId(int id) async {
    try {
      await _sharedPreferences.setInt(CacheConstant.userId, id);
    } catch (_) {
      throw LocalAppException('Failed to store User Id');
    }
  }


  @override
  Future<void> saveUserRole(String role)  async {
    try {
      await _sharedPreferences.setString(CacheConstant.userRole, role);
    } catch (_) {
      throw LocalAppException('Failed to store role');
    }
  }
}
