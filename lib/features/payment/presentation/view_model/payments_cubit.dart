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

@injectable
class PaymentsCubit extends Cubit<PaymentsState> {
  PaymentsCubit(this.getAllPaymentsUseCase, this.addPaymentMethodUseCase, this.cancelSubscriptionUseCase) : super(PaymentsInitial());

  final GetAllPaymentsUseCase getAllPaymentsUseCase;
  final AddPaymentMethodUseCase addPaymentMethodUseCase;
  final RefundPaymentMethodUseCase cancelSubscriptionUseCase;

  Future<void> addPayment(PaymentMethodModel method) async {
    emit(PaymentsLoading()); // حالة تحميل

    final result = await addPaymentMethodUseCase(method);

    if (result is ApiResultSuccess<PaymentResponse?> && result.data != null) {
      emit(PaymentAddSuccess(result.data!)); // نجاح العملية
      print('تمت إضافة طريقة الدفع بنجاح: ${result.data}');
    } else if (result is ApiresultError<PaymentResponse?>) {
      emit(PaymentAddError(result.message)); // فشل العملية
      print('فشل إضافة وسيلة الدفع: ${result.message}');
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


