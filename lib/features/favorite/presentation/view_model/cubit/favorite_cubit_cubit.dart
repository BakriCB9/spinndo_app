import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'favorite_cubit_state.dart';

class FavoriteCubitCubit extends Cubit<FavoriteCubitState> {
  FavoriteCubitCubit() : super(FavoriteCubitInitial());
}
