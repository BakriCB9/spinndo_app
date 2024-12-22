abstract class DrawerStates {}

class DrawerInitial extends DrawerStates {}

class DrawerThemeState extends DrawerStates {}

class LogOutLoading extends DrawerStates {}

class LogOutSuccess extends DrawerStates {}

class LogOutErrorr extends DrawerStates {
  final String message;

  LogOutErrorr(this.message);
}
class DeleteAccountLoading extends DrawerStates{}
class DeleteAccountError extends DrawerStates{
 final String message;
 DeleteAccountError(this.message);
}
class DeleteAccountSuccess extends DrawerStates{}
