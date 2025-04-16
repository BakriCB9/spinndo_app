class AddDiscountRequest {
  final int userId;
  final int discount;
  final String discountCode;
  AddDiscountRequest(
      {required this.discount,
      required this.discountCode,
      required this.userId});

  Map<String, dynamic> toJson() {
    return {
      "user_id": userId,
      "discount": discount,
      "discount_code": discountCode,
    };
  }
}
