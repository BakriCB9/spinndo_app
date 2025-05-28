import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';

abstract class DrawerStates {}

class DrawerInitial extends DrawerStates {}

class DrawerThemeState extends DrawerStates {}

class LogOutLoading extends DrawerStates {}

class LogOutSuccess extends DrawerStates {}

class LogOutErrorr extends DrawerStates {
  final String message;

  LogOutErrorr(this.message);
}

class DeleteAccountLoading extends DrawerStates {}

class DeleteAccountError extends DrawerStates {
  final String message;
  DeleteAccountError(this.message);
}

class DeleteAccountSuccess extends DrawerStates {}

class ChangePasswordLoadingState extends DrawerStates {}

class ChangePasswordSuccessState extends DrawerStates {
  String data;
  ChangePasswordSuccessState(this.data);
}

class ChangePasswordErrorState extends DrawerStates {
  String message;
  ChangePasswordErrorState(this.message);
}

class ChangeEmailLoadingState extends DrawerStates {}

class ChangeEmailSuccessState extends DrawerStates {
  String data;
  ChangeEmailSuccessState(this.data);
}

class ChangeEmailErrorState extends DrawerStates {
  String message;
  ChangeEmailErrorState(this.message);
}
