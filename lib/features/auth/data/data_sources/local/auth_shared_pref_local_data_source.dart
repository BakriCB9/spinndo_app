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
  String getToken() {
    try {
      return _sharedPreferences.getString(CacheConstant.tokenKey)!;
    } catch (_) {
      throw LocalAppException('Failed to get token');
    }
  }

  @override
  Future<void> saveToken(String token) async {
    try {
      await _sharedPreferences.setString(CacheConstant.tokenKey, token);
    } catch (_) {
      throw LocalAppException('Failed to store token');
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
  Future<void> saveUserId(int id) async {
    try {
      await _sharedPreferences.setInt(CacheConstant.userId, id);
    } catch (_) {
      throw LocalAppException('Failed to store User Id');
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

  @override
  Future<void> saveUserRole(String role)  async {
    try {
      await _sharedPreferences.setString(CacheConstant.userRole, role);
    } catch (_) {
      throw LocalAppException('Failed to store role');
    }
  }
}
