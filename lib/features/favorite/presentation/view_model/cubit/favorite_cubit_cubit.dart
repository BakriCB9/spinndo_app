import 'package:app/core/error/apiResult.dart';
import 'package:app/features/favorite/domain/usecase/add_to_fav_useCase.dart';
import 'package:app/features/favorite/domain/usecase/get_all_fav_useCase.dart';
import 'package:app/features/favorite/domain/usecase/remove_from_fav_useCase.dart';
import 'package:app/features/service/data/models/get_services_response/data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'favorite_cubit_state.dart';

@injectable
class FavoriteCubit extends Cubit<FavoriteCubitState> {
  FavoriteCubit(
      this.addFavUseCase, this.getAllFavUsecase, this.removeFromFavUsecase)
      : super(FavoriteCubitInitial());
  final AddFavUseCase addFavUseCase;
  final RemoveFromFavUsecase removeFromFavUsecase;
  final GetAllFavUsecase getAllFavUsecase;
  Future<void> addFav(String userId) async {
    ApiResult<String?> result = await addFavUseCase(userId);
    switch (result) {
      case ApiResultSuccess():
        {
          print('the result is ${result.data}');
        }
      case ApiresultError():
        {
          print('the fail result is ${result.message}');
        }
    }
  }

  Future<void> removeFromFav(String id) async {
    ApiResult<String?> result = await removeFromFavUsecase(id);
    switch (result) {
      case ApiResultSuccess():
        {}
      case ApiresultError():
        {}
    }
  }

  Future<void> getAllFav() async {
    emit(FavoriteCubitLoading());
    ApiResult<List<Data?>> result = await getAllFavUsecase();
    switch (result) {
      case ApiResultSuccess():
        {
          print('');
          print('the ans of value list is ${result.data}');
          print('');
          emit(FavoriteCubitSuccess(result.data));
        }
      case ApiresultError():
        {
          emit(FavoriteCubitError());
        }
    }
  }
}
