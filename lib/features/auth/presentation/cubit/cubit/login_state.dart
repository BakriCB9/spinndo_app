import 'package:app/features/discount/presentation/view_model/cubit/discount_view_model_cubit.dart';
import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  BaseState? loginStatus;
  BaseState? resetStatus;
  BaseState? sendCodeState;
  LoginState({this.loginStatus, this.resetStatus, this.sendCodeState});

  LoginState copyWith(
      {BaseState? loginStatus,
        BaseState? resetStatus,
        BaseState? sendCodeState}) {
    return LoginState(
        loginStatus: loginStatus ?? this.loginStatus,
        resetStatus: resetStatus ?? this.resetStatus,
        sendCodeState: sendCodeState ?? this.sendCodeState);
  }

  @override
  List<Object?> get props => [
    loginStatus,
    resetStatus,
    sendCodeState,
  ];
}