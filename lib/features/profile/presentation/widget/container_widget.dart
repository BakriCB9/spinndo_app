// import 'dart:io';
// import 'package:app/core/constant.dart';
// import 'package:app/core/di/service_locator.dart';
// import 'package:app/core/resources/color_manager.dart';
// import 'package:app/core/utils/ui_utils.dart';
// import 'package:app/core/widgets/cash_network.dart';
// import 'package:app/features/profile/presentation/cubit/profile_cubit.dart';
// import 'package:app/features/profile/presentation/cubit/profile_states.dart';
// import 'package:app/main.dart';
// import 'package:flutter/material.dart';

// import 'package:flutter_bloc/flutter_bloc.dart';

// class CustomContainer extends StatelessWidget {
//   final String? initialImage;
//   final double? width;
//   final BoxShape shape;
//   final int theId;
//   const CustomContainer({
//     required this.shape,
//     this.width,
//     required this.initialImage,
//     super.key,
//     required this.theId,
//   });

//   // String? _currentImage;
//   @override
//   Widget build(BuildContext context) {
    
//     final imagePhotoLogin =
//         sharedPref.getString(CacheConstant.imagePhotoFromLogin);
//     final imagePhotoGallery = sharedPref.getString(CacheConstant.imagePhoto);
//     final myId = sharedPref.getInt(CacheConstant.userId);
//     return Stack(
//       // fit: StackFit.expand,
//       children: [
//         Container(
//           width: width,
//           height: width, // Match height to width for circles
//           decoration: BoxDecoration(
//             shape: shape,
//           ),
//           //clipBehavior: Clip.antiAlias,
//           child: theId != myId
//               ? initialImage != null
//                   ? CashImage(path: initialImage!)
//                   :
//                   // const  SizedBox()
//                   // SizedBox(
//                   //     height: width ?? 100,
//                   //     width: double.infinity,
//                   //     child: Image.asset(
//                   //       'asset/images/aaaa.png',
//                   //       fit: BoxFit.cover,
//                   //     ),
//                   //   )
//                   Image(
//                       //height: width ?? 100,
//                       //width: double.infinity,
//                       image: AssetImage('asset/images/aaaa.png'),
//                       fit: BoxFit.cover,
//                     )
//               : BlocConsumer<ProfileCubit, ProfileStates>(
//                   listener: (context, state) {
//                     print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
//                     print(initialImage);
//                     if (state is LoadImagePhotoError) {
//                       UIUtils.showMessage(state.message);
//                     }
//                   },
//                   buildWhen: (pre, cur) {
//                     if (cur is LoadImagePhotoLoading ||
//                         cur is LoadImagePhotoError ||
//                         cur is LoadImagePhotoSuccess) {
//                       return true;
//                     }
//                     return false;
//                   },
//                   bloc: serviceLocator.get<ProfileCubit>(),
//                   builder: (context, state) {
//                     final ans = sharedPref.getString('imageFile');

//                     if (state is LoadImagePhotoLoading) {
//                       return const Center(
//                         child: CircularProgressIndicator(
//                           color: ColorManager.white,
//                         ),
//                       );
//                     }
//                     return imagePhotoGallery == null
//                         ? imagePhotoLogin == null
//                             ? Image.asset(
//                                 'asset/images/aaaa.png',
//                                 fit: BoxFit.cover,
//                               )
//                             : CashImage(path: imagePhotoLogin)
//                         : ans != null && imagePhotoGallery.isNotEmpty
//                             ? Builder(builder: (context) {
//                                 print('');
//                                 print(
//                                     ' builderbuilder bulder builder builder builder builder  ');
//                                 print('');
//                                 return Image.file(
//                                   File(ans),
//                                   fit: BoxFit.cover,
//                                 );
//                               })
//                             : const Image(
//                                 image: AssetImage('asset/images/aaaa.png'),
//                                 fit: BoxFit.cover,
//                               );
//                   }),
//         ),
//       ],
//     );
//   }
// }
