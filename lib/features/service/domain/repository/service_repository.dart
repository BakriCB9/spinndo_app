import 'package:dartz/dartz.dart';
import 'package:app/core/error/failure.dart';
import 'package:app/features/service/data/models/get_services_request.dart';
import 'package:app/features/service/domain/entities/categories.dart';
import 'package:app/features/service/domain/entities/countries.dart';
import 'package:app/features/service/domain/entities/services.dart';

import '../../../profile/data/models/provider_model/provider_profile.dart';

abstract class ServiceRepository {
  Future<Either<Failure, List<Services>>> getServices(
      GetServicesRequest requestData);
  Future<Either<Failure, List<Countries>>> getCountries();
  Future<Either<Failure, List<Categories>>> getCategories();
  Future<Either<Failure, ProviderProfile>> showDetails(int id);
}
