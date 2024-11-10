import 'dart:io';

import 'package:dio/dio.dart';

class RegisterServiceProviderRequest {
  final String first_name;
  final String last_name;
  final String email;
  final String password;
  final String nameService;
  final String descriptionService;
  final String categoryIdService;
  final String cityIdService;
  final String websiteService;
  final String longitudeService;
  final String latitudeService;
  late final Map<String, dynamic> service;
   final List<DateSelect> working_days;
  final File certificate;
  final List<File> images;
  RegisterServiceProviderRequest(
      {required this.first_name,
      required this.last_name,
        required this.certificate,required this.images,
      required this.email,
        required this.working_days,
      required this.password,
      required this.nameService,
      required this.descriptionService,
      required this.categoryIdService,
      required this.cityIdService,
      required this.websiteService,
      required this.longitudeService,
        required this.latitudeService}) {
    service = {
      "name":nameService,
      "description":descriptionService,
      "category_id":categoryIdService,
      "city_id":cityIdService,
      "website":websiteService,
      "longitude":longitudeService,
      "latitude":latitudeService,
      "working_days":working_days,
      "certificate":MultipartFile.fromFile(certificate.path, filename: certificate.path.split('/').last),
      "images":[
        MultipartFile.fromFile(images[0].path, filename: images[0].path.split('/').last),
        MultipartFile.fromFile(images[1].path, filename: images[1].path.split('/').last)
      ]
    };
  }
  Map<String, dynamic> toJson() => {
    "first_name": first_name,
    "last_name": last_name,
    "email": email,
    "password": password,
    "service":service
  };
}

class DateSelect{
  String day;
  bool isSelect;
  String start;
  String end;
  DateSelect({required this.day, required this.start, required this.end,this.isSelect=false});
  Map<String,String> toJson()=>{
    'day':day,
    'start':start,
    'end':end
  };
}