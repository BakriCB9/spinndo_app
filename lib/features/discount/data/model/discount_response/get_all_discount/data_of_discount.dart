import 'package:app/features/discount/domain/entity/all_discount_entity.dart';

class DataOfDiscount {
  int? id;
  int? discount;
  String? discountCode;
  dynamic discountAddedAt;
  int? providerId;
  String? providerName;
  dynamic providerImage;

  DataOfDiscount({
    this.id,
    this.discount,
    this.discountCode,
    this.discountAddedAt,
    this.providerId,
    this.providerName,
    this.providerImage,
  });

  factory DataOfDiscount.fromJson(Map<String, dynamic> json) => DataOfDiscount(
        id: json['id'] as int?,
        discount: json['discount'] as int?,
        discountCode: json['discount_code'] as String?,
        discountAddedAt: json['discount_added_at'] as dynamic,
        providerId: json['provider_id'] as int?,
        providerName: json['provider_name'] as String?,
        providerImage: json['provider_image'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'discount': discount,
        'discount_code': discountCode,
        'discount_added_at': discountAddedAt,
        'provider_id': providerId,
        'provider_name': providerName,
        'provider_image': providerImage,
      };

  AllDiscountEntity toAllDiscountEntity() {
    return AllDiscountEntity(
        discount: discount,
        image: providerImage,
        discountCode: discountCode,
        providerId: providerId,
        providerName: providerName);
  }
}
