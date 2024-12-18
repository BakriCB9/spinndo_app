class UpdateProviderRequest {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? nameService;
  final String? descriptionService;
  final String? categoryIdService;
  final String? cityNameService;
  final String? websiteService;
  final String? longitudeService;
  final String? latitudeService;

  List<DateSelect>? listOfDay;
  // final File certificate;
  // final List<File> images;

  UpdateProviderRequest(
      {this.firstName,
      this.lastName,
      //  this.certificate,
      // this.images,
      this.listOfDay,
      this.email,
      this.password,
      this.nameService,
      this.descriptionService,
      this.categoryIdService,
      this.cityNameService,
      this.websiteService,
      this.longitudeService,
      this.latitudeService});
  Map<String, dynamic> toJsonAccount() {
    return {'first_name': firstName, 'last_name': lastName, '_method': 'PUT'};
  }

  Map<String, dynamic> toJsonJobDetails() {
    //rint('the value of ');
    //return
    //Map<String,dynamic> ma=
    return {
      "service": {
        "name": nameService,
        'description': descriptionService,
        'latitude': latitudeService,
        'longitude': longitudeService
      },
      '_method': 'PUT'
    };
    //print(ma);
    //return ma;
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
