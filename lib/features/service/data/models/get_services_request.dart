class GetServicesRequest {
  final double? latitude;
  final double? longitude;
  final int? radius;
  final int? categoryId;
  final int? countryId;
  final int? cityId;

  GetServicesRequest(
      { this.latitude,
       this.longitude,
       this.radius,
       this.categoryId,
       this.countryId,
       this.cityId});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (latitude != null) data['latitude'] = latitude;
    if (longitude != null) data['longitude'] = longitude;
    if (radius != null) data['radius'] = radius;
    if (categoryId != null) data['category_id'] = categoryId;
    if (countryId != null) data['country_id'] = countryId;
    if (cityId != null) data['city_id'] = cityId;
    return data;
  }


}
