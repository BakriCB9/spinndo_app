import 'package:dartz/dartz.dart';
import 'package:snipp/core/error/failure.dart';
import 'package:snipp/features/profile/data/models/provider_model/data.dart';

import 'package:snipp/features/profile/domain/entities/client.dart';

abstract class ProfileRepository {
Future<Either<Failure,Client>>  getClient();
Future<Either<Failure,Data>>    getServiceProvider();
}