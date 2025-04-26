class SubscribeModel {
  final int id;
  final int userId;
  final int packageId;
  final String startDate;
  final String endDate;
  final String status;

  SubscribeModel({
    required this.id,
    required this.userId,
    required this.packageId,
    required this.startDate,
    required this.endDate,
    required this.status,
  });

  factory SubscribeModel.fromJson(Map<String, dynamic> json) {
    return SubscribeModel(
      id: json['id'],
      userId: json['user_id'],
      packageId: json['package_id'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() =>
      {
        "id":id,
        "user_id":userId,
        "package_id":packageId,
        "start_date": startDate,
        "end_date": endDate,
        "status": status,
      };

}
