import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';

class ImageFunctions {
  static Future<File?> _cropSquareImage(String imagePath) async {
    final croppedImage = await ImageCropper().cropImage(
      sourcePath: imagePath,
      aspectRatio:
          const CropAspectRatio(ratioX: 1, ratioY: 1), // Square aspect ratio
      uiSettings: [
        AndroidUiSettings(
          hideBottomControls: false,
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.black,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          title: 'Crop Image',
        ),
      ],
    );

    if (croppedImage != null) {
      return File(croppedImage.path);
    } else {
      return null; // Cropping was canceled
    }
  }

  static Future<File?> _cropImage(String imagePath) async {
    final croppedImage = await ImageCropper().cropImage(
      sourcePath: imagePath,
      
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.black,
          aspectRatioPresets: [
            
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            
            CropAspectRatioPreset.ratio16x9,
            CropAspectRatioPreset.square,
          ],
          hideBottomControls: false,
          initAspectRatio: CropAspectRatioPreset.original,
          toolbarWidgetColor: Colors.white,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Crop Image',
        ),
      ],
    );

    if (croppedImage != null) {
      return File(croppedImage.path);
    } else {
      return null; // Cropping was canceled
    }
  }

  static Future<File?> CameraPicker(bool isSquare) async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      return await isSquare
          ? _cropSquareImage(image.path)
          : _cropImage(image.path);
    } else {
      return null;
    }
  }


  static Future<File?> galleryPicker(bool isSquare) async {
    PermissionStatus status;

    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;

      // Check Android SDK version
      if (androidInfo.version.sdkInt >= 33) {
        // Android 13+: Request for photos access
        status = await Permission.photos.request();
      } else {
        // Android 12 and below: Request for storage access
        status = await Permission.storage.request();
      }
    } else {
      // For iOS or other platforms, request appropriate permission
      status = await Permission.photos.request();
    }

    if (status.isGranted) {
      // Picking image from gallery
      XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        return await isSquare
            ? _cropSquareImage(image.path)
            : _cropImage(image.path);
      } else {
        return null;
      }
    } else {
      // Permission not granted
      return null;
    }
  }

  static Future<List<File>?> galleryImagesPicker() async {
    PermissionStatus status;
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt <= 34) {
        status = await Permission.storage.request();
      } else {
        status = await Permission.phone.request();
      }
    } else {
      status = await Permission.phone.request();
    }
    if (status.isGranted) {
      List<XFile?> images = await ImagePicker().pickMultiImage(limit: 2);
      if (images != null) {
        return images.map((file) => File(file!.path)).toList();
      } else {
        return null;
      }
    }
  }
}
