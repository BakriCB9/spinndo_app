import 'package:app/core/constant.dart';
import 'package:app/features/packages/data/data_source/remote/packages_remote_datasource.dart';
import 'package:app/features/packages/data/model/package_model.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PackagesRemoteDataSource)
class PackagesRemoteDatasourceImpl extends PackagesRemoteDataSource {
  final Dio _dio;
  PackagesRemoteDatasourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<List<PackageModel>> getAllPackages(String userToken) async {
    final ans = await _dio.get(ApiConstant.getAllPackages,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $userToken"
        }));

    final List<dynamic> data = ans.data['data'];
    return data.map((json) => PackageModel.fromJson(json)).toList();
  }
}