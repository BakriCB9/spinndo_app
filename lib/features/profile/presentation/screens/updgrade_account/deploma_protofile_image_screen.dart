import 'dart:io';

import 'package:app/core/constant.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/utils/image_functions.dart';
import 'package:app/features/auth/data/models/upgeade_regiest_service_provider.dart';
import 'package:app/features/auth/presentation/widget/custom_auth_form.dart';
import 'package:app/features/service/presentation/screens/service_screen.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:app/core/di/service_locator.dart';
import 'package:app/core/utils/ui_utils.dart';
import 'package:app/features/auth/data/models/register_service_provider_request.dart';
import 'package:app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:app/features/auth/presentation/cubit/auth_states.dart';
import 'package:app/features/auth/presentation/screens/verfication_code_screen.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeplomaProtofileImageScreen extends StatefulWidget {
  DeplomaProtofileImageScreen({this.authCubit, super.key});
  AuthCubit? authCubit;
  static const String routeName = '/deploma';

  @override
  State<DeplomaProtofileImageScreen> createState() =>
      _DeplomaProtofileImageScreenState();
}

class _DeplomaProtofileImageScreenState
    extends State<DeplomaProtofileImageScreen> {
  // late AuthCubit widget.authCubit!;
  // final widget.authCubit! = serviceLocator.get<AuthCubit>();
  final _drawerCubit = serviceLocator.get<DrawerCubit>();
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final isDarkMode = _drawerCubit.themeMode == ThemeMode.dark;

    return Container(
      decoration: isDarkMode
          ? const BoxDecoration(
          color: ColorManager.darkBg
      ): null,
      child: CustomAuthForm(
        hasAvatar: false, hasTitle: false,
        // floatingActionButton: Padding(
        //   padding: EdgeInsets.only(bottom: 130.h),
        //   child: FloatingActionButton(onPressed: (){},

        //   ),
        // ),
        //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(localization.uploadCertificateImage,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 40.sp)),
              SizedBox(height: 50.h),
              GestureDetector(
                onTap: () =>
                    singleDialog(1, widget.authCubit!.certificateImage != null),
                child: BlocBuilder<AuthCubit, AuthState>(
                  bloc: widget.authCubit,
                  buildWhen: (previous, current) =>
                      current is CertificateImageUpdated,
                  builder: (context, state) {
                    final certificateImage = widget.authCubit!.certificateImage;
                    return Container(
                      width: double.infinity,
                      height: 350.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: certificateImage == null
                          ? Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(localization.uploadYourCertificate,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  Icon(
                                    Icons.upload,
                                    size: 45.sp,
                                  ),
                                ],
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(30.r),
                              child: SingleChildScrollView(
                                child: Image.file(
                                  certificateImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                    );
                  },
                ),
              ),
              BlocBuilder<AuthCubit, AuthState>(
                bloc: widget.authCubit,
                buildWhen: (previous, current) =>
                    current is CertificateImageUpdated,
                builder: (context, state) {
                  return widget.authCubit!.certificateImage == null
                      ? const SizedBox()
                      : Column(
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  "try scroll",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Icon(
                                  Icons.touch_app,
                                  size: 35.sp,
                                ),
                              ],
                            ),
                          ],
                        );
                },
              ),
              SizedBox(height: 50.h),
              Text(localization.uploadProtofileImage,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 40.sp)),
              SizedBox(height: 50.h),

              BlocBuilder<AuthCubit, AuthState>(
                  bloc: widget.authCubit,
                  buildWhen: (previous, current) {
                    if (current is UpdateImageProtofile) {
                      return true;
                    }
                    return false;
                  },
                  builder: (context, state) {
                    return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            widget.authCubit!.listOfFileImagesProtofile.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 3 / 4,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20),
                        itemBuilder: (context, index) {
                          return index ==
                                  widget.authCubit!.listOfFileImagesProtofile
                                          .length -
                                      1
                              ? SizedBox(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () => singleDialog(2, false),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(25.r),
                                                color: Colors.grey
                                                    .withOpacity(0.1),
                                              ),
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                        localization
                                                            .clickToUpload,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall),
                                                    SizedBox(
                                                      width: 20.w,
                                                    ),
                                                    Icon(
                                                      Icons.upload,
                                                      size: 45.sp,
                                                    ),
                                                  ],
                                                ),
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Stack(
                                  // fit: StackFit.passthrough,
                                  alignment: Alignment.topRight,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(25.r),
                                        color: Colors.grey.withOpacity(0.1),
                                      ),
                                      child: AspectRatio(
                                        aspectRatio: 3 / 4,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25.r)),
                                          child: Image(
                                            image: FileImage(
                                              widget.authCubit!
                                                      .listOfFileImagesProtofile[
                                                  index]!,
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
                                            border: Border.all(
                                                color: Colors.grey, width: 2)),
                                        child: Center(
                                            child: InkWell(
                                          onTap: () {
                                            //listOfFileImage.removeAt(index);
                                            widget.authCubit!.deleteImageProtofile(
                                                widget.authCubit!
                                                        .listOfFileImagesProtofile[
                                                    index],
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
                        });
                  }),

              SizedBox(
                height: 20.h,
              ),

              SizedBox(
                height: 30.h,
              ),
              // const Spacer(),
              BlocListener<AuthCubit, AuthState>(
                bloc: widget.authCubit,
                listener: (context, state) {
                  if (state is RegisterServiceLoading) {
                    UIUtils.showLoading(
                        context, 'asset/animation/loading.json');
                  } else if (state is RegisterServiceError) {
                    UIUtils.hideLoading(context);
                    UIUtils.showMessage(state.message);
                  } else if (state is RegisterServiceSuccess) {
                    UIUtils.hideLoading(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.of(context)
                        .pushReplacementNamed(ServiceScreen.routeName);
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 20.h),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final userId = sharedPref.getInt(CacheConstant.userId);

                      if (widget.authCubit!.certificateImage == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                localization.youhavetouploadCertificateimage,
                                style: TextStyle(
                                    fontSize: 28.sp, color: Colors.white)),
                          ),
                        );
                        return;
                      }
                      widget.authCubit!.listOfFileImagesProtofile.removeLast();
                      widget.authCubit!.upgradeAccount(
                          UpgradeRegiestServiceProviderRequest(
                              userId: userId.toString(),
                              websiteService: widget.authCubit!.websiteController
                                      .text.isEmpty
                                  ? null
                                  : widget.authCubit!.websiteController.text,
                              listOfDay: widget.authCubit!.dateSelect,
                              nameService: widget
                                  .authCubit!.serviceNameController.text,
                              descriptionService: widget
                                  .authCubit!.serviceDescriptionController.text,
                              categoryIdService: widget
                                  .authCubit!.selectedCategory!.id
                                  .toString(),
                              cityNameService: widget.authCubit!.cityName!,
                              certificate: widget.authCubit!.certificateImage!,
                              latitudeService: widget
                                      .authCubit!.isCurrent
                                  ? widget.authCubit!.currentLocation!.latitude
                                      .toString()
                                  : widget.authCubit!.selectedLocation!.latitude
                                      .toString(),
                              longitudeService: widget.authCubit!.isCurrent
                                  ? widget.authCubit!.currentLocation!.longitude
                                      .toString()
                                  : widget.authCubit!.selectedLocation!.longitude
                                      .toString(),
                              images:
                                  widget.authCubit!.listOfFileImagesProtofile));
                      // widget.authCubit!.registerService(
                      //     RegisterServiceProviderRequest(
                      //         websiteService: widget
                      //                 .authCubit!.websiteController.text.isEmpty
                      //             ? null
                      //             : widget.authCubit!.websiteController.text,

                      //         listOfDay: widget.authCubit!.dateSelect,

                      //         nameService:
                      //             widget.authCubit!.serviceNameController.text,
                      //         descriptionService: widget
                      //             .authCubit!.serviceDescriptionController.text,
                      //         categoryIdService: widget
                      //             .authCubit!.selectedCategory!.id
                      //             .toString(),
                      //         cityNameService: widget.authCubit!.cityName!,

                      //         certificate: widget.authCubit!.certificateImage!,
                      //         latitudeService: widget.authCubit!.isCurrent
                      //             ? widget.authCubit!.currentLocation!.latitude
                      //                 .toString()
                      //             : widget.authCubit!.selectedLocation!.latitude
                      //                 .toString(),
                      //         longitudeService: widget.authCubit!.isCurrent
                      //             ? widget.authCubit!.currentLocation!.longitude
                      //                 .toString()
                      //             : widget
                      //                 .authCubit!.selectedLocation!.longitude
                      //                 .toString(),
                      //         images:
                      //             widget.authCubit!.listOfFileImagesProtofile));
                    },
                    child: Text(localization.signUp,
                        style: Theme.of(context).textTheme.bodyLarge),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void singleDialog(int type, bool hasImage) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).primaryColorDark,
        content: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _imagePickerOption(
                icon: Icons.camera_alt_outlined,
                label:
                    _drawerCubit.languageCode == "en" ? "Camera" : "الكاميرا",
                onTap: () async {
                  final image = await ImageFunctions.CameraPicker(false);
                  if (image != null) {
                    // _updateImage(type, image);
                    if (type == 1) {
                      widget.authCubit!.updateCertificateImage(image);
                    } else {
                      widget.authCubit!.addImagetoProtofile(image);
                    }
                    //listOfFileImage.add(image);
                    //setState(() {});
                  }
                  Navigator.pop(context);
                },
              ),
              _imagePickerOption(
                icon: Icons.image,
                label: _drawerCubit.languageCode == "en" ? "Gallery" : "المعرض",
                onTap: () async {
                  final image = await ImageFunctions.galleryPicker(false);
                  if (image != null) {
                    //   _updateImage(type, image);
                    if (type == 1) {
                      widget.authCubit!.updateCertificateImage(image);
                    } else {
                      widget.authCubit!.addImagetoProtofile(image);
                    }
                    // listOfFileImage.add(image);
                    // setState(() {});
                  }
                  Navigator.pop(context);
                },
              ),
              if (type == 1 && widget.authCubit!.certificateImage != null)
                _imagePickerOption(
                  icon: Icons.delete,
                  label: _drawerCubit.languageCode == "en" ? "Delete" : "حذف",
                  onTap: () {
                    _deleteImage(type);
                    widget.authCubit!.updateCertificateImage(null);

                    Navigator.pop(context);
                  },
                ),
            ],
          ),
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

  void _updateImage(int type, File image) {
    if (type == 1) {
      //  widget.authCubit!.updateCertificateImage(image);
    } else if (type == 2) {
      //  widget.authCubit!.updateFirstImage(image);
    } else if (type == 3) {
      // widget.authCubit!.updateSecondImage(image);
    }
  }

  void _deleteImage(int type) {
    if (type == 1) {
      widget.authCubit!.updateCertificateImage(null);
    }
  }
}
