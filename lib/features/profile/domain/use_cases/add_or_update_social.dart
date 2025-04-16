import 'package:app/core/error/failure.dart';
import 'package:app/features/profile/data/models/social_media_link/social_media_links_request.dart';
import 'package:app/features/profile/domain/entities/add_or_update_soical_entity/add_or_update_social_entity.dart';
import 'package:app/features/profile/domain/repository/profile_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddOrUpdateSocialUseCase {
  final ProfileRepository _profileRepository;

  AddOrUpdateSocialUseCase(this._profileRepository);

  Future<Either<Failure,AddOrUpdateSocialEntity>> call(SocialMediaLinksRequest  socialMediaLinksRequest) =>
      _profileRepository.addOrupdateLinkSocial(socialMediaLinksRequest);
}