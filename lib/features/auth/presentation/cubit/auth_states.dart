import 'dart:io';

import 'package:app/features/auth/domain/entities/country.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}


class RegisterSuccess extends AuthState {}

class RegisterLoading extends AuthState {}

class RegisterError extends AuthState {
  final String message;

  RegisterError(this.message);
}

class RegisterServiceSuccess extends AuthState {}

class RegisterServiceLoading extends AuthState {}

class RegisterServiceError extends AuthState {
  final String message;

  RegisterServiceError(this.message);
}

class VerifyCodeSuccess extends AuthState {}

class VerifyCodeLoading extends AuthState {}

class VerifyCodeError extends AuthState {
  final String message;

  VerifyCodeError(this.message);
}

class ResendCodeSuccess extends AuthState {}

class ResendCodeLoading extends AuthState {}

class ResendCodeError extends AuthState {
  final String message;

  ResendCodeError(this.message);
}
class CardState extends AuthState {}

class CanResendState extends AuthState {}

class GetCategoryLoading extends AuthState {}

class GetCategorySuccess extends AuthState {}

class GetCategoryError extends AuthState {
  final String message;

  GetCategoryError(this.message);
}

// class SelectedCategoryState extends AuthState {}

class SelectedSubCategoryState extends AuthState {}

class SelectedLocationState extends AuthState {}

class GetCurrentLocationLoading extends AuthState {}

class GetCurrentLocationSuccess extends AuthState {}
  
class GetCurrentLocationErrorr extends AuthState {
   String? message;

  GetCurrentLocationErrorr({this.message});
}

class GetLocationCountryLoading extends AuthState {}

class GetLocationCountrySuccess extends AuthState {
  // final Country country;
  // GetLocationCountrySuccess(this.country);
}

class GetLocationCountryErrorr extends AuthState {
  final String message;

  GetLocationCountryErrorr(this.message);
}

class ChooseCertificateImageState extends AuthState {}

class CertificateImageUpdated extends AuthState {
  final File? certificateImage;
  CertificateImageUpdated(this.certificateImage);
}

class UpdateImageProtofile extends AuthState {
  // final File? firstImage;
  // (this.firstImage);
}

class SecondImageUpdated extends AuthState {
  final File? secondImage;
  SecondImageUpdated(this.secondImage);
}

class MapStyleError extends AuthState {
  final String message;

  MapStyleError(this.message);
}

class MapStyleLoading extends AuthState {}
