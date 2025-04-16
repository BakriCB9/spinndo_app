import 'package:app/features/profile/domain/entities/provider_profile_social_links.dart';

// class SocialLinks extends ProviderProfileSocialLinks {
  
//   SocialLinks({
//     super.id,
//     super.platform,
//     super.url,
//   });
//   factory SocialLinks.fromJson(Map<String, dynamic> json) {
//     return SocialLinks(
//       id: json['id'] as int?,
//       platform: json['platform'] as String?,
//       url: json['url'] as String?,
//     );
//   }
// }

class SocialLinks extends ProviderProfileSocialLinks{
  int? id;
  String? platform;
  String? url;

  SocialLinks({this.id, this.platform, this.url}){
    print('the socual links is now from data $id and plat is $platform and url is $url');
  }

  SocialLinks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    platform = json['platform'];
    url = json['url'];
  }

  
}