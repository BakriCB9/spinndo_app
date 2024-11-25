import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:snipp/core/di/service_locator.dart';
import 'package:snipp/core/resources/color_manager.dart';
import 'package:snipp/core/utils/ui_utils.dart';
import 'package:snipp/features/auth/data/models/register_service_provider_request.dart';
import 'package:snipp/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:snipp/features/auth/presentation/cubit/auth_states.dart';
import 'package:snipp/features/auth/presentation/screens/verfication_code_screen.dart';
import 'package:snipp/features/drawer/presentation/cubit/drawer_cubit.dart';

import '../../../../core/utils/image_functions.dart';

class DeplomaProtofileImageScreen extends StatefulWidget {
  const DeplomaProtofileImageScreen({super.key});

  static const String routeName = '/deploma';

  @override
  State<DeplomaProtofileImageScreen> createState() =>
      _DeplomaProtofileImageScreenState();
}

class _DeplomaProtofileImageScreenState
    extends State<DeplomaProtofileImageScreen> {
  final _authCubit = serviceLocator.get<AuthCubit>();
  final _drawerCubit = serviceLocator.get<DrawerCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Upload Certificate Image",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 36.sp,
                fontFamily: "WorkSans",
                color:  _drawerCubit.themeMode== ThemeMode.dark
                    ? ColorManager.primary
                    : ColorManager.black,
              ),
            ),
            SizedBox(height: 20.h),
            GestureDetector(
              onTap: () => singleDialog(1, _authCubit.certificateImage != null),
              child: BlocBuilder<AuthCubit, AuthState>(
                bloc: _authCubit,
                buildWhen: (previous, current) =>
                current is CertificateImageUpdated,
                builder: (context, state) {
                  print("ddddddddddddddddddd");
                  final certificateImage = _authCubit.certificateImage;
                  return Container(
                    width: double.infinity,
                    height: 350.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: certificateImage == null
                        ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Upload your Certificate',
                            style: TextStyle(
                              color:     _drawerCubit.themeMode== ThemeMode.dark
                                  ? ColorManager.primary
                                  : ColorManager.primary,
                              fontSize: 35.sp,
                            ),
                          ),
                           Icon(
                            Icons.upload_file_rounded,
                            color:   _drawerCubit.themeMode== ThemeMode.dark
                                ? ColorManager.primary
                                : ColorManager.primary,
                          ),
                        ],
                      ),
                    )
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(30.r),
                      child: Image.file(
                        certificateImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 50.h),
            Text(
              "Upload Two Protofile Images",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35.sp,
                fontFamily: "WorkSans",color:   _drawerCubit.themeMode== ThemeMode.dark
                  ? ColorManager.primary
                  : ColorManager.black,
              ),
            ),
            SizedBox(height: 20.h),
            SizedBox(
              height: 350.h,
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () =>
                          singleDialog(2, _authCubit.firstImage != null),
                      child: BlocBuilder<AuthCubit, AuthState>(
                        bloc: _authCubit,
                        buildWhen: (previous, current) =>
                        current is FirstImageUpdated,
                        builder: (context, state) {
                          print("aaaaaaaaaaaaaaaaaaa");
                          final firstImage = _authCubit.firstImage;
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.r),
                              color: Colors.grey.withOpacity(0.1),
                            ),
                            child: firstImage == null
                                ? Center(
                              child: Text(
                                "Click to Upload",
                                style: TextStyle(
                                    fontSize: 25.sp,                              color:   _drawerCubit.themeMode== ThemeMode.dark
                                    ? ColorManager.primary
                                    : ColorManager.primary,
                                ),
                              ),
                            )
                                : ClipRRect(
                              borderRadius: BorderRadius.circular(25.r),
                              child: Image.file(
                                firstImage,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: () =>
                          singleDialog(3, _authCubit.secondImage != null),
                      child: BlocBuilder<AuthCubit, AuthState>(
                        bloc: _authCubit,
                        buildWhen: (previous, current) =>
                        current is SecondImageUpdated,
                        builder: (context, state) {
                          print("sssssssssssss");
                          final secondImage = _authCubit.secondImage;
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.r),
                              color: Colors.grey.withOpacity(0.1),
                            ),
                            child: secondImage == null
                                ? Center(
                              child: Text(
                                "Click to Upload",
                                style: TextStyle(
                                    fontSize: 25.sp,                               color:   _drawerCubit.themeMode== ThemeMode.dark
                                    ? ColorManager.primary
                                    : ColorManager.primary,
                                ),
                              ),
                            )
                                : ClipRRect(
                              borderRadius: BorderRadius.circular(25.r),
                              child: Image.file(
                                secondImage,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            BlocListener<AuthCubit, AuthState>(
              bloc: _authCubit,
              listener: (context, state) {
                if (state is RegisterServiceLoading) {
                  UIUtils.showLoading(context, 'asset/animation/loading.json');
                } else if (state is RegisterServiceError) {
                  UIUtils.hideLoading(context);
                  UIUtils.showMessage(state.message);
                } else if (state is RegisterServiceSuccess) {
                  UIUtils.hideLoading(context);
                  Navigator.of(context)
                      .pushNamed(VerficationCodeScreen.routeName);
                }
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 20.h),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if(_authCubit.certificateImage==null || _authCubit.firstImage==null||_authCubit.secondImage==null){
                      ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(
                            content: Text('You have to fill all images',style: TextStyle(fontSize: 28.sp,color: Colors.white)),),
                      );return;
                    }
                    _authCubit.registerService(RegisterServiceProviderRequest(
                        firstName: _authCubit.firstNameContoller.text,
                        lastName: _authCubit.lastNameContoller.text,
                        email: _authCubit.emailController.text,
                        listOfDay: _authCubit.dateSelect,
                        password: _authCubit.passwordController.text,
                        nameService: _authCubit.serviceNameController.text,
                        descriptionService:
                        _authCubit.serviceDescriptionController.text,
                        categoryIdService: _authCubit.selectedCategoryId!,
                        cityIdService: _authCubit.cityId,
                        websiteService: _authCubit.website,
                        certificate: _authCubit.certificateImage!,
                        longitudeService: _authCubit.isCurrent
                            ? _authCubit.currentLocation!.latitude.toString()
                            : _authCubit.selectedLocation!.latitude.toString(),
                        latitudeService: _authCubit.isCurrent
                            ? _authCubit.currentLocation!.longitude.toString()
                            : _authCubit.selectedLocation!.longitude.toString(),
                        images: [
                          _authCubit.firstImage!,
                          _authCubit.secondImage!
                        ]));
                  },

                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      color:  _drawerCubit.themeMode== ThemeMode.dark
                          ? ColorManager.black
                          : ColorManager.white,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void singleDialog(int type, bool hasImage) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _imagePickerOption(
              icon: Icons.camera_alt_outlined,
              label: "Camera",
              onTap: () async {
                final image = await ImageFunctions.CameraPicker();
                if (image != null) {
                  _updateImage(type, image);
                }
                Navigator.pop(context);
              },
            ),
            _imagePickerOption(
              icon: Icons.image,
              label: "Gallery",
              onTap: () async {
                final image = await ImageFunctions.galleryPicker();
                if (image != null) {
                  _updateImage(type, image);
                }
                Navigator.pop(context);
              },
            ),
            if (hasImage)
              _imagePickerOption(
                icon: Icons.delete,
                label: "Delete",
                onTap: () {
                  _deleteImage(type);
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
            icon: Icon(icon, size: 40,                               color: Theme.of(context).primaryColor,
            ),
            onPressed: onTap,
          ),
          Text(label),
        ],
      ),
    );
  }

  void _updateImage(int type, File image) {
    if (type == 1) {
      _authCubit.updateCertificateImage(image);
    } else if (type == 2) {
      _authCubit.updateFirstImage(image);
    } else if (type == 3) {
      _authCubit.updateSecondImage(image);
    }
  }

  void _deleteImage(int type) {
    if (type == 1) {
      _authCubit.updateCertificateImage(null);
    } else if (type == 2) {
      _authCubit.updateFirstImage(_authCubit.secondImage);
      _authCubit.updateSecondImage(null);
    } else if (type == 3) {
      _authCubit.updateSecondImage(null);
    }
  }
}
