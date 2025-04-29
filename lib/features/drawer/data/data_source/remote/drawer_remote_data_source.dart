// import 'package:app/features/drawer/data/model/log_out_response.dart';
//
// abstract class DrawerRemoteDataSource {
//   Future<LogOutResponse>logout();
//
// }

import 'package:app/features/drawer/data/model/change_password_request.dart';

abstract class DrawerRemoteDataSource {
  Future<String> changePassword(ChangePasswordRequest request);
}