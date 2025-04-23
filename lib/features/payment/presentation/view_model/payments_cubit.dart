import 'package:app/features/packages/data/model/package_model.dart';
import 'package:app/features/payment/data/model/payments_model.dart';
import 'package:app/features/payment/domain/usecase/get_all_payments_usecase.dart';
import 'package:app/features/payment/presentation/view_model/payments_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/apiResult.dart';
import '../../../auth/data/models/category_response/datum.dart';

@injectable
class PaymentsCubit extends Cubit<PaymentsState> {
  PaymentsCubit(this.getAllPaymentsUseCase) : super(PaymentsInitial());

  final GetAllPaymentsUseCase getAllPaymentsUseCase;


  Future<void> getAllPayments() async {
    emit(PaymentsLoading());
    ApiResult<List<PaymentMethodModel?>> result = await getAllPaymentsUseCase();
    switch (result) {
      case ApiResultSuccess():
        {
          print('');
          print('the ans of value list is ${result.data}');
          print('');
          emit(PaymentsSuccess(result.data));
        }
      case ApiresultError():
        {
          emit(PaymentsError("error ya error"));
        }
    }
  }
}


