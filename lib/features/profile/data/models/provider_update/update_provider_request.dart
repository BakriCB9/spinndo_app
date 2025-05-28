import 'package:dio/dio.dart';

class UpdateProviderRequest {
  final String? firstName;
  final String? lastName;
  final String? password;
  final String? nameService;
  final String? descriptionService;
  final String? categoryIdService;
  final String? cityNameService;
  final String? websiteService;
  final String? longitudeService;
  final String? latitudeService;
  final String? firstNameAr;
  final String? lastNameAr;
  List<DateSelect>? listOfDay;
  final String? phoneNumber;
  final String? email;

  // final File certificate;
  // final List<File> images;

  UpdateProviderRequest(
      {this.firstName,
      this.lastName,
      this.firstNameAr,
      this.lastNameAr,
      this.phoneNumber,
      this.email,
      //  this.certificate,
      // this.images,
      this.listOfDay,
      this.password,
      this.nameService,
      this.descriptionService,
      this.categoryIdService,
      this.cityNameService,
      this.websiteService,
      this.longitudeService,
      this.latitudeService});

  Map<String, dynamic> toJsonAccount() {
    return {
      "first_name": firstName,
      "last_name": lastName,
      "first_name_ar": firstNameAr,
      "last_name_ar": lastNameAr,
      "phone": phoneNumber,
    };
  }

  toJsonJobDetails() {
    final Map<String, dynamic> map = {};
    if (categoryIdService != null) map['category_id'] = categoryIdService;
    if (cityNameService != null) map['city_name'] = cityNameService;
    if (nameService != null) map['name'] = nameService;
    if (descriptionService != null) map['description'] = descriptionService;
    if (latitudeService != null) map['latitude'] = latitudeService;
    if (longitudeService != null) map['longitude'] = longitudeService;
    if (websiteService != null) map['website'] = websiteService;
    print('the map is now $map');
    return {
      "service":
          // "name": nameService,
          // 'description': descriptionService,
          // 'latitude': latitudeService,
          // 'longitude': longitudeService,
          //'category_id': categoryIdService,
          // 'city_name': cityNameService,
          //'website': websiteService,
          map,
      // '_method': 'PUT'
    };

  }

  Map<String, dynamic> toJsonDateTime() {
    List<Map<String, dynamic>> days = [];
    for (int i = 0; i < listOfDay!.length; i++) {
      if (listOfDay![i].daySelect) {
        days.add(listOfDay![i].toJson());
      }
    }

    return {
      "service": {
        "working_days": days,
      },
    };
  }
}

class DateSelect {
  String day;
  bool daySelect;
  String? start;
  String? end;
  bool arrowSelect;

  DateSelect(
      {required this.day,
      this.start,
      this.end,
      this.daySelect = false,
      this.arrowSelect = true});

  Map<String, String?> toJson() => {"day": day, "start": start, "end": end};
}
