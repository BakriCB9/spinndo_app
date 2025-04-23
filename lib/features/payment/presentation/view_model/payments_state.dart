import 'package:app/features/payment/data/model/payments_model.dart';
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
