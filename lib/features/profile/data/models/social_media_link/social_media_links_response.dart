import 'package:app/features/profile/domain/entities/add_or_update_soical_entity/add_or_update_social_entity.dart';

class SocialMediaLinksResponse {
  String? status;
  String? message;
  Data? data;

  SocialMediaLinksResponse({this.status, this.message, this.data});

  SocialMediaLinksResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? id;
  String? platform;
  String? url;

  Data({
    this.id,
    this.platform,
    this.url,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    platform = json['platform'];
    url = json['url'];
  }
  AddOrUpdateSocialEntity toAddOrUpdateSocialEntity() =>
      AddOrUpdateSocialEntity(id: id, platform: platform, url: url);
}
