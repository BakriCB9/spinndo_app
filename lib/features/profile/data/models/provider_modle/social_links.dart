import 'package:app/features/profile/domain/entities/provider_profile_social_links.dart';

class SocialLinks extends ProviderProfileSocialLinks {
  int? id;
  String? platform;
  String? url;

  SocialLinks({this.id, this.platform, this.url});

  SocialLinks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    platform = json['platform'];
    url = json['url'];
  }
}
