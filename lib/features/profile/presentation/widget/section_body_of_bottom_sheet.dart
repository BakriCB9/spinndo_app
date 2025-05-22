import 'package:app/core/constant.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/utils/app_shared_prefrence.dart';
import 'package:app/core/utils/image_functions.dart';
import 'package:app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:app/features/profile/presentation/widget/section_items_of_show_model_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SectionBodyOfBottomSheet extends StatelessWidget {
  final ProfileCubit profileCubit;
  const SectionBodyOfBottomSheet({required this.profileCubit, super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final sharedPreferencesUtils = serviceLocator.get<SharedPreferencesUtils>();
    final imagePhotoLogin = sharedPreferencesUtils.getData(
        key: CacheConstant.imagePhoto) as String?;
    final imagePhotoGallery = sharedPreferencesUtils.getData(
        key: CacheConstant.imagePhotoFromFile) as String?;
    return SafeArea(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Center(
                  child: Text(localization.profilePhoto),
                ),
              ),
              imagePhotoGallery != null || imagePhotoLogin != null
                  ? IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        profileCubit.deleteImage();
                      },
                      icon: const Icon(Icons.delete))
                  : const SizedBox(),
            ],
          ),
          SizedBox(height: 30.h),
          Row(
            children: [
              SectionItemsOfShowModelBottom(
                  title: localization.camera,
                  select: () async {
                    Navigator.of(context).pop();
                    final image = await ImageFunctions.CameraPicker(true);
                    if (image == null) {
                      return;
                    }
                    profileCubit.addImagePhoto(image);
                  }),
              SizedBox(width: 35.w),
              SectionItemsOfShowModelBottom(
                title: localization.gallery,
                select: () async {
                  Navigator.of(context).pop();
                  final image = await ImageFunctions.galleryPicker(true);
                  if (image == null) {
                    return;
                  }
                  profileCubit.addImagePhoto(image);
                },
              )
            ],
          ),
          SizedBox(height: 50.h)
        ],
      ),
    ));
  }
}

// Column(
                                                //   children: [
                                                //     GestureDetector(
                                                //       onTap: () async {
                                                //         Navigator.of(context)
                                                //             .pop();
                                                //         final image =
                                                //             await ImageFunctions
                                                //                 .galleryPicker(
                                                //                     true);
                                                //         if (image == null) {
                                                //           return;
                                                //         }
                                                //         _profileCubit
                                                //             .addImagePhoto(
                                                //                 image);
                                                //       },
                                                //       child: Container(
                                                //         width: 100.w,
                                                //         height: 100.h,
                                                //         decoration: BoxDecoration(
                                                //             shape:
                                                //                 BoxShape.circle,
                                                //             border: Border.all(
                                                //                 color: Colors
                                                //                     .grey)),
                                                //         child: const Icon(
                                                //           Icons.image_outlined,
                                                //           color: ColorManager
                                                //               .primary,
                                                //         ),
                                                //       ),
                                                //     ),
                                                //     SizedBox(height: 15.h),
                                                //     Text(
                                                //       'Gallery',
                                                //       style: Theme.of(context)
                                                //           .textTheme
                                                //           .titleLarge!
                                                //           .copyWith(
                                                //               fontSize: 25.sp),
                                                //     )
                                                //   ],
                                                // ),