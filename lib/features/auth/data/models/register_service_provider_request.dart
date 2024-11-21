import 'dart:io';

import 'package:dio/dio.dart';

class RegisterServiceProviderRequest {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String nameService;
  final String descriptionService;
  final String categoryIdService;
  final String cityIdService;
  final String websiteService;
  final String longitudeService;
  final String latitudeService;

  final List<DateSelect> listOfDay;
  final File certificate;
  final List<File> images;

  RegisterServiceProviderRequest(
      {required this.firstName,
      required this.lastName,
      required this.certificate,
      required this.images,
      required this.email,
      required this.listOfDay,
      required this.password,
      required this.nameService,
      required this.descriptionService,
      required this.categoryIdService,
      required this.cityIdService,
      required this.websiteService,
      required this.longitudeService,
      required this.latitudeService});

  // Asynchronous method to create `FormData` for Dio.
  Future<FormData> toFormData() async {
    final List<Map<String, String?>> days = [];
    for (int i = 0; i < listOfDay.length; i++) {
      if (listOfDay[i].daySelect) {
        days.add(listOfDay[i].toJson());
      }
    }
    // Convert certificate and images to MultipartFile
    final certificateFile = await MultipartFile.fromFile(
      certificate.path,
      filename: certificate.path.split('/').last,
    );

    // List<MultipartFile> multiOfImages = images.map((e) async {
    //   return await MultipartFile.fromFile(e.path,
    //       filename: e.path.split('/').last);
    // }).toList();

    List<MultipartFile> imageFiles = await Future.wait(
      images.map((image) async {
        return await MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
        );
      }),
    );
    final imageOne=await MultipartFile.fromFile(
          images[0].path,
          filename: images[0].path.split('/').last,
        );
        final imageTwo=await MultipartFile.fromFile(
          images[1].path,
          filename: images[1].path.split('/').last,
        );
  print('the certitifacate is yyyyyyyyyyyyyyyyyyyyyyyyyyyy   ${certificateFile.filename}');
  for(int i=0;i<imageFiles.length;i++){
    print('the value of first is   ${imageFiles[i].filename}');
  }
   print('the file of images is rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr  ${imageFiles}');
    return FormData.fromMap({
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "password": password,
      "service[images][1]":imageOne,
      "service[images][0]": imageTwo,
      "service": {
        "name": nameService,
        "description": descriptionService,
        "category_id": categoryIdService,
        "city_id": cityIdService,
        "website": websiteService,
        "longitude": longitudeService,
        "latitude": latitudeService,
        "working_days": days,
        "certificate": certificateFile,
        
      },
    });
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
