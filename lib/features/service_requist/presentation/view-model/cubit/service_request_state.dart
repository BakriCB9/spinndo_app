import 'package:equatable/equatable.dart';

sealed class BaseState {}

class BaseSuccessState<T> extends BaseState {
  T? data;
  BaseSuccessState(this.data);
}

class BaseLoadingState extends BaseState {}

class BaseErrorState extends BaseState {
  String? error;
  BaseErrorState(
    this.error,
  );
}





// ignore: must_be_immutable
class ServiceRequestState extends Equatable {
  BaseState? getServiceState;
  BaseState? updateServiceState;
  BaseState? deleteServiceState;
  BaseState? createServiceState;
  ServiceRequestState(
      {this.deleteServiceState,
      this.getServiceState,
      this.updateServiceState,
      this.createServiceState});
  ServiceRequestState copyWith({
    BaseState? getServiceState,
    BaseState? updateServiceState,
    BaseState? deleteServiceState,
    BaseState? createServiceState,
  }) {
    return ServiceRequestState(
        createServiceState: createServiceState ?? this.createServiceState,
        deleteServiceState: deleteServiceState ?? this.deleteServiceState,
        getServiceState: getServiceState ?? this.getServiceState,
        updateServiceState: updateServiceState ?? this.updateServiceState);
  }

  @override
  List<Object?> get props => [
        getServiceState,
        updateServiceState,
        deleteServiceState,
        createServiceState
      ];
}
