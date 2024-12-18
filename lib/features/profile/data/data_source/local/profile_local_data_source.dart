abstract class ProfileLocalDataSource {
  String getToken();
  int getUserId();
  String getUserRole();
  Future<void> imagePhoto(String image);
}
