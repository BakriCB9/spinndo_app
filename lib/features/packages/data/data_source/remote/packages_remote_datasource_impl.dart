import 'package:app/core/constant.dart';
import 'package:app/features/packages/data/data_source/remote/packages_remote_datasource.dart';
import 'package:app/features/packages/data/model/package_model.dart';
import 'package:app/features/packages/data/model/subscription/subscribe_model.dart';
import 'package:app/features/packages/data/model/subscription/subscribe_response.dart';
import 'package:app/features/packages/data/model/subscription/unsubscribe_response.dart';
import 'package:app/main.dart';
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

  @override
  Future<SubscribeResponse?> subscribe(SubscribeModel subscribe, String userToken) async {
    print("Data sent to API: ${subscribe.toJson()}");

    final ans = await _dio.post(
      ApiConstant.addSubscribe,
      data: subscribe.toJson(),
      options: Options(headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $userToken",
      }),
    );
    print("Raw response: ${ans.data}");

    final parsed = SubscribeResponse.fromJson(ans.data);
    return parsed;
  }

  @override
  Future<UnSubscribeResponse?> unsubscribe(int userId, String userToken) async {
    try {
      final response = await _dio.post(
        '/subscriptions/unsubscribe/$userId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $userToken',
          },
        ),
      );

      return UnSubscribeResponse.fromJson(response.data);
    } catch (e) {
      print('Error during unsubscribe: $e');
      return null;
    }
  }

}
