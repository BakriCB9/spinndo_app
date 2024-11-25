import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:snipp/features/auth/data/models/register_request.dart';
import 'package:snipp/features/auth/data/models/register_response.dart';
import 'package:snipp/features/auth/domain/repository/auth_repository.dart';

import '../../../../core/error/failure.dart';

@singleton
class GetCategoriesAndCountries {
  final AuthRepository _authRepository;

  GetCategoriesAndCountries(this._authRepository);

  Future<Either<Failure, RegisterResponse>> call(RegisterRequest requestData) =>
      _authRepository.register(requestData);
}
