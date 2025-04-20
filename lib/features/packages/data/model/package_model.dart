class PackageModel {
  final int id;
  final String name;
  final double price;
  final int durationDays;
  final String description;

  PackageModel({
    required this.id,
    required this.name,
    required this.price,
    required this.durationDays,
    required this.description,
  });

  factory PackageModel.fromJson(Map<String, dynamic> json) {
    return PackageModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      durationDays: json['durationDays'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'price': price,
    'durationDays': durationDays,
    'description': description,
  };

}
