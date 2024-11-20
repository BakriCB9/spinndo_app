// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:snipp/core/di/service_locator.dart';
// import 'package:snipp/core/utils/ui_utils.dart';
// import 'package:snipp/features/auth/data/models/register_service_provider_request.dart';
// import 'package:snipp/features/auth/presentation/cubit/service_cubit.dart';
// import 'package:snipp/features/auth/presentation/cubit/service_states.dart';
// import 'package:snipp/features/auth/presentation/screens/verfication_code_screen.dart';
// import 'package:snipp/features/auth/presentation/widget/custom_auth_form.dart';
//
// import '../../../../core/resources/color_manager.dart';
// import '../../../../core/utils/image_functions.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//
// import '../../../drawer/presentation/cubit/drawer_cubit.dart';
//
// class DeplomaProtofileImageScreen extends StatefulWidget {
//   const DeplomaProtofileImageScreen({super.key});
//
//   static const String routeName = '/deploma';
//
//   @override
//   State<DeplomaProtofileImageScreen> createState() =>
//       _DeplomaProtofileImageScreenState();
// }
//
// class _DeplomaProtofileImageScreenState
//     extends State<DeplomaProtofileImageScreen> {
//   final _authCubit = serviceLocator.get<AuthCubit>();
//   final _drawerCubit = serviceLocator.get<DrawerCubit>();
//
//   @override
//   Widget build(BuildContext context) {
//     final localization = AppLocalizations.of(context)!;
//     final style=Theme.of(context).elevatedButtonTheme.style!;
//
//     return CustomAuthForm(
//       hasAvatar: false,
//       hasTitle: false,
//       isGuest: false,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(localization.uploadCertificateImage,
//               style: Theme.of(context)
//                   .textTheme
//                   .titleLarge!
//                   .copyWith(fontFamily: "WorkSans")),
//           SizedBox(
//             height: 20.h,
//           ),
//           GestureDetector(
//               onTap: () {
//                 singleDialog();
//               },
//               child: Container(
//                 width: double.infinity,
//                 height: 350.h,
//                 decoration: BoxDecoration(
//                     color: Colors.grey.withOpacity(0.1),
//                     //border: Border.all(color: Colors.grey, width: 1),
//                     borderRadius: BorderRadius.circular(30.r)),
//                 child: _authCubit.pickedImage == null
//                     ? Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(localization.uploadYourCertificate,
//                                 style: Theme.of(context).textTheme.bodySmall),
//                             Icon(
//                               Icons.upload_file_rounded,
//                               color: Theme.of(context).primaryColor,
//                             )
//                           ],
//                         ),
//                       )
//                     : ClipRRect(
//                         borderRadius: BorderRadius.circular(30.r),
//                         child: Image(
//                           image: FileImage(
//                             _authCubit.pickedImage!,
//                           ),
//                           fit: BoxFit.cover,
//                         )),
//               )),
//           SizedBox(height: 20.h),
//           Text(localization.uploadProtofileImage,
//               style: Theme.of(context)
//                   .textTheme
//                   .titleLarge!
//                   .copyWith(fontFamily: "WorkSans")),
//           SizedBox(height: 40.h),
//           _authCubit.profileImages.isEmpty
//               ? Container(
//                   decoration: BoxDecoration(
//                       color: Colors.grey.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(30.r)),
//                   height: MediaQuery.of(context).size.height * 0.25,
//                   child:  Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text('No Images Add yet ',
//                             style: Theme.of(context).textTheme.bodySmall),
//                         const Icon(Icons.error)
//                       ],
//                     ),
//                   ),
//                 )
//               : Row(
//                   children: _authCubit.profileImages.asMap().entries.map(
//                     (e) {
//                       return SizedBox(
//                         height: MediaQuery.of(context).size.height * 0.15,
//                         child: Stack(
//                           children: [
//                             Container(
//                               margin: EdgeInsets.only(right: 20.w),
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(20.r),
//                                   border: Border.all(color: Colors.grey),
//                                   color: Colors.grey.withOpacity(0.2)),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(20.r),
//                                 child: AspectRatio(
//                                   aspectRatio: 1,
//                                   child: Image(
//                                     image: FileImage(e.value),
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Positioned(
//                                 right: 12,
//                                 bottom:
//                                     -MediaQuery.of(context).size.height * 0.02,
//                                 child: InkWell(
//                                   onTap: () {
//                                     _authCubit.profileImages.removeAt(e.key);
//                                     setState(() {});
//                                   },
//                                   child: Container(
//                                     width: MediaQuery.of(context).size.width *
//                                         0.08,
//                                     height: MediaQuery.of(context).size.height *
//                                         0.08,
//                                     decoration: const BoxDecoration(
//                                         shape: BoxShape.circle,
//                                         color: Colors.white),
//                                     child: const Icon(
//                                       Icons.delete,
//                                       color: Colors.blue,
//                                     ),
//                                   ),
//                                 ))
//                           ],
//                         ),
//                       );
//                     },
//                   ).toList(),
//                 ),
//           SizedBox(height: 20.h),
//           SizedBox(
//             width: double.infinity,
//             child:
//             ElevatedButton(
//               onPressed: _authCubit.profileImages.length >= 2
//                   ? () {
//                 UIUtils.showMessage(
//                     'You Can not upload more than 2 Image');
//               }
//                   : () {
//                 multiDialog();
//               },
//               style:style.copyWith(
//                   backgroundColor:WidgetStateProperty.all( _drawerCubit.themeMode==ThemeMode.light?ColorManager.white:ColorManager.primary)
//               ),
//               child: Text(
//                   localization.uploadImage,
//                   style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: _drawerCubit.themeMode==ThemeMode.light?ColorManager.primary:ColorManager.white )
//
//               ),
//             ),
//
//           ),
//           // const Spacer(),
//           BlocListener<AuthCubit, AuthState>(
//             bloc: _authCubit,
//             listener: (context, state) {
//               if (state is RegisterServiceLoading) {
//                 UIUtils.showLoading(context, 'asset/animation/loading.json');
//               } else if (state is RegisterServiceError) {
//                 UIUtils.hideLoading(context);
//                 UIUtils.showMessage(state.message);
//               } else if (state is RegisterServiceSuccess) {
//                 UIUtils.hideLoading(context);
//                 Navigator.of(context)
//                     .pushNamed(VerficationCodeScreen.routeName);
//               }
//             },
//             child: Container(
//               margin: EdgeInsets.only(bottom: 20.h),
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () async {
//                   _authCubit.registerService(RegisterServiceProviderRequest(
//                       firstName: _authCubit.firstNameContoller.text,
//                       lastName: _authCubit.lastNameContoller.text,
//                       email: _authCubit.emailController.text,
//                       listOfDay: _authCubit.dateSelect,
//                       password: _authCubit.passwordController.text,
//                       nameService: _authCubit.serviceNameController.text,
//                       descriptionService:
//                           _authCubit.serviceDescriptionController.text,
//                       categoryIdService: _authCubit.categoryId,
//                       cityIdService: _authCubit.cityId,
//                       websiteService: _authCubit.website,
//                       certificate: _authCubit.pickedImage!,
//                       longitudeService: "-122.4194",
//                       latitudeService: "37.7749",
//                       images: _authCubit.profileImages));
//                 },
//                 child: Text(
//                  localization.signUp,
//
//                     style: Theme.of(context).textTheme.bodyLarge,
//
//
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   singleDialog() {
//     showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//               content: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(
//                           onPressed: () async {
//                             File? temp = await ImageFunctions.CameraPicker();
//                             if (temp != null) {
//                               _authCubit.pickedImage = temp;
//                             }
//                             Navigator.pop(context);
//                             setState(() {});
//                           },
//                           icon: const Icon(
//                             Icons.camera_alt_outlined,
//                             size: 40,
//                             color: Colors.blue,
//                           )),
//                       SizedBox(
//                         height: 3.h,
//                       ),
//                       const Text("camera")
//                     ],
//                   ),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(
//                           onPressed: () async {
//                             File? temp = await ImageFunctions.galleryPicker();
//                             if (temp != null) {
//                               _authCubit.pickedImage = temp;
//                             }
//                             Navigator.pop(context);
//
//                             setState(() {});
//                           },
//                           icon: const Icon(
//                             Icons.camera_alt_outlined,
//                             size: 40,
//                             color: Colors.blue,
//                           )),
//                       SizedBox(
//                         height: 3.h,
//                       ),
//                       const Text("gallery"),
//                     ],
//                   ),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(
//                           onPressed: () {
//                             _authCubit.pickedImage = null;
//
//                             Navigator.of(context).pop();
//                             setState(() {});
//                           },
//                           icon: const Icon(
//                             Icons.delete,
//                             color: Colors.blue,
//                             size: 40,
//                           )),
//                       const Text('Delete')
//                     ],
//                   )
//                 ],
//               ),
//             ));
//   }
//
//   multiDialog() {
//     showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//               content: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(
//                           onPressed: () async {
//                             File? temp = await ImageFunctions.CameraPicker();
//                             if (temp != null) {
//                               _authCubit.profileImages.add(temp);
//                             }
//                             Navigator.pop(context);
//                             setState(() {});
//                           },
//                           icon: const Icon(
//                             Icons.camera_alt_outlined,
//                             size: 40,
//                             color: Colors.blue,
//                           )),
//                       SizedBox(
//                         height: 3.h,
//                       ),
//                       const Text("camera")
//                     ],
//                   ),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(
//                           onPressed: () async {
//                             List<File>? temps =
//                                 await ImageFunctions.galleryImagesPicker();
//                             if (temps != null) {
//                               _authCubit.profileImages = temps;
//                             }
//                             Navigator.pop(context);
//
//                             setState(() {});
//                           },
//                           icon: const Icon(
//                             Icons.camera_alt_outlined,
//                             size: 40,
//                             color: Colors.blue,
//                           )),
//                       SizedBox(
//                         height: 3.h,
//                       ),
//                       const Text("gallery")
//                     ],
//                   ),
//                 ],
//               ),
//             ));
//   }
// }
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:snipp/core/di/service_locator.dart';
import 'package:snipp/core/utils/ui_utils.dart';
import 'package:snipp/features/auth/data/models/register_service_provider_request.dart';
import 'package:snipp/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:snipp/features/auth/presentation/cubit/auth_states.dart';
import 'package:snipp/features/auth/presentation/screens/verfication_code_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F8FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF0F8FF),
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
                  fontFamily: "WorkSans"),
            ),
            SizedBox(
              height: 20.h,
            ),
            GestureDetector(
                onTap: () {
                  singleDialog();
                },
                child: Container(
                  width: double.infinity,
                  height: 350.h,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      //border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(30.r)),
                  child: _authCubit.pickedImage == null
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Upload your Certificate',
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 35.sp),
                              ),
                              const Icon(
                                Icons.upload_file_rounded,
                                color: Colors.blue,
                              )
                            ],
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(30.r),
                          child: Image(
                            image: FileImage(
                              _authCubit.pickedImage!,
                            ),
                            fit: BoxFit.cover,
                          )),
                )),
            SizedBox(height: 50.h),
            Text(
              "Upload Protofile Image",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35.sp,
                  fontFamily: "WorkSans"),
            ),
            SizedBox(height: 20.h),
            _authCubit.profileImages.isEmpty
                ? Container(
                    decoration: BoxDecoration(
                        //color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(30.r)),
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: const Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text('No Images Add yet'), Icon(Icons.error)],
                    )))
                : SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Row(
                      children:
                          _authCubit.profileImages.asMap().entries.map((e) {
                        return Expanded(
                            child: Row(children: [
                          AspectRatio(
                            aspectRatio: 1,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30.r),
                              child: Image(
                                image: FileImage(e.value),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          e.key == 0
                              ? SizedBox(
                                  width: 10.w,
                                )
                              : const SizedBox()
                        ]));
                      }).toList(),
                    )),

            SizedBox(height: 10.h),
            Center(
              child: TextButton(
                  onPressed: _authCubit.profileImages.length == 2
                      ? () {
                          UIUtils.showMessage(
                              'You Can not upload more than 2 Image');
                        }
                      : () {
                          multiDialog();
                        },
                  child: Text(
                    'Upload Image',
                    style: TextStyle(fontSize: 30.sp, color: Colors.blue),
                  )),
            ),
            // Wrap(
            //   direction: Axis.horizontal,
            //   spacing: 10,
            //   children:
            //       List.generate(_authCubit.profileImages.length + 1, (index) {
            //     return GestureDetector(
            //       onTap: index == _authCubit.profileImages.length
            //           ? multiDialog
            //           : null,
            //       child: Container(
            //         width: 150.w,
            //         height: 150.h,
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(10),
            //           border: Border.all(color: Colors.blue, width: 1.5),
            //         ),
            //         child: index == _authCubit.profileImages.length
            //             ? Center(
            //                 child:
            //                     Icon(Icons.add_a_photo, color: Colors.blue))
            //             : ClipRRect(
            //                 borderRadius: BorderRadius.circular(10),
            //                 child: Image.file(
            //                     _authCubit.profileImages[index]!,
            //                     fit: BoxFit.cover),
            //               ),
            //       ),
            //     );
            //   }),
            // ),
            //SizedBox(height: 30.h),
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
                  onPressed: () async {
                    _authCubit.registerService(RegisterServiceProviderRequest(
                        firstName: _authCubit.firstNameContoller.text,
                        lastName: _authCubit.lastNameContoller.text,
                        email: _authCubit.emailController.text,
                        listOfDay: _authCubit.dateSelect,
                        password: _authCubit.passwordController.text,
                        nameService: _authCubit.serviceNameController.text,
                        descriptionService:
                            _authCubit.serviceDescriptionController.text,
                        categoryIdService: _authCubit.categoryId,
                        cityIdService: _authCubit.cityId,
                        websiteService: _authCubit.website,
                        certificate: _authCubit.pickedImage!,
                        longitudeService: _authCubit.lang.toString(),
                        latitudeService: _authCubit.lat.toString(),
                        images: _authCubit.profileImages));
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          const WidgetStatePropertyAll(Colors.blue),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r))),
                      padding: WidgetStatePropertyAll(
                          EdgeInsets.symmetric(vertical: 12.h))),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  singleDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () async {
                            File? temp = await ImageFunctions.CameraPicker();
                            if (temp != null) {
                              _authCubit.pickedImage = temp;
                            }
                            Navigator.pop(context);
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.camera_alt_outlined,
                            size: 40,
                            color: Colors.blue,
                          )),
                      SizedBox(
                        height: 3.h,
                      ),
                      const Text("camera")
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () async {
                            File? temp = await ImageFunctions.galleryPicker();
                            if (temp != null) {
                              _authCubit.pickedImage = temp;
                            }
                            Navigator.pop(context);

                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.camera_alt_outlined,
                            size: 40,
                            color: Colors.blue,
                          )),
                      SizedBox(
                        height: 3.h,
                      ),
                      const Text("gallery"),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            _authCubit.pickedImage = null;

                            Navigator.of(context).pop();
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.blue,
                            size: 40,
                          )),
                      const Text('Delete')
                    ],
                  )
                ],
              ),
            ));
  }

  multiDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () async {
                            File? temp = await ImageFunctions.CameraPicker();
                            if (temp != null) {
                              _authCubit.profileImages.add(temp);
                            }
                            Navigator.pop(context);
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.camera_alt_outlined,
                            size: 40,
                            color: Colors.blue,
                          )),
                      SizedBox(
                        height: 3.h,
                      ),
                      const Text("camera")
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () async {
                            //final list=multiImage();

                            List<File>? temps =
                                await ImageFunctions.galleryImagesPicker();
                            if (temps != null) {
                              if (_authCubit.profileImages.length == 1) {
                                _authCubit.profileImages.add(temps[0]);
                              } else {
                                _authCubit.profileImages.clear();
                                _authCubit.profileImages.addAll(temps);
                              }
                            }
                            Navigator.pop(context);

                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.image,
                            size: 40,
                            color: Colors.blue,
                          )),
                      SizedBox(
                        height: 3.h,
                      ),
                      const Text("gallery")
                    ],
                  ),
                ],
              ),
            ));
  }
}
