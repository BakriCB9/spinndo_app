import 'package:app/features/profile/data/models/provider_modle/data.dart';
import 'package:dartz/dartz.dart';
import 'package:app/core/error/failure.dart';
import 'package:app/features/service/data/models/get_services_request.dart';
import 'package:app/features/service/domain/entities/categories.dart';
import 'package:app/features/service/domain/entities/countries.dart';
import 'package:app/features/service/domain/entities/services.dart';

<<<<<<< HEAD

=======
import '../../../profile/data/models/provider_model/provider_profile.dart';
>>>>>>> 867d478a456712fd63cd4cde8d7d65678a96ae1d

abstract class ServiceRepository {
  Future<Either<Failure, List<Services>>> getServices(
      GetServicesRequest requestData);
  Future<Either<Failure, List<Countries>>> getCountries();
  Future<Either<Failure, List<Categories>>> getCategories();
  Future<Either<Failure, ProviderProfile>> showDetails(int id);
}
