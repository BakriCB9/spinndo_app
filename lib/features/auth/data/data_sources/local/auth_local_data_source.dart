abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
String getToken();
Future<void> saveUserId(int  id);
int  getUserId();
  Future<void> saveUserRole(String role);
  String  getUserRole();
}
