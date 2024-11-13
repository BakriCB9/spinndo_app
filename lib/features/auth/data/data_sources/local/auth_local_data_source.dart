abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
String getToken();
}
