import 'package:app/features/profile/data/models/client_update/update_account_profile.dart';
import 'package:app/features/profile/data/models/provider_update/update_provider_request.dart';
import 'package:app/features/profile/domain/use_cases/update_client_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:app/features/profile/domain/use_cases/get_client_profile.dart';
import 'package:app/features/profile/domain/use_cases/get_provider_profile.dart';
import 'package:app/features/profile/domain/use_cases/get_user_role.dart';
import 'package:app/features/profile/presentation/cubit/profile_states.dart';

import '../../domain/use_cases/update_provider_profile.dart';

@lazySingleton
class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit(
      this._getClientProfile, this._getProviderProfile, this._getUserRole, this._updateClientProfile, this._updateProviderProfile)
      : super(ProfileInitial());
  final GetClientProfile _getClientProfile;
  final GetProviderProfile _getProviderProfile;
  final GetUserRole _getUserRole;
  final UpdateClientProfile _updateClientProfile;
  final UpdateProviderProfile _updateProviderProfile;
  //variable
  TextEditingController emailEditController = TextEditingController();
  TextEditingController firstNameEditController = TextEditingController();
  TextEditingController lastNameEditController = TextEditingController();
  TextEditingController serviceNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  //TextEditingController phoneEdit=TextEditingController();
  List<DateSelect> dateSelect = [
    DateSelect(day: "Sunday", start: "08:00", end: "15:00"),
    DateSelect(day: "Monday", start: "08:00", end: "15:00"),
    DateSelect(day: "Tuesday", start: "08:00", end: "15:00"),
    DateSelect(day: "Wednesday", start: "08:00", end: "15:00"),
    DateSelect(day: "Thursday", start: "08:00", end: "15:00"),
    DateSelect(day: "Friday", start: "08:00", end: "15:00"),
    DateSelect(day: "Saturday", start: "08:00", end: "15:00"),
  ];
  DateSelect? dateSelected;
  Future<void> getClientProfile() async {
    emit(GetProfileLoading());
    final result = await _getClientProfile();
    result.fold(
      (failure) => emit(
        GetProfileErrorr(failure.message),
      ),
      (client) => emit(
        GetClientSuccess(client),
      ),
    );
  }

  Future<void> getProviderProfile() async {
    emit(GetProfileLoading());
    final result = await _getProviderProfile();
    result.fold(
      (failure) => emit(
        GetProfileErrorr(failure.message),
      ),
      (data) => emit(
        GetProviderSuccess(data),
      ),
    );
  }

  void getUserRole() {
    emit(GetProfileLoading());

    final result = _getUserRole();
    result.fold(
        (failure) => emit(
              GetUserRoleErrorr(failure.message),
            ), (role) {
      if (role == "ServiceProvider") {
        getProviderProfile();
      } else if (role == "Client") {
        getClientProfile();
      } else {
        emit(GetProfileErrorr(role));
      }
    });
  }
  void updateClientProfile(UpdateAccountProfile updateRequest) async {
    emit(UpdateLoading());
    final result = await _updateClientProfile(updateRequest);
    result.fold((failure) => emit(UpdateError(failure.message)),
            (updateRequest) {
          emit(UpdateSuccess());
        });
  }
  void updateProviderProfile(UpdateProviderRequest updateRequest)async{
    emit(UpdateLoading());
    final result = await _updateProviderProfile(updateRequest);
    result.fold((failure) => emit(UpdateError(failure.message)),
            (updateRequest) {
          emit(UpdateSuccess());
        });
  }
  updateInfo(
      {
      required String curFirst,
      required String newFirst,
      required String curLast,
      required String newLast}) {
    if (curFirst == newFirst && curLast == newLast) {
      emit(IsNotUpdated());
    } else {
      emit(IsUpdated());
    }
  }
  updateJobDetails(
      {
        required String curServiceName,
        required String newServiceName,
        required String curDescription,
        required String newDescription}) {
    if (curServiceName == newServiceName && curDescription == curDescription) {
      emit(IsNotUpdated());
    } else {
      emit(IsUpdated());
    }
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
      if (dateSelect[i].daySelect) {
        return true;
      }
    }
    return false;
  }

}
class DateSelect {
  String day;
  bool daySelect;
  String? start;
  String? end;
  bool arrowSelect;
  DateSelect(
      {required this.day,
        this.start,
        this.end,
        this.daySelect = false,
        this.arrowSelect = true});
  Map<String, String?> toJson() => {"day": day, "start": start, "end": end};
}
