abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
String getToken();
Future<void> saveUserId(int  id);
int  getUserId();
}
