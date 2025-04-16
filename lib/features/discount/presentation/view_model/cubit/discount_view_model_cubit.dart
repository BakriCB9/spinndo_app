import 'package:app/core/error/apiResult.dart';
import 'package:app/features/discount/data/model/discount_request/add_discount_request.dart';
import 'package:app/features/discount/domain/useCase/add_discount.dart';
import 'package:app/features/discount/domain/useCase/delete_discount.dart';
import 'package:app/features/discount/domain/useCase/get_discount.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'discount_view_model_state.dart';

@injectable
class DiscountViewModelCubit extends Cubit<DiscountViewModelState> {
  DiscountViewModelCubit(this._addDiscountUseCase, this._deleteDiscountUseCase,
      this._getAllDiscountUseCase)
      : super(const DiscountViewModelState());
  AddDiscountUseCase _addDiscountUseCase;
  GetAllDiscountUseCase _getAllDiscountUseCase;
  DeleteDiscountUseCase _deleteDiscountUseCase;

  addDiscount(AddDiscountRequest addDiscount) async {
    emit(state.copyWith(addDiscountState: BaseLoadingState()));
    final ans = await _addDiscountUseCase(addDiscount);
    switch (ans) {
      case ApiResultSuccess<String>():
        {
          print('yes it successs now bakkkkarrr');
          emit(state.copyWith(
              addDiscountState: BaseSuccessState<String>(ans.data)));
        }
      case ApiresultError():
        {
          emit(state.copyWith(addDiscountState: BaseErrorState(ans.message)));
          print('the messgae');
        }
    }
  }

  deleteDiscount(int userId) async {
    emit(state.copyWith(deleteDiscountState: BaseLoadingState()));
    final ans = await _deleteDiscountUseCase(userId);
    switch (ans) {
      case ApiResultSuccess():
        {
          emit(state.copyWith(deleteDiscountState: BaseSuccessState(ans.data)));
        }
      case ApiresultError():
        {
          emit(
              state.copyWith(deleteDiscountState: BaseErrorState(ans.message)));
        }
    }
  }

  getAllDiscount() {
    // emit()
  }
}
