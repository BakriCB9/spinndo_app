import 'package:app/features/service/domain/entities/main_category/data_of_item_main_category.dart';

class ItemOfMain {
  int? id;
  String? name;
  String? iconPath;

  ItemOfMain({this.id, this.name, this.iconPath});

  factory ItemOfMain.fromJson(Map<String, dynamic> json) => ItemOfMain(
        id: json['id'] as int?,
        name: json['name'] as String?,
        iconPath: json['icon_path'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'icon_path': iconPath,
      };

      DataOfItemMainCategoryEntity toDataOfItemMainCategory(){
         return DataOfItemMainCategoryEntity(iconPath: iconPath, id: id, name: name);
      }
}
