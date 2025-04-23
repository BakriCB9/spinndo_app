class PaymentMethodModel {
  final int id;
  final int userId;
  final String methodType;
  final PaymentDetails details;
  final bool isDefault;
  final String stripePaymentMethodId;

  PaymentMethodModel({
    required this.id,
    required this.userId,
    required this.methodType,
    required this.details,
    required this.isDefault,
    required this.stripePaymentMethodId,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodModel(
      id: json['id'],
      userId: json['user_id'],
      methodType: json['method_type'],
      details: PaymentDetails.fromJson(json['details']),
      isDefault: json['is_default'],
      stripePaymentMethodId: json['stripe_payment_method_id'],
    );
  }
}

class PaymentDetails {
  final String brand;
  final String last4;
  final int expMonth;
  final int expYear;

  PaymentDetails({
    required this.brand,
    required this.last4,
    required this.expMonth,
    required this.expYear,
  });

  factory PaymentDetails.fromJson(Map<String, dynamic> json) {
    return PaymentDetails(
      brand: json['brand'],
      last4: json['last4'],
      expMonth: json['exp_month'],
      expYear: json['exp_year'],
    );
  }
}
