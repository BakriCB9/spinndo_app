import 'dart:io';
import 'package:app/core/constant.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/utils/ui_utils.dart';
import 'package:app/core/widgets/cash_network.dart';
import 'package:app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:app/features/profile/presentation/cubit/profile_states.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class CustomContainer extends StatelessWidget {
  final String? initialImage;
  final double? width;
  final BoxShape shape;

  const CustomContainer({
    required this.shape,
    this.width,
    required this.initialImage,
    super.key,
  });

  // String? _currentImage;
  @override
  Widget build(BuildContext context) {
    final imagePhotoLogin =
    sharedPref.getString(CacheConstant.imagePhotoFromLogin);
    final imagePhotoGallery = sharedPref.getString(CacheConstant.imagePhoto);

    return Stack(
      // fit: StackFit.expand,
      children: [
        Container(
          width: width,
          height: width, // Match height to width for circles
          decoration: BoxDecoration(
            shape: shape,
          ),
          clipBehavior: Clip.antiAlias,
          child: BlocConsumer<ProfileCubit, ProfileStates>(
              listener: (context, state) {
                if (state is LoadImagePhotoError) {
                  UIUtils.showMessage(state.message);
                }
              },
              buildWhen: (pre, cur) {
                if (cur is LoadImagePhotoLoading
             ||   cur is LoadImagePhotoError
               || cur is LoadImagePhotoSuccess) {
                  return true;
                }
                return false;
              },
              bloc: serviceLocator.get<ProfileCubit>(),
              builder: (context, state) {
                final ans = sharedPref.getString('imageFile');

                if (state is LoadImagePhotoLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                }
                if (state is LoadImagePhotoLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: ColorManager.white,
                    ),
                  );
                }
                return imagePhotoGallery == null
                    ? imagePhotoLogin == null
                    ? Image.asset(
                  'asset/images/aaaa.png',
                  fit: BoxFit.cover,
                )
                    : CashImage(path: imagePhotoLogin)
                    : ans != null && imagePhotoGallery.isNotEmpty
                    ? Builder(builder: (context) {
                  print('');
                  print(
                      ' builderbuilder bulder builder builder builder builder  ');
                  print('');
                  return Image.file(
                    File(ans),
                    fit: BoxFit.cover,
                  );
                })
                    : const Image(
                  image: AssetImage('asset/images/aaaa.png'),
                  fit: BoxFit.cover,
                );
              }),
        ),

      ],
    );
  }
}