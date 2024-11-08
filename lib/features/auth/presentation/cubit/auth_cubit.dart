import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snipp/features/auth/data/data_sources/auth_api_data_source.dart';
import 'package:snipp/features/auth/data/models/login_request.dart';
import 'package:snipp/features/auth/data/models/register_request.dart';
import 'package:snipp/features/auth/data/models/verify_code_request.dart';
import 'package:snipp/features/auth/data/repository/auth_repository.dart';
import 'package:snipp/features/auth/presentation/cubit/auth_states.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final _authRepository = AuthRepository(AuthAPIDataSource());

  Future<void> register(RegisterRequest requestData) async {
    emit(RegisterLoading());
    try {
      await _authRepository.register(requestData);
      emit(RegisterSuccess());
    } catch (error) {
      emit(RegisterError(error.toString()));
    }
  }

  Future<void> login(LoginRequest requestData) async {
    emit(LoginLoading());
    try {
      await _authRepository.login(requestData);
      emit(LoginSuccess());
    } catch (error) {
      emit(LoginError(error.toString()));
    }
  }
  Future<void> verifyCode( VerifyCodeRequest requestData) async {
    emit(VerifyCodeLoading());
    try {
      await _authRepository.verifyCode(requestData);
      emit(VerifyCodeSuccess());
    } catch (error) {
      emit(VerifyCodeError(error.toString()));
    }
  }
}
