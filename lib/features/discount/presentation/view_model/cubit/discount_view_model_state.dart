part of 'discount_view_model_cubit.dart';

sealed class BaseState {}

class BaseSuccessState<T> extends BaseState {
  T? data;
  BaseSuccessState({this.data});
}

class BaseLoadingState extends BaseState {}

class BaseErrorState extends BaseState {
  String? error;
  BaseErrorState(
    this.error,
  );
}

class DiscountViewModelState extends Equatable {
  const DiscountViewModelState(
      {this.addDiscountState, this.deleteDiscount, this.getAllDiscountState});
  final BaseState? addDiscountState;
  final BaseState? deleteDiscount;
  final BaseState? getAllDiscountState;
  DiscountViewModelState copyWith(
      {BaseState? addDiscountState,
      BaseState? deleteDiscountState,
      BaseState? getAllDisocuntState}) {
    return DiscountViewModelState(
        addDiscountState: addDiscountState ?? this.addDiscountState,
        deleteDiscount: deleteDiscountState ?? this.deleteDiscount,
        getAllDiscountState: getAllDisocuntState ?? this.getAllDiscountState);
  }

  @override
  List<Object?> get props =>
      [addDiscountState, getAllDiscountState, deleteDiscount];
}
