import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';

class ImageFunctions {
  static Future<File?>CameraPicker()async{
    XFile? image=await ImagePicker().pickImage(source: ImageSource.camera);
    if(image!=null){
      return File(image.path);
    }else{
      return null;
    }
  }
  static Future<File?> galleryPicker()async{
    PermissionStatus status;
    if(Platform.isAndroid){
      final androidInfo=await DeviceInfoPlugin().androidInfo;
      if(androidInfo.version.sdkInt<=32){
        status=await Permission.storage.request();
      }else{
        status=await Permission.phone.request();

      }
    }else{
      status=await Permission.phone.request();

    }
    if(status.isGranted){
      XFile? image=await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image!=null){
        return File(image.path);
      }else{
        return null;
      }
    }
  }  static Future<List<File>?> galleryPickers()async{
    PermissionStatus status;
    if(Platform.isAndroid){
      final androidInfo=await DeviceInfoPlugin().androidInfo;
      if(androidInfo.version.sdkInt<=32){
        status=await Permission.storage.request();
      }else{
        status=await Permission.phone.request();

      }
    }else{
      status=await Permission.phone.request();

    }
    if(status.isGranted){
      List<XFile> images=await ImagePicker().pickMultiImage();
      if(images!=null){
        return images.map((image) => File(image.path)).toList();
      }else{
        return null;
      }
    }
  }
}