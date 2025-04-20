// lib/features/package/data/model/get_packages_response.dart
class GetPackagesResponse {
  List<PackageData> data;

  GetPackagesResponse({required this.data});

  factory GetPackagesResponse.fromJson(Map<String, dynamic> json) {
    return GetPackagesResponse(
      data: (json['data'] as List).map((item) => PackageData.fromJson(item)).toList(),
    );
  }
}

class PackageData {
  String id;
  String name;
  int price;
  int duration;
  bool is_subscribed;

  PackageData({
    required this.id,
    required this.name,
    required this.price,
    required this.duration,
    required this.is_subscribed
  });

  factory PackageData.fromJson(Map<String, dynamic> json) {
    return PackageData(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      duration: json['duration'],
      is_subscribed: json['is_subscribed'],
    );
  }
}
