import 'dart:io';

import 'package:app/core/error/failure.dart';
import 'package:app/features/profile/data/models/image_profile_photo/image_profile_response.dart';
import 'package:app/features/profile/domain/repository/profile_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AddImagePhoto {
  final ProfileRepository _profileRepository;

  AddImagePhoto(this._profileRepository);

  Future<Either<Failure,ImageProfileResponse >> call(File image) =>
      _profileRepository.addImageProfile(image);
}