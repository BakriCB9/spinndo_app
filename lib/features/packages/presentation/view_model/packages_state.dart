import '../../../auth/data/models/category_response/datum.dart';
import '../../../service/data/models/get_package_reponse/get_package_reponse.dart';
import '../../domain/package_intity.dart';

// abstract class PackagesState {}
//
// class PackagesInitial extends PackagesState {}
//
// class PackagesLoading extends PackagesState {}
//
// class PackagesError extends PackagesState {
//   String message = "";
//   PackagesError(this.message);
// }
//
// class PackagesSuccess extends PackagesState {
//   final List<PackageData> listOffPackages;
//   PackagesSuccess(this.listOffPackages);
// }

abstract class PackagesState {}

class PackagesInitial extends PackagesState {}

class PackagesLoading extends PackagesState {}

class PackagesSuccess extends PackagesState {
  final List<PackageData> packages;

  PackagesSuccess(this.packages);
}

class PackagesError extends PackagesState {
  final String message;

  PackagesError(this.message);
}
