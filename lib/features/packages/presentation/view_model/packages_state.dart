import 'package:app/features/packages/data/model/package_model.dart';
abstract class PackagesState {}

class PackagesInitial extends PackagesState {}

class PackagesLoading extends PackagesState {}

class PackagesSuccess extends PackagesState {
  final List<PackageModel?> packages;

  PackagesSuccess(this.packages);
}

class PackagesError extends PackagesState {
  final String message;

  PackagesError(this.message);
}

class PackagesLoaded extends PackagesState {
  final List<PackageModel?> packages;

  PackagesLoaded(this.packages);
}
