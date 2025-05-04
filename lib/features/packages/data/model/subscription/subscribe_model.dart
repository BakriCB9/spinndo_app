class SubscribeModel {
   int? id;
   int? userId;
   int? packageId;
   String? startDate;
   String? endDate;
   String? status;

  SubscribeModel({
     this.id,
     this.userId,
     this.packageId,
     this.startDate,
     this.endDate,
     this.status,
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
