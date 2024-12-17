import 'package:app/features/profile/domain/entities/client_profile.dart';
import 'package:app/features/profile/domain/entities/provider_profile/provider_profile.dart';

abstract class ProfileStates {}

class ProfileInitial extends ProfileStates {}

class GetProfileLoading extends ProfileStates {}

class GetProfileErrorr extends ProfileStates {
  final String message;

  GetProfileErrorr(this.message);
}

class GetClientSuccess extends ProfileStates {
  final ClientProfile client;

  GetClientSuccess(this.client);
}

class GetProviderSuccess extends ProfileStates {
  final ProviderProfile provider;

  GetProviderSuccess(this.provider);
}

class GetUserRoleSuccess extends ProfileStates {}

class GetUserRoleErrorr extends ProfileStates {
  final String message;

  GetUserRoleErrorr(this.message);
}

class IsUpdated extends ProfileStates {}

class IsNotUpdated extends ProfileStates {}
class UpdateLoading extends ProfileStates {}

class UpdateError extends ProfileStates {
  final  String message;
  UpdateError(this.message);
}


class UpdateSuccess extends ProfileStates {}

class CardState extends ProfileStates{}