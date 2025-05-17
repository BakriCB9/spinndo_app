import 'package:app/core/constant.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/utils/ui_utils.dart';
import 'package:app/features/profile/data/models/social_media_link/social_media_links_request.dart';
import 'package:app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:app/features/profile/presentation/cubit/profile_states.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/core/const_variable.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:app/features/profile/domain/entities/provider_profile/provider_profile.dart';
import 'package:app/features/profile/presentation/widget/profile_info/active_day/custom_day_of_active.dart';
import 'package:app/features/profile/presentation/widget/profile_info/job_items/description.dart';
import 'package:app/features/profile/presentation/widget/profile_info/user_account/user_account.dart';
import 'package:app/features/profile/presentation/widget/protofile_and_diploma/custom_diploma_and_protofile.dart';
import 'package:app/features/profile/presentation/widget/sliver_header_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ProviderProfileScreen extends StatefulWidget {
  final ProviderProfile providerProfile;
  const ProviderProfileScreen({
    required this.providerProfile,
    super.key,
  });
  // const ProviderProfileScreen({required this.providerProfile, super.key});

  @override
  State<ProviderProfileScreen> createState() => _ProviderProfileScreenState();
}

class _ProviderProfileScreenState extends State<ProviderProfileScreen> {
  final _profileCubit = serviceLocator.get<ProfileCubit>();
  List<String> localSocialList = [];
  final List<String> listOfSocialLocal = [
    "facebook",
    "instagram",
    "twitter",
    "linkedin"
  ];
  @override
  initState() {
    print('Client Profile: ${widget.providerProfile.firstNameAr}');
    print('Phone: ${widget.providerProfile.phone}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.providerProfile.socialLinks!.isNotEmpty) {
      localSocialList = widget.providerProfile.socialLinks!.map((e) {
        return e!.platform!;
      }).toList();
    }
    print('the lsit of local social from api is $localSocialList');
    // print('');
    // print('the answer is ${widget.providerProfile.socialLinks}');
    // print('');
    int? myid = sharedPref.getInt(CacheConstant.userId);
    _profileCubit.latitu = widget.providerProfile.details!.latitude!;
    _profileCubit.longti = widget.providerProfile.details!.longitude!;
    _profileCubit.city = widget.providerProfile.details?.city;
    _profileCubit.myLocation = LatLng(double.parse(_profileCubit.latitu!),
        double.parse(_profileCubit.longti!));
    _profileCubit.oldLocation = LatLng(double.parse(_profileCubit.latitu!),
        double.parse(_profileCubit.longti!));
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
            delegate: SliverPersistentDelegate(widget.providerProfile.id!, size,
                widget.providerProfile.imagePath),
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
                    firstNameAr: widget.providerProfile.firstNameAr!,
                    lastNameAr: widget.providerProfile.lastNameAr!,
                    userId: widget.providerProfile.id,
                    typeAccount: 'Provider',
                    isApprovid: widget.providerProfile.details!.isApproved,
                    firstName: widget.providerProfile.firstName!,
                    lastName: widget.providerProfile.lastName!,
                    email: widget.providerProfile.email!,
                    phone: widget.providerProfile.phone??'',
                  ),
                  SizedBox(height: 15.h),
                  CustomDescription(
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
                  Row(
                    children: [
                      const Icon(Icons.location_on),
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                          widget.providerProfile.details!.isopen!
                              ? 'Open Now'
                              : 'Close Now',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(
                                  color: widget.providerProfile.details!.isopen!
                                      ? Colors.green
                                      : Colors.red)),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  CustomDiplomaAndProtofile(
                    isApprovid: widget.providerProfile.details!.isApproved,
                    userId: widget.providerProfile.id!,
                    imageCertificate:
                        widget.providerProfile.details?.certificatePath ??
                            listImage[0],
                    images: widget.providerProfile.details?.images ?? [],
                  ),
                  SizedBox(height: 100.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Your social links',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      myid == widget.providerProfile.id
                          ? IconButton(
                              onPressed: () {
                                List<String> listofSocial = [];
                                for (int i = 0;
                                    i < listOfSocialLocal.length;
                                    i++) {
                                  if (!localSocialList
                                      .contains(listOfSocialLocal[i])) {
                                    listofSocial.add(listOfSocialLocal[i]);
                                  }
                                }

                                TextEditingController _textSelectedPlatform =
                                    TextEditingController();
                                TextEditingController _textSelectUrl =
                                    TextEditingController();
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled:
                                      true, // 👈 Important for keyboard to push content
                                  // backgroundColor: ColorManager.white,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20)),
                                  ),
                                  builder: (context) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom, // 👈 Push above keyboard
                                      ),
                                      child: SingleChildScrollView(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 20),
                                        child: Column(
                                          mainAxisSize: MainAxisSize
                                              .min, // 👈 Wrap content
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            DropdownMenu(
                                              hintText: 'choose your social',
                                              controller: _textSelectedPlatform,
                                              dropdownMenuEntries:
                                                  listofSocial.map((e) {
                                                return DropdownMenuEntry(
                                                    value: e, label: e);
                                              }).toList(),
                                            ),
                                            const SizedBox(height: 20),
                                            TextFormField(
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                              controller: _textSelectUrl,
                                              decoration: const InputDecoration(
                                                hintText: "Enter your link",
                                                border: OutlineInputBorder(),
                                              ),
                                            ),
                                            const SizedBox(height: 40),
                                            BlocListener<ProfileCubit,
                                                ProfileStates>(
                                              listener: (context, state) {
                                                if (state
                                                    is AddorUpdateSoicalLinksLoading) {
                                                  UIUtils.showLoading(context);
                                                } else if (state
                                                    is AddorUpdateSoicalLinksError) {
                                                  UIUtils.hideLoading(context);
                                                  UIUtils.showMessage(
                                                      state.message);
                                                } else if (state
                                                    is AddorUpdateSoicalLinksSuccess) {
                                                  UIUtils.hideLoading(context);
                                                  Navigator.of(context).pop();
                                                }
                                              },
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  if (_textSelectUrl.text
                                                      .contains(
                                                          _textSelectedPlatform
                                                              .text)) {
                                                    _profileCubit.addOrupdateSoical(
                                                        SocialMediaLinksRequest(
                                                            platform:
                                                                _textSelectedPlatform
                                                                    .text,
                                                            url: _textSelectUrl
                                                                .text));
                                                  } else {
                                                    UIUtils.showMessage(
                                                        'Ther url that enter is not same type of platform');
                                                  }
                                                },
                                                child: const Text('Save'),
                                              ),
                                            ),
                                            const SizedBox(height: 20)
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.add))
                          : const SizedBox(),
                    ],
                  ),
                  const SizedBox(height: 20),
                  widget.providerProfile.socialLinks!.isNotEmpty
                      ? Column(
                          children:
                              widget.providerProfile.socialLinks!.map((e) {
                            print('the platform of platfrom is ${e!.platform}');
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e.platform!,
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    Expanded(
                                        child: SelectableText(e.url!,
                                            maxLines: 1)),
                                    widget.providerProfile.id == myid
                                        ? IconButton(
                                            onPressed: () {
                                              TextEditingController _text =
                                                  TextEditingController();
                                              _text.text = e.url!;
                                              String platform = e.platform!;
                                              showModalBottomSheet(
                                                  context: context,
                                                  builder: (context) {
                                                    return Padding(
                                                        padding: EdgeInsets.only(
                                                            bottom:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .viewInsets
                                                                    .bottom),
                                                        child: IntrinsicHeight(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        50),
                                                            child: Column(
                                                              children: [
                                                                TextFormField(
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                  autofocus:
                                                                      true,
                                                                  controller:
                                                                      _text,
                                                                  decoration: const InputDecoration(
                                                                      enabledBorder: UnderlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                              color: ColorManager
                                                                                  .primary)),
                                                                      fillColor:
                                                                          Colors
                                                                              .transparent,
                                                                      focusedBorder:
                                                                          UnderlineInputBorder(
                                                                              borderSide: BorderSide(color: ColorManager.primary))),
                                                                ),
                                                                const SizedBox(
                                                                    height: 20),
                                                                BlocListener<
                                                                    ProfileCubit,
                                                                    ProfileStates>(
                                                                  listener:
                                                                      (context,
                                                                          state) {
                                                                    if (state
                                                                        is AddorUpdateSoicalLinksLoading) {
                                                                      UIUtils.showLoading(
                                                                          context);
                                                                    } else if (state
                                                                        is AddorUpdateSoicalLinksError) {
                                                                      UIUtils.hideLoading(
                                                                          context);
                                                                      UIUtils.showMessage(
                                                                          state
                                                                              .message);
                                                                    } else if (state
                                                                        is AddorUpdateSoicalLinksSuccess) {
                                                                      UIUtils.hideLoading(
                                                                          context);
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    }
                                                                  },
                                                                  child:
                                                                      ElevatedButton(
                                                                          onPressed:
                                                                              () {
                                                                            if (_text.text.contains(platform)) {
                                                                              _profileCubit.addOrupdateSoical(SocialMediaLinksRequest(platform: platform, url: _text.text));
                                                                            }
                                                                          },
                                                                          child:
                                                                              const Text('Save')),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ));
                                                  });
                                            },
                                            icon: const Icon(Icons.edit))
                                        : const SizedBox(),
                                    BlocListener<ProfileCubit, ProfileStates>(
                                      listener: (context, state) {
                                        if (state is DeleteSocialLinkLoading) {
                                          UIUtils.showLoading(context);
                                        } else if (state
                                            is DeleteSocialLinkError) {
                                          UIUtils.hideLoading(context);
                                          UIUtils.showMessage(state.message);
                                        } else if (state
                                            is DeleteSocialLinkSuccess) {
                                          UIUtils.hideLoading(context);
                                          UIUtils.showMessage(state.message);
                                        }
                                      },
                                      child: widget.providerProfile.id == myid
                                          ? IconButton(
                                              onPressed: () {
                                                _profileCubit
                                                    .deleteSocialLinks(e.id!);
                                              },
                                              icon: const Icon(Icons.close))
                                          : const SizedBox(),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10)
                              ],
                            );
                          }).toList(),
                        )
                      : const SizedBox()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
