import 'package:app/core/error/apiResult.dart';
import 'package:app/features/drawer/data/model/change_email/change_email_request.dart';
import 'package:app/features/drawer/domain/repository/drawer_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangeEmailUseCase {
 final  DrawerRepository _drawerRepository;
  ChangeEmailUseCase(this._drawerRepository);
  Future<ApiResult<String>>call(ChangeEmailRequest changeEmail)=>_drawerRepository.changeEmail(changeEmail);
}