class PaymentMethodModel {
  int? id;
  int? userId;
  String? methodType;
  String? stripePaymentMethodId;

  PaymentMethodModel({
    this.id,
    this.userId,
    this.methodType,
    this.stripePaymentMethodId,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodModel(
      id: json['id'],
      userId: json['user_id'],
      methodType: json['method_type'],
      stripePaymentMethodId: json['stripe_payment_method_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": userId,
      "method_type": methodType,
      "stripe_payment_method_id": stripePaymentMethodId,
    };
  }
}
