import 'package:app/features/service/domain/entities/notifications.dart';

class NotificationData extends Notifications {
  NotificationData({
    super.title,
    super.description,
    super.type,
    super.createdAt,
    super.updatedAt,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      NotificationData(
        title: json['title'] as String?,
        description: json['description'] as String?,
        type: json['type'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );
}
