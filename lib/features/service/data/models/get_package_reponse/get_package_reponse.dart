// lib/features/package/data/model/get_packages_response.dart
import 'data.dart';

class GetPackagesResponse {

  String? status;
  String? message;
  List<PackagesData>? data;

  GetPackagesResponse({this.status, this.message,this.data});

  factory GetPackagesResponse.fromJson(Map<String, dynamic> json) {
    return GetPackagesResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => PackagesData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class GetPackagesResponse {
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


