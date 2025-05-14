import 'package:app/core/network/remote/handle_dio_exception.dart';
import 'package:app/features/profile/domain/entities/provider_profile/provider_profile.dart';
import 'package:app/features/service/domain/entities/main_category/all_category_main_entity.dart';
import 'package:app/features/service/domain/entities/notifications.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:app/core/error/failure.dart';

import 'package:app/features/service/data/data_sources/service_data_source.dart';
import 'package:app/features/service/data/models/get_services_request.dart';
import 'package:app/features/service/domain/entities/categories.dart';
import 'package:app/features/service/domain/entities/countries.dart';
import 'package:app/features/service/domain/entities/services.dart';

import '../../domain/repository/service_repository.dart';

@Injectable(as: ServiceRepository)
class ServiceRepositoryImpl implements ServiceRepository {
  final ServiceDataSource _serviceDataSource;

  ServiceRepositoryImpl(this._serviceDataSource);

  @override
  Future<Either<Failure, List<Categories>>> getCategories() async {
    try {
      final getCategoriesResponse = await _serviceDataSource.getAllCategory();
      return Right(getCategoriesResponse.data!);
    } catch (e) {
      final exception = HandleException.exceptionType(e);
      return left(Failure(exception));
    }
  }

  @override
  Future<Either<Failure, List<Countries>>> getCountries() async {
    try {
      final getCountriesResponse = await _serviceDataSource.getAllCountries();
      return Right(getCountriesResponse.data!);
    } catch (e) {
      final exception = HandleException.exceptionType(e);
      return left(Failure(exception));
    }
  }

  @override
  Future<Either<Failure, List<Services>>> getServices(
      GetServicesRequest requestData) async {
    try {
      final getServicesResponse =
          await _serviceDataSource.getServices(requestData);
      return Right(getServicesResponse.data!);
    } catch (e) {
      final exception = HandleException.exceptionType(e);
      return left(Failure(exception));
    }
  }

  @override
  Future<Either<Failure, ProviderProfile>> showDetails(int id) async {
    try {
      final poviderService = await _serviceDataSource.getProviderService(id);
      return Right(poviderService.data!);
    } catch (e) {
      final exception = HandleException.exceptionType(e);
      return left(Failure(exception));
    }
  }

  @override
  Future<Either<Failure, List<Notifications>>> getAllNotification() async {
    try {
      final response = await _serviceDataSource.getAllNotification();
      return Right(response.data!);
    } catch (e) {
      final exception = HandleException.exceptionType(e);
      return left(Failure(exception));
    }
  }

  @override
  Future<Either<Failure, GetAllCategoryMainEntity>> getAllMainCategory() async {
    try {
      final response = await _serviceDataSource.getAllMainCategory();
      final ans = response.toGetAllMainCategory();
      return Right(ans);
    } catch (e) {
      final exception = HandleException.exceptionType(e);
      return left(Failure(exception));
    }
  }
}
