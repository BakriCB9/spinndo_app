import 'package:app/features/profile/domain/entities/provider_profile/provider_profile.dart';
import 'package:app/features/service/domain/entities/notifications.dart';
import 'package:app/features/service/domain/entities/services.dart';

abstract class ServiceStates {}

class ServiceInitial extends ServiceStates {}

class ServiceLoading extends ServiceStates {}

class ServiceSuccess extends ServiceStates {
  final List<Services> services;

  ServiceSuccess(this.services);
}

class ServiceError extends ServiceStates {
  final String message;

  ServiceError(this.message);
}

class ShowDetailsLoading extends ServiceStates {}

class ShowDetailsError extends ServiceStates {
  String message;
  ShowDetailsError(this.message);
}

class ShowDetailsSuccess extends ServiceStates {
  ProviderProfile providerProfile;
  ShowDetailsSuccess(this.providerProfile);
}

class CountryCategoryLoading extends ServiceStates {}

class CountryCategorySuccess extends ServiceStates {}

class CountryCategoryError extends ServiceStates {
  final String message;

  CountryCategoryError(this.message);
}

class GetNotificationLoading extends ServiceStates {}

class GetNotificationError extends ServiceStates {
  String message;
  GetNotificationError(this.message);
}

class GetNotificationSuccess extends ServiceStates {}

class SelectedCategoryServiceState extends ServiceStates {}

class SelectedCountryCityServiceState extends ServiceStates {}

class SelectedCityServiceState extends ServiceStates {}

class GetCurrentLocationFilterLoading extends ServiceStates {}

class GetCurrentLocationFilterSuccess extends ServiceStates {}

class GetCurrentLocationFilterErrorr extends ServiceStates {
  final String message;

  GetCurrentLocationFilterErrorr(this.message);
}

class DistanceSelectUpdate extends ServiceStates {}

class IsCurrentLocation extends ServiceStates {}

class ResetSettingsState extends ServiceStates {}

class GetDiscountLoadingState extends ServiceStates {}

class GetDiscountSuccessState<T> extends ServiceStates {
  T data;
  GetDiscountSuccessState(this.data);
}

class GetDiscountFailState extends ServiceStates {}

class GetMainCategorySuccess extends ServiceStates{

}
class GetMainCategoryError extends ServiceStates{
  String message;
  GetMainCategoryError(this.message);
}
class GetMainCategoryLoading extends ServiceStates{}
