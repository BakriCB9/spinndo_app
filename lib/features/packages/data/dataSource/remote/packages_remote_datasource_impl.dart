import 'package:app/features/packages/data/dataSource/remote/packages_remote_datasource.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'dart:convert';
import '../../../../../core/constant.dart';
import '../../../../service/data/models/get_package_reponse/get_package_reponse.dart';
import '../../../../service/data/models/get_services_response/get_services_response.dart';

@Injectable(as: PackagesRemoteDataSource)
class PackagesRemoteDatasourceImpl extends PackagesRemoteDataSource {
  final Dio _dio;
  PackagesRemoteDatasourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<GetPackagesResponse> getAllPackages(String userToken) async {
    final ans = await _dio.get(ApiConstant.getAllPackages,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $userToken"
        }));

    return GetPackagesResponse.fromJson(ans.data);
  }
}