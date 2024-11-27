abstract class DrawerStates {}

class DrawerInitial extends DrawerStates {}

class DrawerThemeState extends DrawerStates {}
class LogOutLoading extends DrawerStates {}
class LogOutSuccess extends DrawerStates {}
class LogOutErrorr extends DrawerStates {
  final String message;

  LogOutErrorr(this.message);
}
