import 'package:app/features/service/data/models/get_package_reponse/data.dart';
abstract class PackagesState {}

class PackagesInitial extends PackagesState {}

class PackagesLoading extends PackagesState {}

class PackagesSuccess extends PackagesState {
  final List<PackagesData?> packages;

  PackagesSuccess(this.packages);
}

class PackagesError extends PackagesState {
  final String message;

  PackagesError(this.message);
}

class PackagesLoaded extends PackagesState {
  final List<PackagesData?> packages;

  PackagesLoaded(this.packages);
}
