import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snipp/core/constant.dart';
import 'package:snipp/core/error/app_exception.dart';
import 'package:snipp/features/auth/data/data_sources/local/auth_local_data_source.dart';
@Singleton(as: AuthLocalDataSource)
class AuthSharedPrefLocalDataSource implements AuthLocalDataSource {
  @override
  Future<String> getToken() async {
    try {
      final sharedPref = await SharedPreferences.getInstance();
      return sharedPref.getString(CacheConstant.tokenKey)!;
    } catch (_) {
      throw LocalAppException('Failed to get token');
    }
  }

  @override
  Future<void> saveToken(String token) async {
    try {
      final sharedPref = await SharedPreferences.getInstance();
      await sharedPref.setString(CacheConstant.tokenKey, token);
    } catch (_) {
      throw LocalAppException('Failed to store token');
    }
  }
}
