import 'package:app/features/auth/data/models/data.dart';
import 'package:app/features/auth/data/models/login_request.dart';
import 'package:app/features/auth/data/models/resend_code_request.dart';
import 'package:app/features/auth/data/models/reset_password_request.dart';
import 'package:app/features/auth/domain/use_cases/login.dart';
import 'package:app/features/auth/domain/use_cases/resend_code.dart';
import 'package:app/features/auth/domain/use_cases/reset_password.dart';
import 'package:app/features/auth/presentation/cubit/cubit/login_state.dart';
import 'package:app/features/discount/presentation/view_model/cubit/discount_view_model_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._loginUseCase, this._resetPassword, this._resendCodeUseCase)
      : super(LoginState());
  final LoginUseCase _loginUseCase;
  final ResetPasswordUseCase _resetPassword;
  final ResendCodeUseCase _resendCodeUseCase;
  Future<void> login(LoginRequest requestData) async {
    emit(state.copyWith(loginStatus: BaseLoadingState()));
    final result = await _loginUseCase(requestData);
    result.fold(
          (failure) {
        emit(state.copyWith(loginStatus: BaseErrorState(failure.message)));
      },
          (response) => emit(
          state.copyWith(loginStatus: BaseSuccessState<Data>(data: response))),
    );
  }

  resendCode(ResendCodeRequest requestResendCode) async {
    emit(state.copyWith(sendCodeState: BaseLoadingState()));
    final result = await _resendCodeUseCase(requestResendCode);
    result.fold(
            (failure) => emit(
            state.copyWith(sendCodeState: BaseErrorState(failure.message))),
            (response) => emit(state.copyWith(sendCodeState: BaseSuccessState())));
  }

  Future<void> resetPassword(ResetPasswordRequest requestData) async {
    emit(state.copyWith(resetStatus: BaseLoadingState()));

    final result = await _resetPassword(requestData);
    result.fold(
          (failure) =>
          emit(state.copyWith(resetStatus: BaseErrorState(failure.message))),
          (response) => emit(state.copyWith(resetStatus: BaseSuccessState())),
    );
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();
}