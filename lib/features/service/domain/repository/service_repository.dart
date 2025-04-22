import 'package:app/features/packages/domain/usecase/get_all_packages_usecase.dart';
import 'package:app/features/profile/domain/entities/provider_profile/provider_profile.dart';
import 'package:app/features/service/domain/entities/main_category/all_category_main_entity.dart';
import 'package:app/features/service/domain/entities/notifications.dart';
import 'package:app/features/service/domain/entities/package.dart';
import 'package:dartz/dartz.dart';
import 'package:app/core/error/failure.dart';
import 'package:app/features/service/data/models/get_services_request.dart';
import 'package:app/features/service/domain/entities/categories.dart';
import 'package:app/features/service/domain/entities/countries.dart';
import 'package:app/features/service/domain/entities/services.dart';

abstract class ServiceRepository {
  Future<Either<Failure, List<Services>>> getServices(
      GetServicesRequest requestData);
  Future<Either<Failure, List<Countries>>> getCountries();
  Future<Either<Failure, List<Categories>>> getCategories();
  Future<Either<Failure, ProviderProfile>> showDetails(int id);
  Future<Either<Failure, List<Notifications>>> getAllNotification();
  Future<Either<Failure,GetAllCategoryMainEntity>>getAllMainCategory();
  Future<Either<Failure,List<Packages>>>getAllPackages();
}
