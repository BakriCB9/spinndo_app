import 'package:dartz/dartz.dart';
import 'package:snipp/core/error/failure.dart';
import 'package:snipp/features/profile/domain/entities/provider_profile/provider_profile.dart';
import 'package:snipp/features/service/data/models/get_services_request.dart';
import 'package:snipp/features/service/domain/entities/categories.dart';
import 'package:snipp/features/service/domain/entities/countries.dart';
import 'package:snipp/features/service/domain/entities/services.dart';

import '../../../profile/data/models/provider_model/data.dart';

abstract class ServiceRepository {
  Future<Either<Failure, List<Services>>> getServices(
      GetServicesRequest requestData);
  Future<Either<Failure, List<Countries>>> getCountries();
  Future<Either<Failure, List<Categories>>> getCategories();
  Future<Either<Failure, Data>> showDetails(int id);
}
