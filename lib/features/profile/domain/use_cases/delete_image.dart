import 'package:app/core/error/failure.dart';
import 'package:app/features/profile/data/models/delete_image/delete_image.dart';

import 'package:app/features/profile/domain/repository/profile_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DeleteImage {
  final ProfileRepository _profileRepository;
  
  DeleteImage(this._profileRepository);

  Future<Either<Failure, DeleteImageResponse>> call() =>
      _profileRepository.deleteImage();
}
