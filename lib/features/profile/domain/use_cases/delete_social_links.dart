import 'package:app/core/error/failure.dart';
import 'package:app/features/profile/domain/repository/profile_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteSocialLinksUseCase {
  final ProfileRepository _profileRepository;
  DeleteSocialLinksUseCase(this._profileRepository);
  Future<Either<Failure, String>> call(int idOfSocial) =>
      _profileRepository.deleteSocialLinks(idOfSocial);
}
