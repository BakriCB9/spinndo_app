// import 'package:dartz/dartz.dart';
// import 'package:injectable/injectable.dart';
// import 'package:snipp/core/error/failure.dart';
//
// import 'package:snipp/features/service/data/data_sources/service_data_source.dart';
//
// import '../../domain/repository/service_repository.dart';
//
// @Singleton(as: ServiceRepository)
// class ServiceRepositoryImpl implements ServiceRepository {
//   final ServiceDataSource _serviceDataSource;
//
//   ServiceRepositoryImpl(this._serviceDataSource);
//
//
//   @override
//   Future<Either<Failure, Data>> login(LoginRequest requestData) async {
//     try {
//       final response = await _authRemoteDataSource.login(requestData);
//       await _authLocalDataSource.saveToken(response.data!.token);
//       await _authLocalDataSource.saveUserId(response.data!.id);
//       await _authLocalDataSource.saveUserRole(response.data!.role);
//
//       return Right(response.data!);
//     } on AppException catch (exception) {
//       return Left(RemotFailure(exception.message));
//     }
//   }
//
//
// }
