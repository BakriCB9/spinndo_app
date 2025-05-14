import 'package:app/features/discount/presentation/view_model/cubit/discount_view_model_cubit.dart';
import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  BaseState? registerClientState;
  BaseState? registerProviderState;
  BaseState? getCategoryState;

  RegisterState(
      {this.getCategoryState,
      this.registerClientState,
      this.registerProviderState});
  RegisterState copyWith(
      {BaseState? registerClientState,
      BaseState? registerProviderState,
      BaseState? getCategoryState}) {
    return RegisterState(
        registerClientState: registerClientState ?? this.registerClientState,
        registerProviderState:
            registerProviderState ?? this.registerProviderState,
        getCategoryState: getCategoryState ?? this.getCategoryState);
  }

  @override
  List<Object?> get props => [
        registerClientState,
        registerProviderState,
        getCategoryState,
      ];
}

final class RegisterInitial extends RegisterState {}
