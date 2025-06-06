import 'package:app/core/constant.dart';

import 'package:app/core/utils/app_shared_prefrence.dart';

import 'package:app/features/profile/presentation/cubit/profile_cubit.dart';

import 'package:app/features/profile/presentation/widget/section_social_links.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:app/core/di/service_locator.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:app/features/profile/domain/entities/provider_profile/provider_profile.dart';
import 'package:app/features/profile/presentation/widget/profile_info/active_day/custom_day_of_active.dart';
import 'package:app/features/profile/presentation/widget/profile_info/job_items/description.dart';
import 'package:app/features/profile/presentation/widget/profile_info/user_account/user_account.dart';

import 'package:app/features/profile/presentation/widget/sliver_header_widget.dart';

class ProviderProfileScreen extends StatefulWidget {
  final ProviderProfile providerProfile;
  const ProviderProfileScreen({
    required this.providerProfile,
    super.key,
  });

  @override
  State<ProviderProfileScreen> createState() => _ProviderProfileScreenState();
}

class _ProviderProfileScreenState extends State<ProviderProfileScreen> {
  final _profileCubit = serviceLocator.get<ProfileCubit>();
  final _sharedPreferencesUtils = serviceLocator.get<SharedPreferencesUtils>();

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int? myid =
        _sharedPreferencesUtils.getData(key: CacheConstant.userId) as int?;

    _profileCubit.longti = widget.providerProfile.details!.longitude!;
    _profileCubit.city = widget.providerProfile.details?.city;

