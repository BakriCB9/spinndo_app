import 'package:app/features/profile/domain/entities/add_or_update_soical_entity/add_or_update_social_entity.dart';
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
  final String message;
  UpdateError(this.message);
}

class UpdateSuccess extends ProfileStates {}

class CardState extends ProfileStates {}

class GetCategoryLoading extends ProfileStates {}

class GetCategoryError extends ProfileStates {
  String message;
  GetCategoryError(this.message);
}

class GetCategorySuccess extends ProfileStates {}

class SelectedCategoryState extends ProfileStates {}

class GetUpdatedLocationLoading extends ProfileStates {}

class GetUpdatedLocationSuccess extends ProfileStates {}

class GetUpdatedLocationErrorr extends ProfileStates {
  final String message;

  GetUpdatedLocationErrorr(this.message);
}

class GetLocationCountryLoading extends ProfileStates {}

class GetLocationCountrySuccess extends ProfileStates {
  // final Country country;
  // GetLocationCountrySuccess(this.country);
}

class GetLocationCountryErrorr extends ProfileStates {
  final String message;

  GetLocationCountryErrorr(this.message);
}

class SelectedLocationUpdatedState extends ProfileStates {}

class LoadImagePhotoLoading extends ProfileStates {}

class LoadImagePhotoError extends ProfileStates {
  final String message;
  LoadImagePhotoError(this.message);
}

class LoadImagePhotoSuccess extends ProfileStates {
  final String message;
  LoadImagePhotoSuccess(this.message);
}

class AddorUpdateSoicalLinksLoading extends ProfileStates {}

class AddorUpdateSoicalLinksError extends ProfileStates {
  String message;
  AddorUpdateSoicalLinksError(this.message); 
}

class AddorUpdateSoicalLinksSuccess extends ProfileStates {
  AddOrUpdateSocialEntity addOrUpdateSocialEntity;
  AddorUpdateSoicalLinksSuccess(this.addOrUpdateSocialEntity);
}

class DeleteSocialLinkLoading extends ProfileStates{

}
class DeleteSocialLinkError extends ProfileStates{
 String message;
 DeleteSocialLinkError(this.message);
}

class DeleteSocialLinkSuccess extends ProfileStates{
String message;
DeleteSocialLinkSuccess(this.message);
}
