import 'dart:io';

import 'package:app/core/resources/color_manager.dart';
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

  // List<File?> listOfFileImagesProtofile = [];
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Container(
      decoration: _drawerCubit.themeMode == ThemeMode.dark
          ? BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("asset/images/bg.png"), fit: BoxFit.fill))
          : null,
      child: Scaffold(
        appBar: AppBar(),
        // floatingActionButton: Padding(
        //   padding: EdgeInsets.only(bottom: 130.h),
        //   child: FloatingActionButton(onPressed: (){},

        //   ),
        // ),
        //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),

                Text(localization.uploadCertificateImage,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 40.sp)),
                SizedBox(height: 50.h),
                GestureDetector(
                  onTap: () =>
                      singleDialog(1, _authCubit.certificateImage != null),
                  child: BlocBuilder<AuthCubit, AuthState>(
                    bloc: _authCubit,
                    buildWhen: (previous, current) =>
                        current is CertificateImageUpdated,
                    builder: (context, state) {
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(localization.uploadYourCertificate,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall),
                                    SizedBox(width: 20.w,),
                                    Icon(
                                      Icons.upload,size: 45.sp,
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
                  bloc: _authCubit,
                  buildWhen: (previous, current) =>
                  current is CertificateImageUpdated,
  builder: (context, state) {

    return   _authCubit.certificateImage == null?SizedBox():   Column(
                  
                  children: [
                    SizedBox(height: 20.h,),
                    
                    Row(
                      children: [
                        Text("try scroll",style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),),
                        SizedBox(width: 10.w,),
                        Icon(Icons.touch_app,size: 35.sp,),
                    
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
                // SizedBox(
                //   height: 350.h,
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: GestureDetector(
                //           onTap: () =>
                //               singleDialog(2, _authCubit.firstImage != null),
                //           child: BlocBuilder<AuthCubit, AuthState>(
                //             bloc: _authCubit,
                //             buildWhen: (previous, current) =>
                //                 current is FirstImageUpdated,
                //             builder: (context, state) {
                //               final firstImage = _authCubit.firstImage;
                //               return Container(
                //                 decoration: BoxDecoration(
                //                   borderRadius: BorderRadius.circular(25.r),
                //                   color: Colors.grey.withOpacity(0.1),
                //                 ),
                //                 child: firstImage == null
                //                     ? Center(
                //                         child: Text(localization.clickToUpload,
                //                             style: Theme.of(context)
                //                                 .textTheme
                //                                 .bodySmall),
                //                       )
                //                     : ClipRRect(
                //                         borderRadius: BorderRadius.circular(25.r),
                //                         child: Image.file(
                //                           firstImage,
                //                           fit: BoxFit.cover,
                //                         ),
                //                       ),
                //               );
                //             },
                //           ),
                //         ),
                //       ),
                //       SizedBox(width: 20.w),
                //       Expanded(
                //         child: GestureDetector(
                //           onTap: () =>
                //               singleDialog(3, _authCubit.secondImage != null),
                //           child: BlocBuilder<AuthCubit, AuthState>(
                //             bloc: _authCubit,
                //             buildWhen: (previous, current) =>
                //                 current is SecondImageUpdated,
                //             builder: (context, state) {
                //               final secondImage = _authCubit.secondImage;
                //               return Container(
                //                 decoration: BoxDecoration(
                //                   borderRadius: BorderRadius.circular(25.r),
                //                   color: Colors.grey.withOpacity(0.1),
                //                 ),
                //                 child: secondImage == null
                //                     ? Center(
                //                         child: Text(localization.clickToUpload,
                //                             style: Theme.of(context)
                //                                 .textTheme
                //                                 .bodySmall),
                //                       )
                //                     : ClipRRect(
                //                         borderRadius: BorderRadius.circular(25.r),
                //                         child: Image.file(
                //                           secondImage,
                //                           fit: BoxFit.cover,
                //                         ),
                //                       ),
                //               );
                //             },
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                BlocBuilder<AuthCubit, AuthState>(
                    bloc: _authCubit,
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
                              _authCubit.listOfFileImagesProtofile.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,childAspectRatio: 3/4,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20),
                          itemBuilder: (context, index) {
                            return index ==
                                    _authCubit
                                            .listOfFileImagesProtofile.length -1
                                ? SizedBox(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () => singleDialog(2, false),
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25.r),
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                ),
                                                child: Center(
                                                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                          localization
                                                              .clickToUpload,
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .bodySmall),
                                                      SizedBox(width: 20.w,),
                                                      Icon(
                                                        Icons.upload,size: 45.sp,
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
                                          BorderRadius.circular(
                                              25.r),
                                          color: Colors.grey
                                              .withOpacity(0.1),
                                        ),
                                        child: AspectRatio(
                                          aspectRatio: 3/4,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(Radius.circular(25.r)),
                                            child: Image(
                                              image: FileImage(
                                                _authCubit
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
                                                  color: Colors.grey,
                                                  width: 2)),
                                          child: Center(
                                              child: InkWell(
                                            onTap: () {
                                              //listOfFileImage.removeAt(index);
                                              _authCubit.deleteImageProtofile(
                                                  _authCubit
                                                          .listOfFileImagesProtofile[
                                                      index],
                                                  index);

                                              // setState(() {});
                                            },
                                            child:  Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                              size:30.sp ,
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
                  bloc: _authCubit,
                  listener: (context, state) {
                    if (state is RegisterServiceLoading) {
                      UIUtils.showLoading(
                          context, 'asset/animation/loading.json');
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
                        print(
                            'the lenght of image is now ${_authCubit.listOfFileImagesProtofile.length} bakkkkkkkkkar ');
                        if (_authCubit.certificateImage == null) {
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
_authCubit.listOfFileImagesProtofile.removeLast();
                        _authCubit.registerService(
                            RegisterServiceProviderRequest(
                                firstName: _authCubit.firstNameContoller.text,
                                lastName: _authCubit.lastNameContoller.text,
                                email: _authCubit.emailController.text,
                                listOfDay: _authCubit.dateSelect,
                                password: _authCubit.passwordController.text,
                                nameService:
                                    _authCubit.serviceNameController.text,
                                descriptionService: _authCubit
                                    .serviceDescriptionController.text,
                                categoryIdService:
                                    _authCubit.selectedCategory!.id.toString(),
                                cityNameService: _authCubit.cityName!,
                                websiteService: _authCubit.website,
                                certificate: _authCubit.certificateImage!,
                                latitudeService:
                                    _authCubit.isCurrent
                                        ? _authCubit.currentLocation!.latitude
                                            .toString()
                                        : _authCubit.selectedLocation!.latitude
                                            .toString(),
                                longitudeService:
                                    _authCubit.isCurrent
                                        ? _authCubit.currentLocation!.longitude
                                            .toString()
                                        : _authCubit.selectedLocation!.longitude
                                            .toString(),
                                images: _authCubit.listOfFileImagesProtofile));
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
                      _authCubit.updateCertificateImage(image);
                    } else {
                      _authCubit.addImagetoProtofile(image);
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
                      _authCubit.updateCertificateImage(image);
                    } else {
                      _authCubit.addImagetoProtofile(image);
                    }
                    // listOfFileImage.add(image);
                    // setState(() {});
                  }
                  Navigator.pop(context);
                },
              ),
              if (type == 1 && _authCubit.certificateImage != null)
                _imagePickerOption(
                  icon: Icons.delete,
                  label: _drawerCubit.languageCode == "en" ? "Delete" : "حذف",
                  onTap: () {
                    _deleteImage(type);
                    _authCubit.updateCertificateImage(null);

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
      //  _authCubit.updateCertificateImage(image);
    } else if (type == 2) {
      //  _authCubit.updateFirstImage(image);
    } else if (type == 3) {
      // _authCubit.updateSecondImage(image);
    }
  }

  void _deleteImage(int type) {
    if (type == 1) {
      _authCubit.updateCertificateImage(null);
    }
  }
}
