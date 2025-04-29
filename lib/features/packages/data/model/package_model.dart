class PackageModel {
  final int id;
  final String name;
  final double price;
  final int duration;
  final bool is_subscribed;

  PackageModel({
    required this.id,
    required this.name,
    required this.price,
    required this.duration,
    required this.is_subscribed,
  });

  factory PackageModel.fromJson(Map<String, dynamic> json) {
    return PackageModel(
      id: json['id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      duration: json['duration'],
      is_subscribed: json['is_subscribed'],
    );
  }


  PackageModel toEntity() => PackageModel(
    id: id,
    name: name,
    price: price,
    duration: duration,
    is_subscribed: is_subscribed,
  );

  PackageModel copyWith({
    bool? is_subscribed,
  }) {
    return PackageModel(
      is_subscribed: is_subscribed ?? this.is_subscribed, price: 0, duration: 0, id: 0, name: '',
    );
  }
}


