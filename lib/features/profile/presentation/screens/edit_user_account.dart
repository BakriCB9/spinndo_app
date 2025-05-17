import 'dart:convert';
import 'dart:io';

import 'package:app/core/constant.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/utils/image_functions.dart';
import 'package:app/core/utils/ui_utils.dart';
import 'package:app/core/widgets/cash_network.dart';
import 'package:app/core/widgets/loading_indicator.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:app/features/profile/data/models/client_update/update_account_profile.dart';
import 'package:app/features/profile/data/models/provider_update/update_provider_request.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:app/features/profile/presentation/cubit/profile_states.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditUserAccountScreen extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String firstNameAr;
  final String lastNameAr;
  final String typeAccount;
  final String email;
  final String phone;

  const EditUserAccountScreen({required this.firstName,
    required this.firstNameAr,
    required this.lastNameAr,
    required this.lastName,
    required this.typeAccount,
    required this.email,
    required this.phone,
    super.key,});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final imagePhoto = sharedPref.getString(CacheConstant.imagePhotoFromLogin);
    final _profileCubit = serviceLocator.get<ProfileCubit>();
    _profileCubit.firstNameEditController.text = firstName;
    _profileCubit.lastNameEditController.text = lastName;
    _profileCubit.firstNameArEditController.text = firstNameAr;
    _profileCubit.lastNameArEditController.text = lastNameAr;
    _profileCubit.emailEditController.text = email;
    _profileCubit.phoneEditController.text = phone;
    final _drawerCubit = serviceLocator.get<DrawerCubit>();

    //  final base64String =sharedPref.getString(CacheConstant.imagePhoto);
    //   if(base64String!=null){
    //     final bytes = base64Decode(base64String);
    //   }

    print('the Image from local is ');
    return Container(
      decoration: _drawerCubit.themeMode == ThemeMode.dark
          ? BoxDecoration(
          image: DecorationImage(
              image: AssetImage("asset/images/bg.png"), fit: BoxFit.fill))
          : null,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 15.h),
                // Align(
                //   alignment: Alignment.center,
                //   child: Stack(
                //     alignment: Alignment.center,
                //     children: [
                //       Positioned(
                //         child: Container(
                //             //radius: 150.r,
                //             //backgroundColor: Colors.grey,
                //             width: 300.w,
                //             height: 300.h,
                //             decoration: BoxDecoration(
                //               shape: BoxShape.circle,
                //               color: Colors.grey,
                //             ),
                //             child: BlocConsumer<ProfileCubit, ProfileStates>(
                //                 listener: (context, state) {
                //                   if (state is LoadImagePhotoError) {
                //                     UIUtils.showMessage(state.message);
                //                   }
                //                   if (state is LoadImagePhotoSuccess) {
                //                     UIUtils.showMessage(state.message);
                //                     _profileCubit.getUserRole();
                //                   }
                //                 },
                //                 buildWhen: (pre, cur) {
                //                   if (cur is LoadImagePhotoLoading ||
                //                       cur is LoadImagePhotoSuccess ||
                //                       cur is LoadImagePhotoError) {
                //                     return true;
                //                   }
                //                   return false;
                //                 },
                //                 bloc: _profileCubit,
                //                 builder: (context, state) {
                //                   if (state is LoadImagePhotoLoading) {
                //                     return LoadingIndicator(Colors.yellow);
                //                   } else if (state is LoadImagePhotoError) {
                //                     return imagePhoto == null
                //                         ? Icon(
                //                             Icons.person,
                //                             size: 150.r,
                //                             color: Colors.white,
                //                           )
                //                         : ClipRRect(
                //                             child: CashImage(path: imagePhoto),
                //                           );
                //                   } else if (state is LoadImagePhotoSuccess) {
                //                     Uint8List? bytes;
                //                     final base64String = sharedPref
                //                         .getString(CacheConstant.imagePhoto);

                //                     if (base64String != null &&
                //                         base64String.isNotEmpty) {
                //                       bytes = base64Decode(base64String);
                //                       print(
                //                           'the image is ##############################################  $bytes');
                //                     }
                //                     return base64String == null
                //                         ? Icon(
                //                             Icons.person,
                //                             size: 150.r,
                //                             color: Colors.white,
                //                           )
                //                         : ClipRRect(
                //                             borderRadius:
                //                                 BorderRadius.circular(150.r),
                //                             child: Image.memory(
                //                               bytes!,
                //                               fit: BoxFit.cover,
                //                             ),
                //                           );
                //                   } else {
                //                     Uint8List? bytes;
                //                     final base64String = sharedPref
                //                         .getString(CacheConstant.imagePhoto);
                //                     if (base64String != null &&
                //                         base64String.isNotEmpty) {
                //                       bytes = base64Decode(base64String);
                //                       print(
                //                           'the image is ##############################################  $bytes');
                //                     }
                //                     return base64String == null
                //                         ? (imagePhoto == null
                //                             ? Icon(
                //                                 Icons.person,
                //                                 size: 150.r,
                //                                 color: Colors.white,
                //                               )
                //                             : ClipRRect(
                //                                 borderRadius:
                //                                     BorderRadius.circular(
                //                                         300.r),
                //                                 child: CashImage(
                //                                     path: imagePhoto)))
                //                         : ClipRRect(
                //                             borderRadius:
                //                                 BorderRadius.circular(150.r),
                //                             child: Image.memory(
                //                               bytes!,
                //                               fit: BoxFit.cover,
                //                             ),
                //                           );
                //                   }
                //                 })),
                //       ),
                //       Positioned(
                //         bottom: 10,
                //         right: 10.w,
                //         child: GestureDetector(
                //           onTap: () {
                //             showModalBottomSheet(
                //                 backgroundColor:
                //                     Theme.of(context).primaryColorDark,
                //                 context: context,
                //                 builder: (context) {
                //                   return SafeArea(
                //                       child: Padding(
                //                     padding:
                //                         EdgeInsets.symmetric(horizontal: 30.w),
                //                     child: Column(
                //                       mainAxisSize: MainAxisSize.min,
                //                       children: [
                //                         Row(
                //                           children: [
                //                             Expanded(
                //                               child: Center(
                //                                 child: Text(
                //                                     localization.profilePhoto),
                //                               ),
                //                             ),
                //                             IconButton(
                //                               icon: Icon(Icons.delete),
                //                               onPressed: () {},
                //                             ),
                //                           ],
                //                         ),
                //                         SizedBox(
                //                           height: 30.h,
                //                         ),
                //                         Row(
                //                           children: [
                //                             Column(
                //                               children: [
                //                                 GestureDetector(
                //                                   onTap: () async {
                //                                     Navigator.of(context).pop();
                //                                     final image =
                //                                         await ImageFunctions
                //                                             .CameraPicker(true);
                //                                     if (image == null) {
                //                                       return;
                //                                     }
                //                                     _profileCubit
                //                                         .addImagePhoto(image);
                //                                   },
                //                                   child: Container(
                //                                     width: 100.w,
                //                                     height: 100.h,
                //                                     decoration: BoxDecoration(
                //                                         shape: BoxShape.circle,
                //                                         border: Border.all(
                //                                             color:
                //                                                 Colors.grey)),
                //                                     child: Icon(
                //                                       Icons.camera_alt_outlined,
                //                                       color:
                //                                           ColorManager.primary,
                //                                     ),
                //                                   ),
                //                                 ),
                //                                 SizedBox(height: 15.h),
                //                                 Text(
                //                                   'Camera',
                //                                   style: Theme.of(context)
                //                                       .textTheme
                //                                       .titleLarge!
                //                                       .copyWith(
                //                                           fontSize: 25.sp),
                //                                 )
                //                               ],
                //                             ),
                //                             SizedBox(
                //                               width: 35.w,
                //                             ),
                //                             Column(
                //                               children: [
                //                                 GestureDetector(
                //                                   onTap: () async {
                //                                     Navigator.of(context).pop();
                //                                     final image =
                //                                         await ImageFunctions
                //                                             .galleryPicker(
                //                                                 true);
                //                                     if (image == null) {
                //                                       return;
                //                                     }
                //                                     _profileCubit
                //                                         .addImagePhoto(image);
                //                                   },
                //                                   child: Container(
                //                                     width: 100.w,
                //                                     height: 100.h,
                //                                     decoration: BoxDecoration(
                //                                         shape: BoxShape.circle,
                //                                         border: Border.all(
                //                                             color:
                //                                                 Colors.grey)),
                //                                     child: Icon(
                //                                       Icons.image_outlined,
                //                                       color:
                //                                           ColorManager.primary,
                //                                     ),
                //                                   ),
                //                                 ),
                //                                 SizedBox(height: 15.h),
                //                                 Text(
                //                                   'Gallery',
                //                                   style: Theme.of(context)
                //                                       .textTheme
                //                                       .titleLarge!
                //                                       .copyWith(
                //                                           fontSize: 25.sp),
                //                                 )
                //                               ],
                //                             ),
                //                           ],
                //                         ),
                //                         SizedBox(
                //                           height: 50.h,
                //                         )
                //                       ],
                //                     ),
                //                   ));
                //                 });
                //           },
                //           child: Container(
                //             width: 80.r,
                //             height: 80.r,
                //             decoration: const BoxDecoration(
                //               color: ColorManager.primary,
                //               shape: BoxShape.circle,
                //             ),
                //             child: Icon(
                //               Icons.camera_alt,
                //               color: Theme.of(context).primaryColorLight,
                //               size: 50.r,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                // CustomTextFromFieldBakri(
                //   icon: Icons.person_2_outlined,
                //   label: 'First Name',
                //   initialvalue: 'Bakri',
                // ),
                //  CustomTextFormField( labelText: 'FirstName',controller: _profileCubit.firstNameEditController,initValue: 'bakri',icon: Icons.person,),
                // SizedBox(height: 40.h),
                // CustomTextFormField( labelText: 'Last Name',controller: _profileCubit.lastNameEditController,initValue: 'aweja',icon: Icons.person,),
                // SizedBox(height: 40.h),

                // CustomTextFromFieldBakri(
                //   icon: Icons.person_2_outlined,
                //   label: 'Last Name',
                //   initialvalue: 'aweja',
                // ),
                // CustomTextFormField(labelText: 'Email', controller: _profileCubit.emailEditController,initValue: 'bakkaraweja@gmail.com',icon: Icons.email,),
                // SizedBox(height: 40.h),
                // CustomTextFromFieldBakri(
                //   icon: Icons.email_outlined,
                //   label: 'Email',
                //   initialvalue: 'bakriaweja@gmail.com',
                // ),
                // SizedBox(height: 40.h),
                // CustomTextFromFieldBakri(
                //   icon: Icons.phone,
                //   label: 'Phone',
                //   initialvalue: '0959280119',
                // ),

                SizedBox(
                  height: 70.h,
                ),
                TextFormField(
                  controller: _profileCubit.firstNameArEditController,
                  style: TextStyle(
                      color: _drawerCubit.themeMode == ThemeMode.light
                          ? Colors.black
                          : Colors.white,
                      fontSize: 25.sp),
                  cursorColor: ColorManager.primary,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.done,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(200),
                  ],
                  decoration: InputDecoration(
                    label: Text(
                      localization.firstNameAr,
                    ),
                    prefixIcon: Icon(
                      Icons.person,
                      size: 45.sp,
                    ),
                    // counter: SizedBox()
                  ),
                  onChanged: (value) {
                    print('');
                    _profileCubit.updateInfo(
                      curFirst: firstName,
                      curFirstAr: firstNameAr,
                      newFirstAr:
                      _profileCubit.firstNameArEditController.text,
                      curLastAr: lastNameAr,
                      newLastAr: _profileCubit.lastNameArEditController.text,
                      newFirst: _profileCubit.firstNameEditController.text,
                      curLast: lastName,
                      newLast: _profileCubit.lastNameEditController.text,
                      curEmail: email,
                      newEmail: _profileCubit.emailEditController.text,
                    );
                  },
                ),
                SizedBox(
                  height: 50.h,
                ),
                TextFormField(
                  controller: _profileCubit.lastNameArEditController,
                  style: TextStyle(
                      color: _drawerCubit.themeMode == ThemeMode.light
                          ? Colors.black
                          : Colors.white,
                      fontSize: 25.sp),
                  cursorColor: ColorManager.primary,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.done,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(200),
                  ],
                  decoration: InputDecoration(
                    label: Text(
                      localization.lastNameAr,
                    ),
                    prefixIcon: Icon(
                      Icons.person,
                      size: 45.sp,
                    ),
                    // counter: SizedBox()
                  ),
                  onChanged: (value) {
                    print('');
                    _profileCubit.updateInfo(
                      curFirst: firstName,
                      curFirstAr: firstNameAr,
                      newFirstAr: _profileCubit.firstNameArEditController.text,
                      curLastAr: lastNameAr,
                      newLastAr: _profileCubit.lastNameArEditController.text,
                      newFirst: _profileCubit.firstNameEditController.text,
                      curLast: lastName,
                      newLast: _profileCubit.lastNameEditController.text,
                      curEmail: email,
                      newEmail: _profileCubit.emailEditController.text,
                    );
                  },
                ),
                SizedBox(
                  height: 50.h,
                ),
                TextFormField(
                  controller: _profileCubit.firstNameEditController,
                  style: TextStyle(
                      color: _drawerCubit.themeMode == ThemeMode.light
                          ? Colors.black
                          : Colors.white,
                      fontSize: 25.sp),
                  cursorColor: ColorManager.primary,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.done,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(200),
                  ],
                  decoration: InputDecoration(
                    label: Text(
                      localization.firstName,
                    ),
                    prefixIcon: Icon(
                      Icons.person,
                      size: 45.sp,
                    ),
                    // counter: SizedBox()
                  ),
                  onChanged: (value) {
                    print('');
                    _profileCubit.updateInfo(
                        curFirst: firstName,
                        curFirstAr: firstNameAr,
                        newFirstAr: _profileCubit.firstNameArEditController.text,
                        curLastAr: lastNameAr,
                        newLastAr: _profileCubit.lastNameArEditController.text,
                        newFirst: _profileCubit.firstNameEditController.text,
                        curLast: lastName,
                        newLast: _profileCubit.lastNameEditController.text,
                      curEmail: email,
                      newEmail: _profileCubit.emailEditController.text,
                    );
                  },
                ),
                SizedBox(
                  height: 50.h,
                ),
                TextFormField(
                  controller: _profileCubit.lastNameEditController,
                  onChanged: (value) {
                    _profileCubit.updateInfo(
                      curFirst: firstName,
                      curFirstAr: firstNameAr,
                      newFirstAr: _profileCubit.firstNameArEditController.text,
                      curLastAr: lastNameAr,
                      newLastAr: _profileCubit.lastNameArEditController.text,
                      newFirst: _profileCubit.firstNameEditController.text,
                      curLast: lastName,
                      newLast: _profileCubit.lastNameEditController.text,
                      curEmail: email,
                      newEmail: _profileCubit.emailEditController.text,
                    );
                  },
                  style: TextStyle(
                    color: _drawerCubit.themeMode == ThemeMode.light
                        ? Colors.black
                        : Colors.white,
                    fontSize: 25.sp,
                  ),
                  cursorColor: ColorManager.primary,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(100),
                  ],
                  decoration: InputDecoration(
                    label: Text(localization.email),
                    prefixIcon: Icon(
                      Icons.person,
                      size: 45.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                TextFormField(
                  controller: _profileCubit.emailEditController,
                  onChanged: (value) {
                    _profileCubit.updateInfo(
                      curFirst: firstName,
                      curFirstAr: firstNameAr,
                      newFirstAr: _profileCubit.firstNameArEditController.text,
                      curLastAr: lastNameAr,
                      newLastAr: _profileCubit.lastNameArEditController.text,
                      newFirst: _profileCubit.firstNameEditController.text,
                      curLast: lastName,
                      newLast: _profileCubit.lastNameEditController.text,
                      curEmail: email,
                      newEmail: _profileCubit.emailEditController.text,
                    );
                  },
                  style: TextStyle(
                      color: _drawerCubit.themeMode == ThemeMode.light
                          ? Colors.black
                          : Colors.white,
                      fontSize: 25.sp),
                  cursorColor: ColorManager.primary,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.emailAddress,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(200),
                  ],
                  decoration: InputDecoration(
                    label: Text(
                      localization.email,
                    ),
                    prefixIcon: Icon(
                      Icons.email,
                      size: 45.sp,
                    ),
                    // counter: SizedBox()
                  ),
                ),
                SizedBox(height: 30.h),
                BlocBuilder<ProfileCubit, ProfileStates>(buildWhen: (pre, cur) {
                  if (cur is IsUpdated || cur is IsNotUpdated) return true;
                  return false;
                }, builder: (context, state) {
                  print('the State is ${state}');

                  if (state is IsUpdated) {
                    return BlocListener<ProfileCubit, ProfileStates>(
                      listenWhen: (pre, cur) {
                        if (cur is UpdateLoading ||
                            cur is UpdateError ||
                            cur is UpdateSuccess) {
                          return true;
                        }
                        return false;
                      },
                      listener: (context, state) {
                        if (state is UpdateLoading) {
                          UIUtils.showLoading(context);
                        } else if (state is UpdateError) {
                          UIUtils.hideLoading(context);
                          UIUtils.showMessage(state.message);
                        } else if (state is UpdateSuccess) {
                          UIUtils.hideLoading(context);
                          Navigator.of(context).pop(true);
                          _profileCubit.getUserRole();
                        }
                      },
                      child: ElevatedButton(
                          onPressed: () {
                            if (_profileCubit
                                .firstNameEditController.text.isEmpty ||
                                _profileCubit
                                    .firstNameArEditController.text.isEmpty ||
                                _profileCubit
                                    .lastNameArEditController.text.isEmpty ||
                                _profileCubit
                                    .lastNameEditController.text.isEmpty||
                                _profileCubit
                                    .emailEditController.text.isEmpty
                            ) {
                              return UIUtils.showMessage(
                                  'Enter the name the field is Empty');
                            }
                            if (typeAccount == 'Client') {
                              _profileCubit.updateClientProfile(
                                  UpdateAccountProfile(
                                      firstNameAr: _profileCubit
                                          .firstNameArEditController.text,
                                      lastNameAr: _profileCubit
                                          .lastNameArEditController.text,
                                      firstName: _profileCubit
                                          .firstNameEditController.text,
                                      lastName: _profileCubit
                                          .lastNameEditController.text,
                                      email: _profileCubit
                                          .emailEditController.text));
                            } else {
                              _profileCubit.updateProviderProfile(
                                  UpdateProviderRequest(
                                      firstNameAr: _profileCubit
                                          .firstNameArEditController.text,
                                      lastNameAr: _profileCubit
                                          .lastNameArEditController.text,
                                    firstName: _profileCubit
                                        .firstNameEditController.text,
                                    lastName: _profileCubit
                                        .lastNameEditController.text,
                                    email:_profileCubit.emailEditController.text
                                  ),
                                  1);
                            }
                          },
                          child: Text(localization.save)),
                    );
                  } else {
                    return const SizedBox();
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ProfileScreen(),
//     );
//   }
// }
// class ProfileScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     double avatarRadius = MediaQuery.of(context).size.width * 0.3;
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             CircleAvatar(
//               radius: avatarRadius,
//               backgroundColor: Colors.grey,
//               child: Icon(
//                 Icons.person,
//                 size: avatarRadius,
//                 color: Colors.white,
//               ),
//             ),
//             Positioned(
//               bottom: 30,
//               right: 30,
//               child: Container(
//                 width: avatarRadius * 0.3,
//                 height: avatarRadius * 0.3,
//                 decoration: BoxDecoration(
//                   color: Colors.green,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   Icons.camera_alt,
//                   color: Colors.black,
//                   size: avatarRadius * 0.15,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// SizedBox(
//                 width: double.infinity,
//                 height: size.height * 0.28,
//                 child: Stack(
//                   alignment: Alignment.center,
//                   //fit: StackFit.expand,
//                   children: [
//                     Positioned(
//                       top: size.width / 300,
//                       child: Container(
//                         width: size.width / 2,
//                         height: size.height / 4,
//                         decoration: const BoxDecoration(
//                             shape: BoxShape.circle, color: Colors.grey),
//                       ),
//                     ),
//                     Positioned(
//                         top: size.height / 5.5,
//                         right: size.width / 3.5,
//                         child: Container(
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.red,
//                           ),
//                           width: size.width * 0.12,
//                           height: size.height * 0.06,
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 20.w, vertical: 20.h),
//                         ))
//                   ],
//                 ),
