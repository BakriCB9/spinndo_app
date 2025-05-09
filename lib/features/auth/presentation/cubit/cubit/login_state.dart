import 'package:app/features/discount/presentation/view_model/cubit/discount_view_model_cubit.dart';
import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  BaseState? loginStatus;
  BaseState? resetStatus;
  LoginState({
    this.loginStatus,
    this.resetStatus,
  });

  LoginState copyWith({
    BaseState? loginStatus,
    BaseState? resetStatus,
  }) {
    return LoginState(
      loginStatus: loginStatus ?? this.loginStatus,
      resetStatus: resetStatus ?? this.resetStatus,
    );
  }

  @override
  List<Object?> get props => [loginStatus, resetStatus];
}
