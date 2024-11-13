import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:snipp/features/profile/domain/use_cases/get_client_profile.dart';
import 'package:snipp/features/profile/presentation/cubit/profile_states.dart';
@lazySingleton
class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit(this._getClientProfile) : super(ProfileInitial());
  final GetClientProfile _getClientProfile;

  Future<void> getClient() async {
    emit(GetClientLoading());
    final result = await _getClientProfile();
    result.fold((failure) => emit(GetClientError(failure.message),),
        (client) => emit(GetClientSucces(client),),);
  }
}
