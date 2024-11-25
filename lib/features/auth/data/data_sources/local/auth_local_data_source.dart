abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
Future<void> saveUserId(int  id);
  Future<void> saveUserRole(String role);
  Future<void> saveUserUnCompliteAccount(String email);
  Future<void> saveUserName(String name);
  Future<void> saveUserEmail(String email);
  String getUserUnCompliteAccount();
  Future<void> deleteEmail();
}
