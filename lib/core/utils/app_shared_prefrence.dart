import 'package:app/core/error/app_exception.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class SharedPreferencesUtils {
  final SharedPreferences sharedPreferences;
  SharedPreferencesUtils(this.sharedPreferences);

  Future<bool> saveData({required String key, required dynamic value}) async {
    try {
      if (value is int) {
        return await sharedPreferences.setInt(key, value);
      } else if (value is double) {
        return await sharedPreferences.setDouble(key, value);
      } else if (value is bool) {
        return await sharedPreferences.setBool(key, value);
      }else if(value== null){
        return false;
      }
       else {
        return await sharedPreferences.setString(key, value);
      }
    } catch (e) {
      throw LocalAppException('Failed to Save data');
    }
  }

  Future<bool> removeData({required String key}) async {
    try {
      return sharedPreferences.remove(key);
    } catch (e) {
      throw LocalAppException('Failed to delete data');
    }
  }

  Object? getData({required String key}) {
    try {
      return sharedPreferences.get(key);
    } catch (e) {
      throw LocalAppException('Failed to get data');
    }
  }

  Future<String?> getString(String key) async {
    try {
      return sharedPreferences.getString(key);
    } catch (e) {
      throw LocalAppException('Failed to get data');
    }
  }

  Future<bool> clearAllData() async {
    try {
      return await sharedPreferences.clear();
    } catch (e) {
      throw LocalAppException('Failed to clear cache');
    }
  }
}
