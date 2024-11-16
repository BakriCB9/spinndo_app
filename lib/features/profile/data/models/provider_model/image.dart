class ImagesPath {
	String? path;

	ImagesPath({this.path});

	factory ImagesPath.fromJson(Map<String, dynamic> json) => ImagesPath(
				path: json['path'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'path': path,
			};
}
