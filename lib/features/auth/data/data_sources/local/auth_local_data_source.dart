abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
Future<void> saveUserId(int  id);
  Future<void> saveUserRole(String role);
}
