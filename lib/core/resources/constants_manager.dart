class Constants {
  static const kEndpoint = 'http://TrainingApi.CyberRoyale.net/v1';
  static const kProjectId = 'CyberRoyaleProjectID';
  static const splashDelay = 2000;

  static String storageFileLink({
    required String bucketId,
    required String id,
  }) =>
      '$kEndpoint/storage/buckets/$bucketId/files/$id/view?project=$kProjectId&mode=admin';
}
