abstract class GoogleMapRemoteDataSource {
  Future<List<String>> getAddressFromCoordinates(double lat, double long);
}
