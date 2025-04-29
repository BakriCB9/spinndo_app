import 'package:app/features/packages/data/model/package_model.dart';
import 'package:app/features/payment/data/model/payments_model.dart';
import 'package:app/features/payment/data/model/subscription/payment_response.dart';
import 'package:app/features/payment/data/model/subscription/refund_response.dart';
import 'package:app/features/payment/domain/usecase/add_payment_method_usecase.dart';
import 'package:app/features/payment/domain/usecase/get_all_payments_usecase.dart';
import 'package:app/features/payment/domain/usecase/refund_payment_usecase.dart';
import 'package:app/features/payment/presentation/view_model/payments_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/apiResult.dart';
import '../../../auth/data/models/category_response/datum.dart';

@injectable
class PaymentsCubit extends Cubit<PaymentsState> {
  PaymentsCubit(this.getAllPaymentsUseCase, this.addPaymentMethodUseCase, this.cancelSubscriptionUseCase) : super(PaymentsInitial());

  final GetAllPaymentsUseCase getAllPaymentsUseCase;
  final AddPaymentMethodUseCase addPaymentMethodUseCase;
  final RefundPaymentMethodUseCase cancelSubscriptionUseCase;

  Future<void> addPayment(PaymentMethodModel method) async {
    ApiResult<PaymentResponse?> result = await addPaymentMethodUseCase(method);

    if (result is ApiResultSuccess<PaymentResponse>) {
      print('the result is ${result.data}');
    } else if (result is ApiresultError<PaymentResponse>) {
      print('the fail result is ${result.message}');
    }
  }

  Future<void> addRefund(String? paymentIntentId) async {
    if (paymentIntentId == null) return;

    ApiResult<RefundResponse?> result = await cancelSubscriptionUseCase(paymentIntentId);

    switch (result) {
      case ApiResultSuccess():
        {
          print('Unsubscription successful: ${result.data}');
        }
      case ApiresultError(message: final message, error: final error):
        {
          print('Failed to cancel subscription: $message');
        }
    }
  }

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


