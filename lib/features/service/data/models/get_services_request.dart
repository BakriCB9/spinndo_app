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

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
        "radius": radius,
        "category_id": categoryId,
        "country_id": countryId,
        "city_id": cityId
      };
}
