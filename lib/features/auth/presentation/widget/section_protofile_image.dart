import 'dart:io';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/utils/image_functions.dart';
import 'package:app/features/auth/presentation/cubit/cubit/register_cubit.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SectionProtofileImage extends StatefulWidget {
  final RegisterCubit registerCubit;
  const SectionProtofileImage({required this.registerCubit, super.key});

  @override
  State<SectionProtofileImage> createState() => _SectionProtofileImageState();
}

class _SectionProtofileImageState extends State<SectionProtofileImage> {
  final drawerCubit = serviceLocator.get<DrawerCubit>();
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Column(
      children: [
        GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.registerCubit.listOfFileImagesProtofile.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 4,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemBuilder: (context, index) {
              return index ==
                      widget.registerCubit.listOfFileImagesProtofile.length - 1
                  ? SizedBox(
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => singleDialog(2, false),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.r),
                                    color: Colors.grey.withOpacity(0.1),
                                  ),
                                  child: Center(
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(localization.clickToUpload,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall),
                                          SizedBox(width: 20.w),
                                          Icon(Icons.upload, size: 45.sp),
                                        ],
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.r),
                            color: Colors.grey.withOpacity(0.1),
                          ),
                          child: AspectRatio(
                            aspectRatio: 3 / 4,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.r)),
                              child: Image(
                                image: FileImage(
                                  widget.registerCubit
                                      .listOfFileImagesProtofile[index]!,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Container(
                            width: 50.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.grey, width: 2)),
                            child: Center(
                                child: InkWell(
                              onTap: () {
                                //listOfFileImage.removeAt(index);
                                deleteImageProtofile(
                                    widget.registerCubit
                                        .listOfFileImagesProtofile[index],
                                    index);

                                // setState(() {});
                              },
                              child: Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 30.sp,
                              ),
                            )))
                      ],
                    );
            }),
      ],
    );
  }

  void singleDialog(int type, bool hasImage) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).primaryColorDark,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _imagePickerOption(
              icon: Icons.camera_alt_outlined,
              label: drawerCubit.languageCode == "en" ? "Camera" : "الكاميرا",
              onTap: () async {
                final image = await ImageFunctions.CameraPicker(false);
                if (image != null) {
                  // _updateImage(type, image);
                  if (type == 1) {
                    //updateCertificateImage(image);
                  } else {
                    addImagetoProtofile(image);
                  }
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
                    // widget.registerCubit.updateCertificateImage(image);
                  } else {
                    addImagetoProtofile(image);
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
                  // _deleteImage(type);
                  // widget.registerCubit.updateCertificateImage(null);

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
              color: Theme.of(context).primaryColor,
            ),
            onPressed: onTap,
          ),
          Text(label,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              )),
        ],
      ),
    );
  }

  // void _deleteImage(int type) {
  //   if (type == 1) {
  //     widget.registerCubit.updateCertificateImage(null);
  //   }
  // }
  void deleteImageProtofile(File? imgae, int index) {
    setState(() {
      widget.registerCubit.listOfFileImagesProtofile.removeAt(index);
    });
  }

  void addImagetoProtofile(
    File? image,
  ) {
    //firstImage = image;
    setState(() {
      widget.registerCubit.listOfFileImagesProtofile.removeLast();
      widget.registerCubit.listOfFileImagesProtofile.add(image);
      widget.registerCubit.listOfFileImagesProtofile.add(File(""));
    });

    // emit(UpdateImageProtofile());
  }
}
