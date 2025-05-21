import 'package:app/features/auth/data/models/resend_code_request.dart';
import 'package:app/features/auth/data/models/verify_code_request.dart';
import 'package:app/features/auth/domain/use_cases/resend_code.dart';
import 'package:app/features/auth/domain/use_cases/verify_code.dart';
import 'package:app/features/auth/presentation/cubit/cubit/verification_state.dart';
import 'package:app/features/discount/presentation/view_model/cubit/discount_view_model_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class VerificationCubit extends Cubit<VerificationState> {
  VerificationCubit(this._verifyCodeUseCase, this._resendCodeUseCase)
      : super(VerificationState());
  final VerifyCodeUseCase _verifyCodeUseCase;
  final ResendCodeUseCase _resendCodeUseCase;

  verifyCode(VerifyCodeRequest requestData) async {
    emit(state.copyWith(verifyState: BaseLoadingState()));

    final result = await _verifyCodeUseCase(requestData);
    result.fold(
          (failure) =>
          emit(state.copyWith(verifyState: BaseErrorState(failure.message))),
          (response) => emit(state.copyWith(verifyState: BaseSuccessState())),
    );
  }

  Future<void> resendCode(ResendCodeRequest requestData) async {
    emit(state.copyWith(resendCodeState: BaseLoadingState()));

    final result = await _resendCodeUseCase(requestData);
    result.fold(
          (failure) => emit(
          state.copyWith(resendCodeState: BaseErrorState(failure.message))),
          (response) {
        // verifyCodeTime();
        emit(state.copyWith(resendCodeState: BaseSuccessState()));
      },
    );
  }

  final TextEditingController codeController = TextEditingController();
}