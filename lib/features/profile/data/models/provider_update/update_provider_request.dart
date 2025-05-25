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
      "email":email,
      '_method': 'PUT',
    };
  }

  toJsonJobDetails() {
    print(
        'the data is ${nameService} and description  is ${descriptionService} ');
    return FormData.fromMap({
      "service": {
        "name": nameService,
        'description': descriptionService,
        // 'latitude': latitudeService,
        // 'longitude': longitudeService,
        // 'category_id': categoryIdService
      },
      // '_method': 'PUT'
    });

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
      '_method': 'PUT'
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
