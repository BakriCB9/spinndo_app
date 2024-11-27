import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:snipp/features/profile/domain/use_cases/get_client_profile.dart';
import 'package:snipp/features/profile/domain/use_cases/get_provider_profile.dart';
import 'package:snipp/features/profile/domain/use_cases/get_user_role.dart';
import 'package:snipp/features/profile/presentation/cubit/profile_states.dart';

@lazySingleton
class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit(
      this._getClientProfile, this._getProviderProfile, this._getUserRole)
      : super(ProfileInitial());
  final GetClientProfile _getClientProfile;
  final GetProviderProfile _getProviderProfile;
  final GetUserRole _getUserRole;
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
}
