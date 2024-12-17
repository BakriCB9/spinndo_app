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

  // final List<DateSelect> listOfDay;
  // final File certificate;
  // final List<File> images;

  UpdateProviderRequest(
      {this.firstName,
        this.lastName,
        //  this.certificate,
        // this.images,
        this.email,
        //  this.listOfDay,
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

  Map<String ,dynamic>toJsonJobDetails(){
    return {
      'service[category_id]':categoryIdService,
      'service[name]':nameService,
      'service[description]':descriptionService,
      'service[city_name]':cityNameService,
      'service[latitude]':latitudeService,
      'service[longitude]':longitudeService,
      '_method':'PUT'
    };
  }

}