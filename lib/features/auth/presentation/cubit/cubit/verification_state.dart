import 'package:app/features/discount/presentation/view_model/cubit/discount_view_model_cubit.dart';
import 'package:equatable/equatable.dart';

class VerificationState extends Equatable {
  BaseState? verifyState;
  BaseState? resendCodeState;
  VerificationState({this.verifyState, this.resendCodeState});
  VerificationState copyWith(
      {BaseState? verifyState, BaseState? resendCodeState}) {
    return VerificationState(
      verifyState: verifyState ?? this.verifyState,
      resendCodeState: resendCodeState ?? this.resendCodeState,
    );
  }

  @override
  List<Object?> get props => [
    verifyState,
    resendCodeState,
  ];
}