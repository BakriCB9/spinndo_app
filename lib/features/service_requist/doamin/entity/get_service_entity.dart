class ServiceRequestEntity {
  int? id;
  String? title;
  String? desCription;
  double? price;
  int? dayDuration;
  int? userId;
  String? userName;
  String? status;
  String?userImage;
  ServiceRequestEntity({
    this.userName,
    this.dayDuration,
    this.desCription,
    this.id,
    this.price,
    this.title,
    this.userId,
    this.status,
    this.userImage,
  });

  // ServiceRequestEntity copyWith(
  //     {int? dayDuration, String? desCription, String? title, double? price}) {
  //   return ServiceRequestEntity(
  //     dayDuration: dayDuration ?? this.dayDuration,
  //     desCription: desCription ?? this.desCription,
  //     price: price ?? this.price,
  //     title: title ?? this.title,
  //     id: id,
  //     userId: userId,
  //   );
  // }
}
