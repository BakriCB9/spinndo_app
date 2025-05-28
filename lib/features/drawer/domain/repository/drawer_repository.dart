import 'package:app/core/error/apiResult.dart';
import 'package:app/features/drawer/data/model/change_email/change_email_request.dart';
import 'package:app/features/drawer/data/model/change_password_request.dart';

abstract  class DrawerRepository {
 Future<ApiResult<String>> changePassword(ChangePasswordRequest request);
 Future<ApiResult<String>>changeEmail(ChangeEmailRequest changeEmailRequest);
}