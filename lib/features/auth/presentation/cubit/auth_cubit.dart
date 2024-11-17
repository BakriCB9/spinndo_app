import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:snipp/features/auth/data/models/login_request.dart';
import 'package:snipp/features/auth/data/models/register_request.dart';
import 'package:snipp/features/auth/data/models/register_service_provider_request.dart';
import 'package:snipp/features/auth/data/models/verify_code_request.dart';
import 'package:snipp/features/auth/domain/use_cases/login.dart';
import 'package:snipp/features/auth/domain/use_cases/register.dart';
import 'package:snipp/features/auth/domain/use_cases/register_service.dart';
import 'package:snipp/features/auth/domain/use_cases/verify_code.dart';
import 'package:snipp/features/auth/presentation/cubit/auth_states.dart';

@singleton
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
      this._login, this._register, this._verifyCode, this._registerService)
      : super(AuthInitial());
  final Login _login;
  final Register _register;
  final VerifyCode _verifyCode;
  final RegisterService _registerService;
  List<DateSelect> dateSelect = [
    DateSelect(day: "sunday"),
    DateSelect(day: "monday"),
    DateSelect(day: "tuseday"),
    DateSelect(day: "wednesday"),
    DateSelect(day: "thursday"),
    DateSelect(day: "friday"),
    DateSelect(day: "saturday"),
  ];
  String cityId = '1';
  String website = '';
  String categoryId = '1';
  final emailController = TextEditingController();

  final firstNameContoller = TextEditingController();

  final lastNameContoller = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();
  final serviceNameController = TextEditingController();
  final addressController = TextEditingController();
  final serviceDescriptionController = TextEditingController();
  bool isClient = true;
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

  onChooseAccountType(bool value) {
    isClient = value;
    emit(ChooseAccountState());
  }

  onSelectDay(bool val, DateSelect date) {
    date.isSelect = val;
    emit(SelectDayState());
  }
}
