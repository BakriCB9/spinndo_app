// import 'package:dartz/dartz.dart';
// import 'package:injectable/injectable.dart';
// import 'package:app/core/constant.dart';
// import 'package:app/core/error/app_exception.dart';
// import 'package:app/core/error/failure.dart';
// import 'package:app/features/auth/data/data_sources/local/auth_local_data_source.dart';
// import 'package:app/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
// import 'package:app/features/auth/data/models/data.dart';
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
// import 'package:app/features/auth/domain/repository/auth_repository.dart';
// import 'package:app/features/service/domain/entities/categories.dart';
//
// @Singleton(as: DrawerRepository)
// class DrawerRepositoryImpl implements DrawerRepository {
//   final AuthRemoteDataSource _drawerRemoteDataSource;
//   final AuthLocalDataSource _drawerLocalDataSource;
//
//   DrawerRepositoryImpl(this._drawerRemoteDataSource,this._drawerLocalDataSource);
//
//   @override
//   Future<Either<Failure, Data>> logout() async {
//     try {
//       final response = await _authRemoteDataSource.login(requestData);
//       await _authLocalDataSource.saveToken(response.data!.token);
//       await _authLocalDataSource.saveUserId(response.data!.id);
//       await _authLocalDataSource.saveUserRole(response.data!.role);
//       _authLocalDataSource.saveUserEmail(requestData.email);
//
//       await _authLocalDataSource.saveUserUnCompliteAccount(
//         requestData.email,
//       );
//       return Right(response.data!);
//     } on AppException catch (exception) {
//       return Left(Failure(exception.message));
//     }
//   }
//
// }
