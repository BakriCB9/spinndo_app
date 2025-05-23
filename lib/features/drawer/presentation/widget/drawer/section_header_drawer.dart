import 'dart:io';
import 'dart:ui';

import 'package:app/core/constant.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/utils/app_shared_prefrence.dart';
import 'package:app/core/widgets/cash_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SectionHeaderDrawer extends StatefulWidget {
  const SectionHeaderDrawer({super.key});

  @override
  State<SectionHeaderDrawer> createState() => _SectionHeaderDrawerState();
}

class _SectionHeaderDrawerState extends State<SectionHeaderDrawer> {
  final _sharedPreferencesUtils = serviceLocator.get<SharedPreferencesUtils>();
  String? imageFromGallery;
  String? imageFromLogin;
  String? userName;
  String? userEmail;
  @override
  void initState() {
    super.initState();
    getImageGallery();
    getImageLogin();
    getUserName();
    getUserEmail();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: ColorManager.primary,
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 40.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Center(
                          child: Container(
                            width: 500.w,
                            height: 500.h,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: ShowImage(
                                imageFromGallery: imageFromGallery,
                                imageFromLogin: imageFromLogin,
                              ),
                            ),
                          ),
                        );
                      });
                },
                child: Container(
                  width: 175.w,
                  height: 175.h,
                  decoration:  BoxDecoration(
                    shape: BoxShape.circle,
                    color:Theme.of(context).primaryColorDark,
                  ),
                  child: ShowImage(
                    imageFromGallery: imageFromGallery,
                    imageFromLogin: imageFromLogin,
                  ),
                )),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(userName ?? 'Hello',
                  style: theme.textTheme.labelSmall!
                      .copyWith(color: theme.primaryColorLight)),
              subtitle: Text(userEmail ?? 'User@gmail.com',
                  style: theme.textTheme.labelSmall!
                      .copyWith(color: theme.primaryColorLight)),
            ),
            SizedBox(
              height: 10.h,
            )
          ],
        ),
      ),
    );
  }

  getImageGallery() {
    imageFromGallery =
        _sharedPreferencesUtils.getString(CacheConstant.imagePhotoFromFile);
  }

  getImageLogin() {
    imageFromLogin =
        _sharedPreferencesUtils.getString(CacheConstant.imagePhoto);
  }

  getUserName() {
    userName = _sharedPreferencesUtils.getString(CacheConstant.nameKey);
  }

  getUserEmail() {
    userEmail = _sharedPreferencesUtils.getString(CacheConstant.emailKey);
  }
}

class ShowImage extends StatelessWidget {
  final String? imageFromGallery;
  final String? imageFromLogin;
  const ShowImage(
      {required this.imageFromGallery,
      required this.imageFromLogin,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: 'show_image',
        child: imageFromGallery != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(500.r),
                child: Image.file(
                  File(imageFromGallery!),
                  fit: BoxFit.cover,
                ))
            : imageFromLogin != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(500.r),
                    child: CashImage(path: imageFromLogin!),
                  )
                : const Icon(Icons.person));
  }
}
