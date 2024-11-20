
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:snipp/features/auth/domain/use_cases/login.dart';

import 'package:snipp/features/service/presentation/cubit/service_states.dart';

@singleton
class ServiceCubit extends Cubit<ServiceStates> {
  ServiceCubit(
      this._login)
      : super(ServiceInitial());
  final Login _login;






  //
  // Future<void> login(LoginRequest requestData) async {
  //   emit(LoginLoading());
  //
  //   final result = await _login(requestData);
  //   result.fold(
  //     (failure) => emit(LoginError(failure.message)),
  //     (response) => emit(LoginSuccess()),
  //   );
  // }

  }

