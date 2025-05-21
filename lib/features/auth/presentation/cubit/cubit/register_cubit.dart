import 'dart:io';

import 'package:app/features/auth/data/models/register_request.dart';
import 'package:app/features/auth/data/models/register_service_provider_request.dart';
import 'package:app/features/auth/domain/use_cases/register.dart';
import 'package:app/features/auth/domain/use_cases/register_service.dart';
import 'package:app/features/auth/presentation/cubit/cubit/register_state.dart';
import 'package:app/features/discount/presentation/view_model/cubit/discount_view_model_cubit.dart';
import 'package:app/features/service/domain/entities/categories.dart';
import 'package:app/features/service/domain/use_cases/get_categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._registerServiceUseCase, this._registerUseCase,
      this._getCategoriesUseCase)
      : super(RegisterState());
  final RegisterUseCase _registerUseCase;
  final GetCategoriesUseCase _getCategoriesUseCase;
  final RegisterServiceUseCase _registerServiceUseCase;

  Future<void> register(RegisterRequest requestData) async {
    emit(state.copyWith(registerClientState: BaseLoadingState()));
    final result = await _registerUseCase(requestData);

    result.fold(
          (failure) => emit(
          state.copyWith(registerClientState: BaseErrorState(failure.message))),
          (response) =>
          emit(state.copyWith(registerClientState: BaseSuccessState())),
    );
  }

  Future<void> getCategories() async {
    emit(state.copyWith(getCategoryState: BaseLoadingState()));

    final result = await _getCategoriesUseCase();
    result.fold((failure) {
      emit(state.copyWith(getCategoryState: BaseErrorState(failure.message)));
    }, (categories) {
      emit(state.copyWith(
          getCategoryState:
          BaseSuccessState<List<Categories>>(data: categories)));
    });
  }

  Future<void> registerService(
      RegisterServiceProviderRequest requestData) async {
    emit(state.copyWith(registerProviderState: BaseLoadingState()));

    final result = await _registerServiceUseCase(requestData);

    result.fold(
          (failure) => emit(state.copyWith(
          registerProviderState: BaseErrorState(failure.message))),
          (response) =>
          emit(state.copyWith(registerProviderState: BaseSuccessState())),
    );
  }



  bool isAnotherDaySelected() {
    for (int i = 0; i < dateSelect.length; i++) {
      if (dateSelect[i].daySelect) {
        return true;
      }
    }
    return false;
  }

  final firstNameContoller = TextEditingController();
  final firstNameArcontroller = TextEditingController();
  final lastNameArCOntroller = TextEditingController();
  final phoneNumberController = TextEditingController();
  final lastNameContoller = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final codeController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final serviceNameController = TextEditingController();
  final addressController = TextEditingController();
  final websiteController = TextEditingController();
  final serviceDescriptionController = TextEditingController();
  String countryCode = '+93';
  bool isClient = true;
  Categories? selectedCategory;
  List<DateSelect> dateSelect = [
    DateSelect(day: "Sunday", start: "08:00", end: "15:00"),
    DateSelect(day: "Monday", start: "08:00", end: "15:00"),
    DateSelect(day: "Tuesday", start: "08:00", end: "15:00"),
    DateSelect(day: "Wednesday", start: "08:00", end: "15:00"),
    DateSelect(day: "Thursday", start: "08:00", end: "15:00"),
    DateSelect(day: "Friday", start: "08:00", end: "15:00"),
    DateSelect(day: "Saturday", start: "08:00", end: "15:00"),
  ];

  List<File?> listOfFileImagesProtofile = [File("")];
  File? certificateImage;
  String? countryName;
  String? address;
  double? lat;
  double? lang;
}