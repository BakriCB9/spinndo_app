import 'package:app/features/service/domain/entities/main_category/data_of_item_main_category.dart';

class PackagesData {
  int? id;
  String? name;
  double? price;
  int? duration;
  bool? is_subscribed;


  PackagesData({this.id, this.name, this.price,this.duration,this.is_subscribed});

  factory PackagesData.fromJson(Map<String, dynamic> json) => PackagesData(
    id: json['id'] as int?,
    name: json['name'] as String?,
    price: json['price'] as double?,
    duration: json['duration'] as int?,
    is_subscribed: json['is_subscribed'] as bool?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'price': price,
    'duration': duration,
    'is_subscribed': is_subscribed,
  };

  DataOfItemMainCategoryEntity toDataOfItemMainCategory(){
    return DataOfItemMainCategoryEntity( id: id, name: name,price:price,duration:duration,is_subscribed:is_subscribed);
  }
}
