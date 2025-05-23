import 'dart:io';

import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/utils/image_functions.dart';
import 'package:app/features/auth/presentation/cubit/cubit/register_cubit.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SectionCertificateImage extends StatefulWidget {
  final RegisterCubit registerCubit;
  const SectionCertificateImage({required this.registerCubit, super.key});

  @override
  State<SectionCertificateImage> createState() =>
      _SectionCertificateImageState();
}

class _SectionCertificateImageState extends State<SectionCertificateImage> {
  final drawerCubit = serviceLocator.get<DrawerCubit>();
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Column(children: [
      GestureDetector(
          onTap: () =>
              singleDialog(1, widget.registerCubit.certificateImage != null),
          child:
              Container(
                  width: double.infinity,
                  height: 350.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: widget.registerCubit.certificateImage == null
                      ? Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                              Text(localization.uploadYourCertificate,
                                  style: Theme.of(context).textTheme.bodySmall),
                              SizedBox(width: 20.w),
                              Icon(Icons.upload, size: 45.sp),
                            ]))
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(30.r),
                          child: SingleChildScrollView(
                              child: Image.file(
                            widget.registerCubit.certificateImage!,
                            fit: BoxFit.cover,
                          ))))),
      widget.registerCubit.certificateImage == null
          ? const SizedBox()
          : Column(children: [
              SizedBox(height: 20.h),
              Row(children: [
                Text(
                  localization.tryToScroll,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10.w),
                Icon(Icons.touch_app, size: 35.sp)
              ])
            ])
    ]);
  }

  void singleDialog(int type, bool hasImage) {
    final localization = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).primaryColorDark,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _imagePickerOption(
              icon: Icons.camera_alt_outlined,
              label: localization.camera,

              onTap: () async {
                final image = await ImageFunctions.CameraPicker(false);
                if (image != null) {
                  // _updateImage(type, image);
                  if (type == 1) {
                    updateCertificateImage(image);
                  } else {
                    //addImagetoProtofile(image);
                  }
                  //listOfFileImage.add(image);
                  //setState(() {});
                }
                Navigator.pop(context);
              },
            ),
            _imagePickerOption(
              icon: Icons.image,
              label: drawerCubit.languageCode == "en" ? "Gallery" : "المعرض",
              onTap: () async {
                final image = await ImageFunctions.galleryPicker(false);
                if (image != null) {
                  //   _updateImage(type, image);
                  if (type == 1) {
                    updateCertificateImage(image);
                  } else {
                    // widget.authCubit.addImagetoProtofile(image);
                  }
                  // listOfFileImage.add(image);
                  // setState(() {});
                }
                Navigator.pop(context);
              },
            ),
            if (type == 1 && widget.registerCubit.certificateImage != null)
              _imagePickerOption(
                icon: Icons.delete,
                label: drawerCubit.languageCode == "en" ? "Delete" : "حذف",
                onTap: () {
                  _deleteImage(type);
                  updateCertificateImage(null);

                  Navigator.pop(context);
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _imagePickerOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(
              icon,
              size: 40,
              color: ColorManager.primary,
            ),
            onPressed: onTap,
          ),
          Text(label,
              style: TextStyle(
                color: ColorManager.primary,
              )),
        ],
      ),
    );
  }

  void _deleteImage(int type) {
    if (type == 1) {
      updateCertificateImage(null);
    }
  }

  void updateCertificateImage(File? image) {
    setState(() {
      widget.registerCubit.certificateImage = image;
    });
  }
}
