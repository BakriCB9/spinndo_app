// import 'package:dartz/dartz.dart';
// import 'package:app/core/error/failure.dart';
// import 'package:app/features/auth/data/models/provider_profile.dart';
// import 'package:app/features/auth/data/models/login_request.dart';
// import 'package:app/features/auth/data/models/register_request.dart';
// import 'package:app/features/auth/data/models/register_response.dart';
// import 'package:app/features/auth/data/models/register_service_provider_request.dart';
// import 'package:app/features/auth/data/models/register_service_provider_response.dart';
// import 'package:app/features/auth/data/models/resend_code_request.dart';
// import 'package:app/features/auth/data/models/resend_code_response.dart';
// import 'package:app/features/auth/data/models/reset_password_request.dart';
// import 'package:app/features/auth/data/models/reset_password_response.dart';
// import 'package:app/features/auth/data/models/verify_code_request.dart';
// import 'package:app/features/auth/domain/entities/country.dart';
// import 'package:app/features/service/domain/entities/categories.dart';
//
// abstract class DrawerRepository {
//
//
//
//
//   Future<Either<Failure, Data>> login(LoginRequest requestData);
//
//
//
// }

import 'package:app/core/error/apiResult.dart';
import 'package:app/features/drawer/data/model/change_password_request.dart';

abstract  class DrawerRepository {
 Future<ApiResult<String>> changePassword(ChangePasswordRequest request);
}