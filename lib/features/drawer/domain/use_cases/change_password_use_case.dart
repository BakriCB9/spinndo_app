import 'package:app/core/error/apiResult.dart';
import 'package:app/features/drawer/data/model/change_password_request.dart';
import 'package:app/features/drawer/domain/repository/drawer_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangePasswordUseCase {
 final DrawerRepository _drawerRepository;
  ChangePasswordUseCase(this._drawerRepository);
  Future<ApiResult<String>> call(ChangePasswordRequest request) =>
      _drawerRepository.changePassword(request);
}
