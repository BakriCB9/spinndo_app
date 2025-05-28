import 'package:app/core/error/apiResult.dart';
import 'package:app/core/error/app_exception.dart';
import 'package:app/core/network/remote/handle_dio_exception.dart';
import 'package:app/features/drawer/data/data_source/remote/drawer_remote_data_source.dart';
import 'package:app/features/drawer/data/model/change_email/change_email_request.dart';
import 'package:app/features/drawer/data/model/change_password_request.dart';
import 'package:app/features/drawer/domain/repository/drawer_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: DrawerRepository)
class DrawerRepositoryImpl implements DrawerRepository {
  final DrawerRemoteDataSource _drawerRemoteDataSource;
  
  DrawerRepositoryImpl(this._drawerRemoteDataSource);
  @override
  Future<ApiResult<String>> changePassword(
      ChangePasswordRequest request) async {
    try {
      final ans = await _drawerRemoteDataSource.changePassword(request);
      return ApiResultSuccess(ans);
    } on AppException catch (e) {
      return ApiresultError(e.message);
    }
  }

  @override
  Future<ApiResult<String>> changeEmail(
      ChangeEmailRequest changeEmailRequest) async {
    try {
      final ans = await _drawerRemoteDataSource.changeEmail(changeEmailRequest);

      return ApiResultSuccess<String>(ans.message!);
    } catch (e) {
      final exception = HandleException.exceptionType(e);
      return ApiresultError(exception);
    }
  }
}
