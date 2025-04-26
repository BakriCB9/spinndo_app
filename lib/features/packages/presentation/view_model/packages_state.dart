import 'package:app/features/packages/data/model/package_model.dart';
import 'package:app/features/packages/data/model/subscription/subscribe_response.dart';

abstract class PackagesState {}

class PackagesInitial extends PackagesState {}

class PackagesLoading extends PackagesState {}

class PackagesSuccess extends PackagesState {
  final List<PackageModel?> packages;

  PackagesSuccess(this.packages);
}

class PackagesError extends PackagesState {
  final String message;
  final Object? error;

  PackagesError(this.message, [this.error]);
}

class SubscriptionSuccess extends PackagesState {
  final SubscribeResponse response;

  SubscriptionSuccess(this.response);
}

class SubscriptionError extends PackagesState {
  final String message;
  final Object? error;

  SubscriptionError(this.message, [this.error]);
}
