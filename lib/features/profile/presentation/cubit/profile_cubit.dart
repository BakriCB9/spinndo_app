import 'package:app/features/profile/data/models/client_update/update_client_request.dart';
import 'package:app/features/profile/domain/use_cases/update_client_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:app/features/profile/domain/use_cases/get_client_profile.dart';
import 'package:app/features/profile/domain/use_cases/get_provider_profile.dart';
import 'package:app/features/profile/domain/use_cases/get_user_role.dart';
import 'package:app/features/profile/presentation/cubit/profile_states.dart';

@lazySingleton
class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit(
      this._getClientProfile, this._getProviderProfile, this._getUserRole, this._updateClientProfile)
      : super(ProfileInitial());
  final GetClientProfile _getClientProfile;
  final GetProviderProfile _getProviderProfile;
  final GetUserRole _getUserRole;
  final UpdateClientProfile _updateClientProfile;

  //variable
  TextEditingController emailEditController = TextEditingController();
  TextEditingController firstNameEditController = TextEditingController();
  TextEditingController lastNameEditController = TextEditingController();
  TextEditingController serviceNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  //TextEditingController phoneEdit=TextEditingController();

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
  void updateClientProfile(UpdateClientRequest updateRequest) async {
    emit(UpdateLoading());
    final result = await _updateClientProfile(updateRequest);
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
}
