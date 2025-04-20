import 'package:app/core/constant.dart';
import 'package:app/features/favorite/data/dataSource/remote/remote_datasource.dart';
import 'package:app/features/favorite/data/model/add_fav_response.dart';
import 'package:app/features/packages/data/dataSource/remote/packages_remote_datasource.dart';
import 'package:app/features/service/data/models/get_services_response/get_services_response.dart';
import 'package:dio/dio.dart';

import 'package:injectable/injectable.dart';

import '../../../../service/data/models/get_package_reponse/get_package_reponse.dart';

@Injectable(as: PackagesRemoteDataSource)
class PackagesRemoteDataSourceImpl extends PackagesRemoteDataSource {
  final Dio _dio;
  PackagesRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<GetPackagesResponse> getAllPackages(String userToken) async {
    final ans = await _dio.get(ApiConstant.getAllPackages,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": userToken
        }));

    return GetPackagesResponse.fromJson(ans.data);

  }
}