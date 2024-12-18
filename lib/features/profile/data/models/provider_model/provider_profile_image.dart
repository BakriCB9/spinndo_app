class Image {
  String? path;

  Image({this.path});

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        path: json['path'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'path': path,
      };
}
