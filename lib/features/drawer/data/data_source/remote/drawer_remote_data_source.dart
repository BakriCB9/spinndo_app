// import 'package:app/features/drawer/data/model/log_out_response.dart';
//
// abstract class DrawerRemoteDataSource {
//   Future<LogOutResponse>logout();
//
// }

import 'package:app/features/drawer/data/model/change_email/change_email_request.dart';
import 'package:app/features/drawer/data/model/change_email/change_email_response.dart';
import 'package:app/features/drawer/data/model/change_password_request.dart';

abstract class DrawerRemoteDataSource {
  Future<String> changePassword(ChangePasswordRequest request);
  Future<ChangeEmailResponse> changeEmail(ChangeEmailRequest changeEmailRequest);
}