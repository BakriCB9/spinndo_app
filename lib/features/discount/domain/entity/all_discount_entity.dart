class AllDiscountEntity {
  final String? providerName;
  final int? discount;
  final String? discountCode;
  final int? providerId;
  final String ?image;
  AllDiscountEntity(
      {required this.discount,
      required this.discountCode,
      required this.providerId,
      required this.image,
      required this.providerName});
}
