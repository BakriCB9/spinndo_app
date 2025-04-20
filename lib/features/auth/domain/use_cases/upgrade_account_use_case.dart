import 'package:app/core/error/failure.dart';
import 'package:app/features/auth/data/models/upgeade_regiest_service_provider.dart';
import 'package:app/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpgradeAccountUseCase {
  final AuthRepository _authRepository;
  UpgradeAccountUseCase(this._authRepository);

  Future<Either<Failure, String>> call(
          UpgradeRegiestServiceProviderRequest upgrade) =>
      _authRepository.upgradeAccount(upgrade);
}
