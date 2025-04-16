class SocialMediaLinksRequest {
  String platform;
  String url;
  SocialMediaLinksRequest({
    required this.platform,
    required this.url,
  });

  Map<String, dynamic> toJson() => {"platform": platform, "url": url};
}
