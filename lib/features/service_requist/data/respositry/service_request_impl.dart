import 'dart:io';

import 'package:app/core/error/apiResult.dart';
import 'package:app/features/service_requist/data/dataSource/remote/service_request_remote_dataSouce_impl.dart';
import 'package:app/features/service_requist/data/dataSource/remote/service_requist_remote_dataSource.dart';
import 'package:app/features/service_requist/data/model/request_model/update_my_service_request.dart';
import 'package:app/features/service_requist/doamin/entity/get_service_entity.dart';
import 'package:app/features/service_requist/doamin/repositry/service_request_repo.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ServiceRequestRepo)
class ServiceRequestImpl extends ServiceRequestRepo {
  ServiceRequistRemoteDatasource serviceRequistRemoteDatasource;
  ServiceRequestImpl(this.serviceRequistRemoteDatasource);
  @override
  Future<ApiResult<List<ServiceRequestEntity>>> getServiceRequest(
      int? userId) async {
    try {
      if (userId == null) {
        final ans = await serviceRequistRemoteDatasource.getAllRequest();

        final list = ans.map((e) {
          return e.toServiceRequestEntity();
        }).toList();
        return ApiResultSuccess<List<ServiceRequestEntity>>(list);
      } else {
        final ans = await serviceRequistRemoteDatasource
            .getMyServiceRequestOnly(userId);
        final list = ans.map((e) {
          return e.toServiceRequestEntity();
        }).toList();
        return ApiResultSuccess<List<ServiceRequestEntity>>(list);
      }
    } catch (exception) {
      var message = 'Failed to get Services';
      if (exception is DioException) {
        final errorMessage = exception.response?.data['message'];

        if (errorMessage != null) message = errorMessage;
      }
      return ApiresultError<List<ServiceRequestEntity>>(message);
    }
  }

  @override
  Future<ApiResult<ServiceRequestEntity>> updateMyService(
      int idOfSerivce, MyServiceRequest myservice) async {
    try {
      final ans = await serviceRequistRemoteDatasource.updateMyRequest(
          idOfSerivce, myservice);
      final aux = ans.toServiceRequestEntity();
      print(
          'the all of data is now ${ans.description} and title is ${ans.title}');
      print(
          'the ans from repo is impl is ${aux.title} and ${aux.desCription} ******************************');
      return ApiResultSuccess<ServiceRequestEntity>(aux);
    } catch (exception) {
      var message = 'Failed to update Services';
      if (exception is DioException) {
        final errorMessage = exception.response?.data['message'];
        print('teh dio exception is ${errorMessage}');
        if (errorMessage != null) message = errorMessage;
      }

      return ApiresultError<ServiceRequestEntity>(message);
    }
  }

  @override
  Future<ApiResult<ServiceRequestEntity>> create(
      MyServiceRequest serviceRequestEntity) async {
    try {
      final ans =
          await serviceRequistRemoteDatasource.create(serviceRequestEntity);
      final aux = ans.toServiceRequestEntity();
      return ApiResultSuccess<ServiceRequestEntity>(aux);
    } catch (exception) {
      var message = 'Failed to add Services';
      if (exception is DioException) {
        final errorMessage = exception.response?.data['message'];

        if (errorMessage != null) message = errorMessage;
      }
      return ApiresultError<ServiceRequestEntity>(message);
    }
  }

  @override
  Future<ApiResult<String>> deleteService(int idOfService) async {
    try {
      final ans =
          await serviceRequistRemoteDatasource.deleteMyService(idOfService);
      return ApiResultSuccess<String>(ans);
    } catch (exception) {
      var message = 'Failed to delete Services';
      if (exception is DioException) {
        final errorMessage = exception.response?.data['message'];

        if (errorMessage != null) message = errorMessage;
      }
      return ApiresultError<String>(message);
    }
  }
}

ServerException? handleDioExceptions(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      return ServerException.fromJson(e.response?.data);
    case DioExceptionType.sendTimeout:
      return ServerException.fromJson(e.response?.data);
    case DioExceptionType.receiveTimeout:
      return ServerException.fromJson(e.response?.data);
    case DioExceptionType.badCertificate:
      return ServerException.fromJson(e.response?.data);
    case DioExceptionType.cancel:
      return ServerException.fromJson(e.response?.data);
    case DioExceptionType.connectionError:
      return ServerException.fromJson(e.response?.data);
    case DioExceptionType.unknown:
      return ServerException.fromJson(e.response?.data);
    case DioExceptionType.badResponse:
      switch (e.response?.statusCode) {
        case 400: // Bad request
          return ServerException.fromJson(e.response?.data);
        case 401: //unauthorized
          return ServerException.fromJson(e.response?.data);
        case 403: //forbidden
          return ServerException.fromJson(e.response?.data);
        case 404: //not found
          return ServerException.fromJson(e.response?.data);
        case 409: //cofficient
          return ServerException.fromJson(e.response?.data);
        case 422: //  Unprocessable Entity
          return ServerException.fromJson(e.response?.data);
        case 504: // Server exception
          return ServerException.fromJson(e.response?.data);
      }
  }
}

// class ApiInterceptor extends Interceptor {
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     options.headers['Content-Type'] = 'application/json';
//     super.onRequest(options, handler);
//   }
// }

// server exception
class ServerException implements Exception {
  final String? errorMessage;
  final int? statusCode;
  ServerException(this.errorMessage, {this.statusCode});
  factory ServerException.fromJson(Map<String, dynamic> json) {
    return ServerException(
      json['message'] as String?,
      statusCode: json['code'] as int?,
    );
  }
}
