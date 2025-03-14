part of 'favorite_cubit_cubit.dart';

sealed class FavoriteCubitState {}

class FavoriteCubitInitial extends FavoriteCubitState {}

class FavoriteCubitLoading extends FavoriteCubitState {}

class FavoriteCubitError extends FavoriteCubitState {}

class FavoriteCubitSuccess extends FavoriteCubitState {
  final List<Data?> listOfFavorite;
  FavoriteCubitSuccess(this.listOfFavorite);
}
