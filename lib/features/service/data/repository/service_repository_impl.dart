import 'package:app/features/profile/data/models/provider_modle/data.dart';
import 'package:app/features/profile/domain/entities/provider_profile/provider_profile.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:app/core/error/failure.dart';

import 'package:app/features/service/data/data_sources/service_data_source.dart';
import 'package:app/features/service/data/models/get_services_request.dart';
import 'package:app/features/service/domain/entities/categories.dart';
import 'package:app/features/service/domain/entities/countries.dart';
import 'package:app/features/service/domain/entities/services.dart';

import '../../../../core/error/app_exception.dart';

import '../../domain/repository/service_repository.dart';

@LazySingleton(as: ServiceRepository)
class ServiceRepositoryImpl implements ServiceRepository {
  final ServiceDataSource _serviceDataSource;

  ServiceRepositoryImpl(this._serviceDataSource);

  @override
  Future<Either<Failure, List<Categories>>> getCategories() async {
    try {
      final getCategoriesResponse = await _serviceDataSource.getAllCategory();
      return Right(getCategoriesResponse.data!);
    } on AppException catch (exception) {
      return left(Failure(exception.message));
    }
  }

  @override
  Future<Either<Failure, List<Countries>>> getCountries() async {
    try {
      final getCountriesResponse = await _serviceDataSource.getAllCountries();
      return Right(getCountriesResponse.data!);
    } on AppException catch (exception) {
      return left(Failure(exception.message));
    }
  }

  @override
  Future<Either<Failure, List<Services>>> getServices(
      GetServicesRequest requestData) async {
    try {
      final getServicesResponse =
          await _serviceDataSource.getServices(requestData);
      return Right(getServicesResponse.data!);
    } on AppException catch (exception) {
      return left(Failure(exception.message));
    }
  }

  @override
  Future<Either<Failure, ProviderProfile>> showDetails(int id) async {
    try {
      final poviderService = await _serviceDataSource.getProviderService(id);
      return Right(poviderService.data!);
    } on AppException catch (exception) {
      return left(Failure(exception.message));
    }
  }
}
