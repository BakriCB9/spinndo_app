import 'dart:io';

import 'package:dio/dio.dart';

class RegisterServiceProviderRequest {
  final String firstName;
  final String lastName;
  final String firstNameAr;
  final String lastNameAr;
  final String email;
  final String password;
  final String nameService;
  final String descriptionService;
  final String categoryIdService;
  final String cityNameService;
  final String? websiteService;
  final String longitudeService;
  final String latitudeService;
  final String phoneNumber;

  final List<DateSelect> listOfDay;
  final File certificate;
  final List<File?> images;

  RegisterServiceProviderRequest({
    required this.firstName,
    required this.lastName,
    required this.firstNameAr,
    required this.lastNameAr,
    required this.certificate,
    required this.images,
    required this.email,
    required this.listOfDay,
    required this.password,
    required this.nameService,
    required this.descriptionService,
    required this.categoryIdService,
    required this.cityNameService,
    this.websiteService,
    required this.longitudeService,
    required this.latitudeService,
    required this.phoneNumber,
  });

  // Asynchronous method to create `FormData` for Dio.
  Future<FormData> toFormData() async {
    final List<Map<String, String?>> days = [];
    for (int i = 0; i < listOfDay.length; i++) {
      if (listOfDay[i].daySelect) {
        days.add(listOfDay[i].toJson());
      }
    }

    String firsNametLetter = firstName[0].toUpperCase();
    String remainingNameText = firstName.substring(1);
    String firsServiceNametLetter = nameService[0].toUpperCase();
    String remainingServiceNameText = nameService.substring(1);
    // Convert certificate and images to MultipartFile
    final certificateFile = await MultipartFile.fromFile(
      certificate.path,
      filename: certificate.path.split('/').last,
    );
    //      List<MultipartFile> listOfMultipart = await Future.wait(
    //   images.map(
    //     (imageFile) async => await MultipartFile.fromFile(
    //       imageFile!.path,
    //       filename: imageFile.path.split('/').last,
    //     ),
    //   ),
    // );
    // List<MultipartFile> imageFiles = await Future.wait(
    //   images.map((image) async {
    //     return await MultipartFile.fromFile(
    //       image.path,
    //       filename: image.path.split('/').last,
    //     );
    //   }),
    // );
    // List<MultipartFile>listOfMultiPart=[];
    // for(int i=0;i<images.length;i++){
    //    final imageone=await MultipartFile.fromFile(images[i]!.path,filename: images[i]!.path.split('/').last);
    //   listOfMultiPart.add(imageone);
    // }
    //print('the legnhth of multipartfile is @@@@@@@@@@@@@@@@@@@@@@@@@@@ ${listOfMultiPart.length} !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
    // final imageOne = await MultipartFile.fromFile(
    //   images[0].path,
    //   filename: images[0].path.split('/').last,
    // );
    // final imageTwo = await MultipartFile.fromFile(
    //   images[1].path,
    //   filename: images[1].path.split('/').last,
    // );

    // for (int i = 0; i < imageFiles.length; i++) {
    //   print('the value of first is   ${imageFiles[i].filename}');
    // }

    // "service[images][1]": imageOne,
    // "service[images][0]": imageTwo,

    return FormData.fromMap({
      "first_name": firsNametLetter + remainingNameText,
      "last_name": lastName,
      "first_name_ar": firstNameAr,
      "last_name_ar": lastNameAr,
      "email": email,
      "password": password,
      "phone": phoneNumber,
      "service": {
        "name": firsServiceNametLetter + remainingServiceNameText,
        "description": descriptionService,
        "category_id": categoryIdService,
        "city_name": cityNameService,
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
