import 'dart:io';
import 'package:app/core/constant.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/utils/app_shared_prefrence.dart';
import 'package:app/core/utils/ui_utils.dart';
import 'package:app/core/widgets/cash_network.dart';
import 'package:app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:app/features/profile/presentation/cubit/profile_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SectionImage extends StatefulWidget {
  const SectionImage({super.key});

  @override
  State<SectionImage> createState() => _SectionImageState();
}

class _SectionImageState extends State<SectionImage> {
  final localCache = serviceLocator.get<SharedPreferencesUtils>();
  String? imageFromStudio;
  String? imageFromLogin;

  @override
  void initState() {
    imageFromLogin = getImageFromLogin();
    imageFromStudio = getImageFromStudio();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileStates>(
      
      listener: (context,state){
        if(state is LoadImagePhotoError){
          UIUtils.showMessage(state.message);
        }
      },
      builder: (context, state) {
        if (state is LoadImagePhotoLoading) {
          return const Center(
              child: CircularProgressIndicator(
            color: ColorManager.white,
          ));
        } else if (state is LoadImagePhotoSuccess) {
          imageFromStudio = getImageFromStudio();
          return imageFromStudio != null
              ? Image.file(
                  File(imageFromStudio!),
                  fit: BoxFit.cover,
                )
              : imageFromLogin != null
                  ? CashImage(
                      path: imageFromLogin!,
                      color: ColorManager.white,
                    )
                  : Image.asset(
                      'asset/images/aaaa.png',
                      fit: BoxFit.cover,
                    );
        } else {
          return imageFromStudio != null
              ? Image.file(
                  File(imageFromStudio!),
                  fit: BoxFit.cover,
                )
              : imageFromLogin != null
                  ? CashImage(path: imageFromLogin!)
                  : Image.asset(
                      'asset/images/aaaa.png',
                      fit: BoxFit.cover,
                    );
        }
      },
    );
  }

  String? getImageFromStudio() {
    final ans =
        localCache.getData(key: CacheConstant.imagePhotoFromFile) as String?;
    return ans;
  }

  String? getImageFromLogin() {
    final ans = localCache.getData(key: CacheConstant.imagePhoto) as String?;
    return ans;
  }
}
