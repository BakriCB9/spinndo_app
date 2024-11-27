// import 'package:injectable/injectable.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:snipp/core/constant.dart';
// import 'package:snipp/core/error/app_exception.dart';
// import 'package:snipp/features/auth/data/data_sources/local/auth_local_data_source.dart';
// import 'package:snipp/features/drawer/data/data_source/local/drawer_local_data_source.dart';
//
// @Singleton(as: DrawerLocalDataSource)
// class DrawerSharedPrefLocalDataSource implements DrawerLocalDataSource {
//   final SharedPreferences _sharedPreferences;
//
//   DrawerSharedPrefLocalDataSource({required SharedPreferences sharedPreferences})
//       : _sharedPreferences = sharedPreferences;
//
//   @override
//   Future<void> saveToken(String token) async {
//     try {
//       await _sharedPreferences.setString(CacheConstant.tokenKey, token);
//     } catch (_) {
//       throw LocalAppException('Failed to store token');
//     }
//   }
//
//   @override
//   Future<void> saveUserId(int id) async {
//     try {
//       await _sharedPreferences.setInt(CacheConstant.userId, id);
//     } catch (_) {
//       throw LocalAppException('Failed to store User Id');
//     }
//   }
//
//   @override
//   Future<void> saveUserRole(String role) async {
//     try {
//       await _sharedPreferences.setString(CacheConstant.userRole, role);
//     } catch (_) {
//       throw LocalAppException('Failed to store role');
//     }
//   }
//
//   @override
//   String getUserUnCompliteAccount() {
//     try {
//       return _sharedPreferences.getString(CacheConstant.emailKey)!;
//     } catch (_) {
//       throw LocalAppException('Failed to get email');
//     }
//   }
//
//   @override
//   Future<void> saveUserUnCompliteAccount(String email) async {
//     try {
//       await _sharedPreferences.setString(CacheConstant.emailKey, email);
//     } catch (_) {
//       throw LocalAppException('Failed to store email');
//     }
//   }
//
//   @override
//   Future<void> deleteEmail() async {
//     await _sharedPreferences.remove(CacheConstant.emailKey);
//   }
//
//   @override
//   Future<void> saveUserEmail(String email) async {
//     try {
//       await _sharedPreferences.setString(CacheConstant.semailKey, email);
//     } catch (_) {
//       throw LocalAppException('Failed to store email');
//     }
//   }
//
//   @override
//   Future<void> saveUserName(String name) async {
//     try {
//       await _sharedPreferences.setString(CacheConstant.nameKey, name);
//     } catch (_) {
//       throw LocalAppException('Failed to store name');
//     }
//   }
// }
