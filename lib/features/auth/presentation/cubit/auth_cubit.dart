import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:snipp/features/auth/data/models/login_request.dart';
import 'package:snipp/features/auth/data/models/register_request.dart';
import 'package:snipp/features/auth/data/models/register_service_provider_request.dart';
import 'package:snipp/features/auth/data/models/resend_code_request.dart';
import 'package:snipp/features/auth/data/models/reset_password_request.dart';
import 'package:snipp/features/auth/data/models/verify_code_request.dart';
import 'package:snipp/features/auth/domain/use_cases/login.dart';
import 'package:snipp/features/auth/domain/use_cases/register.dart';
import 'package:snipp/features/auth/domain/use_cases/register_service.dart';
import 'package:snipp/features/auth/domain/use_cases/resend_code.dart';
import 'package:snipp/features/auth/domain/use_cases/reset_password.dart';
import 'package:snipp/features/auth/domain/use_cases/verify_code.dart';
import 'package:snipp/features/auth/presentation/cubit/auth_states.dart';

@singleton
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
      this._login, this._register, this._verifyCode, this._registerService, this._resendCode, this._resetPassword)
      : super(AuthInitial());
  final Login _login;
  final Register _register;
  final VerifyCode _verifyCode;
  final ResendCode _resendCode;
  final ResetPassword _resetPassword;
  final RegisterService _registerService;



  List<DateSelect> dateSelect = [
    DateSelect(day: "sunday",start: "08:00",end: "15:00"),
    DateSelect(day: "monday",start: "08:00",end: "15:00"),
    DateSelect(day: "tuseday",start: "08:00",end: "15:00"),
    DateSelect(day: "wednesday",start: "08:00",end: "15:00"),
    DateSelect(day: "thursday",start: "08:00",end: "15:00"),
    DateSelect(day: "friday",start: "08:00",end: "15:00"),
    DateSelect(day: "saturday",start: "08:00",end: "15:00"),
  ];
  String cityId = '1';
  String website = '';
  String categoryId = '1';
  final emailController = TextEditingController();
   double? lat;
   double? lang;
   String location="enter your location";
  final firstNameContoller = TextEditingController();

  final lastNameContoller = TextEditingController();

  final passwordController = TextEditingController();
  final codeController = TextEditingController();

  final confirmPasswordController = TextEditingController();
  final serviceNameController = TextEditingController();
  final addressController = TextEditingController();
  final serviceDescriptionController = TextEditingController();
  bool isClient = true;
  int resendCodeTime=60;
  bool canResend=false;
  File? pickedImage;
  List<File> profileImages = [];
  Future<void> register(RegisterRequest requestData) async {
    emit(RegisterLoading());
    final result = await _register(requestData);

    result.fold(
      (failure) => emit(RegisterError(failure.message)),
      (response) => emit(RegisterSuccess()),
    );
  }

  Future<void> login(LoginRequest requestData) async {
    emit(LoginLoading());

    final result = await _login(requestData);
    result.fold(
      (failure) => emit(LoginError(failure.message)),
      (response) => emit(LoginSuccess()),
    );
  }

  Future<void> verifyCode(VerifyCodeRequest requestData) async {
    emit(VerifyCodeLoading());

    final result = await _verifyCode(requestData);
    result.fold(
      (failure) => emit(VerifyCodeError(failure.message)),
      (response) => emit(VerifyCodeSuccess()),
    );
  }

  Future<void> registerService(
      RegisterServiceProviderRequest requestData) async {
    emit(RegisterServiceLoading());

    final result = await _registerService(requestData);

    result.fold(
      (failure) => emit(RegisterServiceError(failure.message)),
      (response) => emit(RegisterServiceSuccess()),
    );
  }
  Future<void> resendCode(ResendCodeRequest requestData) async {
    emit(ResendCodeLoading());

    final result = await _resendCode(requestData);
    result.fold(
          (failure) => emit(ResendCodeError(failure.message)),
          (response) {
            // verifyCodeTime();
            emit(ResendCodeSuccess());
          } ,
    );
  }
  Future<void> resetPassword(ResetPasswordRequest requestData) async {
    emit(ResetPasswordLoading());

    final result = await _resetPassword(requestData);
    result.fold(
          (failure) => emit(ResetPasswordError(failure.message)),
          (response) => emit(ResetPasswordSuccess()),
    );
  }

  onChooseAccountType(bool value) {
    isClient = value;
    emit(ChooseAccountState());
  }

  onDayUpdate(bool daySelect, DateSelect date) {
    date.daySelect = daySelect;
    emit(CardState());
  }
  onArrowUpdate(bool arrowSelect, DateSelect date) {
    date.arrowSelect = arrowSelect;
    emit(CardState());
  }
  onStartTimeUpdate(String start, DateSelect date) {
    date.start = start;
    emit(CardState());
  }
  onEndTimeUpdate(String end, DateSelect date) {
    date.end = end;
    emit(CardState());
  }
  bool isAnotherDaySelected() {
    for (int i = 0; i < dateSelect.length; i++) {
      if(dateSelect[i].daySelect){
        return true;
      }
    }
    return false;
  }
  verifyCodeTime(){
    canResend=false;
    emit(CanResendState());

    Timer.periodic( Duration(seconds: 1), (timer){
      if(resendCodeTime>0){
        resendCodeTime-=1;
        emit(CanResendState());
      }
      else{
        canResend=true;
        emit(CanResendState());
        resendCodeTime=60;
        timer.cancel();
      }
    });
  }
}
