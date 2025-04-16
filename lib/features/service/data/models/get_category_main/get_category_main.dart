import 'package:app/features/service/domain/entities/main_category/all_category_main_entity.dart';

import 'item_of_main.dart';

class GetCategoryMain {
  String? status;
  String? message;
  List<ItemOfMain>? data;

  GetCategoryMain({this.status, this.message, this.data});

  factory GetCategoryMain.fromJson(Map<String, dynamic> json) {
    return GetCategoryMain(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ItemOfMain.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
  GetAllCategoryMainEntity toGetAllMainCategory() {
    return GetAllCategoryMainEntity(data!.map((e) {
      return e.toDataOfItemMainCategory();
    }).toList());
  }
}
