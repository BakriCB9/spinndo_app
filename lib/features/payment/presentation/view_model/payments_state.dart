import 'package:app/features/payment/data/model/payments_model.dart';
import 'package:app/features/payment/data/model/subscription/payment_response.dart';
abstract class PaymentsState {}

class PaymentsInitial extends PaymentsState {}

class PaymentsLoading extends PaymentsState {}

class PaymentsSuccess extends PaymentsState {
  final List<PaymentMethodModel?> payments;

  PaymentsSuccess(this.payments);
}

class PaymentsError extends PaymentsState {
  final String message;

  PaymentsError(this.message);
}

class PaymentsLoaded extends PaymentsState {
  final List<PaymentMethodModel?> payments;

  PaymentsLoaded(this.payments);
}

class PaymentAddSuccess extends PaymentsState {
  final PaymentResponse response;

  PaymentAddSuccess(this.response);
}

class PaymentAddError extends PaymentsState {
  final String message;
  final Object? error;

  PaymentAddError(this.message, [this.error]);
}

class RefundAddSuccess extends PaymentsState {
  final PaymentResponse response;

  RefundAddSuccess(this.response);
}

