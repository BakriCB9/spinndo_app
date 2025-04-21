class PackageModel {
  final int id;
  final String name;
  final double price;
  final int durationDays;
  final bool is_subscribed;

  PackageModel({
    required this.id,
    required this.name,
    required this.price,
    required this.durationDays,
    required this.is_subscribed,
  });

  factory PackageModel.fromJson(Map<String, dynamic> json) {
    return PackageModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      durationDays: json['durationDays'],
      is_subscribed: json['is_subscribed'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'price': price,
    'durationDays': durationDays,
    'is_subscribed': is_subscribed,
  };

}
