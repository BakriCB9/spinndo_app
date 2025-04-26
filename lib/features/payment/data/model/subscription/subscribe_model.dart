class SubscribeModel {
  final int userId;
  final int packageId;

  SubscribeModel({
    required this.userId,
    required this.packageId,
  });


  Map<String, dynamic> toJson() {
    return {
      "user_id": userId,
      "package_id": packageId,
    };
  }
}
