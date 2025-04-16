import 'package:app/features/service_requist/doamin/entity/get_service_entity.dart';

class DataOfAllServiceRequest {
  int? id;
  String? title;
  String? description;
  double? price;
  int? daysDuration;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? userId;
  String? userName;
  String? userNameAr;
  dynamic userImage;

  DataOfAllServiceRequest({
    this.id,
    this.title,
    this.description,
    this.price,
    this.daysDuration,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.userName,
    this.userNameAr,
    this.userImage,
  });

  factory DataOfAllServiceRequest.fromJson(Map<String, dynamic> json) =>
      DataOfAllServiceRequest(
        id: json['id'] as int?,
        title: json['title'] as String?,
        description: json['description'] as String?,
        price: (json['price'] as num?)?.toDouble(),
        daysDuration: json['days_duration'] as int?,
        status: json['status'] as String?,
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
        userId: json['user_id'] as int?,
        userName: json['user_name'] as String?,
        userNameAr: json['user_name_ar'] as String?,
        userImage: json['user_image'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'price': price,
        'days_duration': daysDuration,
        'status': status,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'user_id': userId,
        'user_name': userName,
        'user_name_ar': userNameAr,
        'user_image': userImage,
      };
  ServiceRequestEntity toServiceRequestEntity() {
    return ServiceRequestEntity(
        dayDuration: daysDuration,
        desCription: description,
        userName: userName,
        userImage: userImage,
        status: status,
        id: id,
        price: price,
        title: title,
        userId: userId);
  }
}