    final _drawerCubit = serviceLocator.get<DrawerCubit>();
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: _drawerCubit.themeMode == ThemeMode.dark
          ? const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("asset/images/bg.png"), fit: BoxFit.fill))
          : BoxDecoration(
              color: Colors.white.withOpacity(0.1),
            ),
      child: CustomScrollView(
        // controller: _control,
        slivers: [
          SliverPersistentHeader(
            delegate: SliverPersistentDelegate(
                userId: widget.providerProfile.id!,
                size: size,
                image: widget.providerProfile.imagePath,
                myId: myid!),
            pinned: true,
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserAccount(
                    phoneNumber: widget.providerProfile.phoneNumber!,
                    firstNameAr: widget.providerProfile.firstNameAr!,
                    lastNameAr: widget.providerProfile.lastNameAr!,
                    userId: widget.providerProfile.id,
                    typeAccount: 'Provider',
                    isApprovid: widget.providerProfile.details!.isApproved,
                    firstName: widget.providerProfile.firstName!,
                    lastName: widget.providerProfile.lastName!,
                    email: widget.providerProfile.email!,
                  ),
                  SizedBox(height: 15.h),
                  CustomDescription(
                    webSite: widget.providerProfile.details!.website,
                    lat: widget.providerProfile.details!.latitude!,
                    lng: widget.providerProfile.details!.longitude!,
                    cityName:
                        widget.providerProfile.details?.city?.name ?? 'Alep',
                    isApprovid: widget.providerProfile.details!.isApproved,
                    userId: widget.providerProfile.id!,
                    categoryName:
                        widget.providerProfile.details?.category?.name ??
                            "No category",
                    description: widget.providerProfile.details?.description ??
                        "No description",
                    serviceName:
                        widget.providerProfile.details?.name ?? "No emial yet",
                  ),
                  SizedBox(height: 10.h),
                  CustomDayActive(
                    userId: widget.providerProfile.id!,
                    issAprrovid: widget.providerProfile.details!.isApproved,
                    listOfworkday: widget.providerProfile.details!.workingDays!,
                  ),
                  SizedBox(height: 30.h),

                  SectionSocialLinks(
                      profileCubit: _profileCubit,
                      listOfSoicalFromApi: widget.providerProfile.socialLinks,
                      providerId: widget.providerProfile.id!)

                  //TODO:

                  //                   TextEditingController();
                  //               TextEditingController _textSelectUrl =
                  //                   TextEditingController();
                  //               showModalBottomSheet(
                  //                 context: context,
                  //                 isScrollControlled:
                  //                     true, //  Important for keyboard to push content
                  //                 // backgroundColor: ColorManager.white,
                  //                 shape: const RoundedRectangleBorder(
                  //                   borderRadius: BorderRadius.vertical(
                  //                       top: Radius.circular(20)),
                  //                 ),
                  //                 builder: (context) {
                  //                   return Padding(
                  //                     padding: EdgeInsets.only(
                  //                       bottom: MediaQuery.of(context)
                  //                           .viewInsets
                  //                           .bottom, // 👈 Push above keyboard
                  //                     ),
                  //                     child: SingleChildScrollView(
                  //                       padding: const EdgeInsets.symmetric(
                  //                           horizontal: 20, vertical: 20),
                  //                       child: Column(
                  //                         mainAxisSize: MainAxisSize
                  //                             .min, // 👈 Wrap content
                  //                         crossAxisAlignment:
                  //                             CrossAxisAlignment.stretch,
                  //                         children: [
                  //                           DropdownMenu(
                  //                             hintText: 'choose your social',
                  //                             controller: _textSelectedPlatform,
                  //                             dropdownMenuEntries:
                  //                                 listofSocial.map((e) {
                  //                               return DropdownMenuEntry(
                  //                                   value: e, label: e);
                  //                             }).toList(),
                  //                           ),
                  //                           const SizedBox(height: 20),
                  //                           TextFormField(
                  //                             style: Theme.of(context)
                  //                                 .textTheme
                  //                                 .bodyMedium,
                  //                             controller: _textSelectUrl,
                  //                             decoration: const InputDecoration(
                  //                               hintText: "Enter your link",
                  //                               border: OutlineInputBorder(),
                  //                             ),
                  //                           ),
                  //                           const SizedBox(height: 40),
                  //                           BlocListener<ProfileCubit,
                  //                               ProfileStates>(
                  //                             listener: (context, state) {
                  //                               if (state
                  //                                   is AddorUpdateSoicalLinksLoading) {
                  //                                 UIUtils.showLoading(context);
                  //                               } else if (state
                  //                                   is AddorUpdateSoicalLinksError) {
                  //                                 UIUtils.hideLoading(context);
                  //                                 UIUtils.showMessage(
                  //                                     state.message);
                  //                               } else if (state
                  //                                   is AddorUpdateSoicalLinksSuccess) {
                  //                                 UIUtils.hideLoading(context);
                  //                                 Navigator.of(context).pop();
                  //                               }
                  //                             },
                  //                             child: ElevatedButton(
                  //                               onPressed: () {
                  //                                 if (_textSelectUrl.text
                  //                                     .contains(
                  //                                         _textSelectedPlatform
                  //                                             .text)) {
                  //                                   _profileCubit.addOrupdateSoical(
                  //                                       SocialMediaLinksRequest(
                  //                                           platform:
                  //                                               _textSelectedPlatform
                  //                                                   .text,
                  //                                           url: _textSelectUrl
                  //                                               .text));
                  //                                 } else {
                  //                                   UIUtils.showMessage(
                  //                                       'Ther url that enter is not same type of platform');
                  //                                 }
                  //                               },
                  //                               child: const Text('Save'),
                  //                             ),
                  //                           ),
                  //                           const SizedBox(height: 20)
                  //                         ],
                  //                       ),
                  //                     ),
                  //                   );
                  //                 },
                  //               );
                  //             },
                  //             icon: const Icon(Icons.add))
                  //         : const SizedBox(),
                  //   ],
                  // ),
                  // const SizedBox(height: 20),
                  // widget.providerProfile.socialLinks!.isNotEmpty
                  //     ? Column(
                  //         children:
                  //             widget.providerProfile.socialLinks!.map((e) {
                  //           print('the platform of platfrom is ${e!.platform}');
                  //           return Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 e.platform!,
                  //                 style:
                  //                     Theme.of(context).textTheme.labelMedium,
                  //               ),
                  //               const SizedBox(height: 5),
                  //               Row(
                  //                 children: [
                  //                   Expanded(
                  //                       child: SelectableText(e.url!,
                  //                           maxLines: 1)),
                  //                   widget.providerProfile.id == myid
                  //                       ? IconButton(
                  //                           onPressed: () {
                  //                             TextEditingController _text =
                  //                                 TextEditingController();
                  //                             _text.text = e.url!;
                  //                             String platform = e.platform!;
                  //                             showModalBottomSheet(
                  //                                 context: context,
                  //                                 builder: (context) {
                  //                                   return Padding(
                  //                                       padding: EdgeInsets.only(
                  //                                           bottom:
                  //                                               MediaQuery.of(
                  //                                                       context)
                  //                                                   .viewInsets
                  //                                                   .bottom),
                  //                                       child: IntrinsicHeight(
                  //                                         child: Padding(
                  //                                           padding:
                  //                                               const EdgeInsets
                  //                                                   .symmetric(
                  //                                                   horizontal:
                  //                                                       10,
                  //                                                   vertical:
                  //                                                       50),
                  //                                           child: Column(
                  //                                             children: [
                  //                                               TextFormField(
                  //                                                 style: const TextStyle(
                  //                                                     color: Colors
                  //                                                         .black),
                  //                                                 autofocus:
                  //                                                     true,
                  //                                                 controller:
                  //                                                     _text,
                  //                                                 decoration: const InputDecoration(
                  //                                                     enabledBorder: UnderlineInputBorder(
                  //                                                         borderSide: BorderSide(
                  //                                                             color: ColorManager
                  //                                                                 .primary)),
                  //                                                     fillColor:
                  //                                                         Colors
                  //                                                             .transparent,
                  //                                                     focusedBorder:
                  //                                                         UnderlineInputBorder(
                  //                                                             borderSide: BorderSide(color: ColorManager.primary))),
                  //                                               ),
                  //                                               const SizedBox(
                  //                                                   height: 20),
                  //                                               BlocListener<
                  //                                                   ProfileCubit,
                  //                                                   ProfileStates>(
                  //                                                 listener:
                  //                                                     (context,
                  //                                                         state) {
                  //                                                   if (state
                  //                                                       is AddorUpdateSoicalLinksLoading) {
                  //                                                     UIUtils.showLoading(
                  //                                                         context);
                  //                                                   } else if (state
                  //                                                       is AddorUpdateSoicalLinksError) {
                  //                                                     UIUtils.hideLoading(
                  //                                                         context);
                  //                                                     UIUtils.showMessage(
                  //                                                         state
                  //                                                             .message);
                  //                                                   } else if (state
                  //                                                       is AddorUpdateSoicalLinksSuccess) {
                  //                                                     UIUtils.hideLoading(
                  //                                                         context);
                  //                                                     Navigator.of(
                  //                                                             context)
                  //                                                         .pop();
                  //                                                   }
                  //                                                 },
                  //                                                 child:
                  //                                                     ElevatedButton(
                  //                                                         onPressed:
                  //                                                             () {
                  //                                                           if (_text.text.contains(platform)) {
                  //                                                             _profileCubit.addOrupdateSoical(SocialMediaLinksRequest(platform: platform, url: _text.text));
                  //                                                           }
                  //                                                         },
                  //                                                         child:
                  //                                                             const Text('Save')),
                  //                                               ),
                  //                                             ],
                  //                                           ),
                  //                                         ),
                  //                                       ));
                  //                                 });
                  //                           },
                  //                           icon: const Icon(Icons.edit))
                  //                       : const SizedBox(),
                  //                   BlocListener<ProfileCubit, ProfileStates>(
                  //                     listener: (context, state) {
                  //                       if (state is DeleteSocialLinkLoading) {
                  //                         UIUtils.showLoading(context);
                  //                       } else if (state
                  //                           is DeleteSocialLinkError) {
                  //                         UIUtils.hideLoading(context);
                  //                         UIUtils.showMessage(state.message);
                  //                       } else if (state
                  //                           is DeleteSocialLinkSuccess) {
                  //                         UIUtils.hideLoading(context);
                  //                         UIUtils.showMessage(state.message);
                  //                       }
                  //                     },
                  //                     child: widget.providerProfile.id == myid
                  //                         ? IconButton(
                  //                             onPressed: () {
                  //                               _profileCubit
                  //                                   .deleteSocialLinks(e.id!);
                  //                             },
                  //                             icon: const Icon(Icons.close))
                  //                         : const SizedBox(),
                  //                   )
                  //                 ],
                  //               ),
                  //               const SizedBox(height: 10)
                  //             ],
                  //           );
                  //         }).toList(),
                  //       )
                  //     : const SizedBox()

                  //TODO
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
