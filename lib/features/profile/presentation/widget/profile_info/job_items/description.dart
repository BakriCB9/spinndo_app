import 'package:app/core/resources/color_manager.dart';
import 'package:app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/core/constant.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/utils/ui_utils.dart';
import 'package:app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:app/features/profile/presentation/screens/edit_job_details.dart';
import 'package:app/features/profile/presentation/widget/profile_info/job_items/show_more_and_show_less_text.dart';
import 'package:app/features/profile/presentation/widget/profile_info/user_account/details_info.dart';
import 'package:app/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDescription extends StatelessWidget {
  final String categoryName;
  final String serviceName;
  final String description;
  final String lat;
  final String lng;
  final int userId;
  final bool? isApprovid;
  final String cityName;
  final String? webSite;
  const CustomDescription(
      {required this.categoryName,
      required this.userId,
      required this.webSite,
      this.isApprovid,
      required this.cityName,
      required this.serviceName,
      required this.description,
      super.key,
      required this.lat,
      required this.lng});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    final _profileCubit = serviceLocator.get<ProfileCubit>();
    final myId = sharedPref.getInt(CacheConstant.userId);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(localization.jobDetails,
                style: Theme.of(context).textTheme.labelLarge),
            userId == myId
                ? IconButton(
                    onPressed: isApprovid == true
                        ? () {
                            // _profileCubit.selectedSubCategory = null;
                            _profileCubit.selectedCategory = null;
                            _profileCubit.getCategories();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EditJobDetails(
                                      webSite: webSite,
                                      lat: lat,
                                      lng: lng,
                                      cityName: cityName,
                                      categoryName: categoryName,
                                      description: description,
                                      serviceName: serviceName,
                                    )));
                          }
                        : () {
                            UIUtils.showMessage(
                                'You Have to wait to Accept Your Information');
                          },
                    icon: Icon(
                      Icons.edit_outlined,
                      color: isApprovid == true
                          ? ColorManager.primary
                          : Colors.grey,
                    ))
                : const SizedBox()
          ],
        ),
        SizedBox(height: 30.h),
        Row(
          children: [
            SvgPicture.asset(
              'asset/icons/work.svg',
              width: 28,
              height: 28,
              colorFilter: const ColorFilter.mode(
                ColorManager.primary,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 24.w),
            Text('${categoryName}', style: theme.textTheme.displayMedium!),
          ],
        ),
        SizedBox(height: 50.h),
        Row(
          children: [
            const Icon(Icons.maps_home_work_outlined),
            SizedBox(width: 24.w),
            Text('${serviceName}', style: theme.textTheme.displayMedium!),
          ],
        ),
        SizedBox(height: 50.h),
        Row(
          children: [
            SvgPicture.asset(
              'asset/icons/location.svg',
              width: 26,
              height: 26,
              colorFilter: const ColorFilter.mode(
                ColorManager.primary,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 24.w),
            Text('${cityName}', style: theme.textTheme.displayMedium!),
          ],
        ),
        SizedBox(height: 50.h),
        Row(
          children: [
            SvgPicture.asset(
              'asset/icons/description.svg',
              width: 26,
              height: 26,
              colorFilter: const ColorFilter.mode(
                ColorManager.primary,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 24.w),
            ShowMoreAndShowLess(txt: description)
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        SizedBox(height: 30.h),
        const Divider(color: Colors.grey, thickness: 0.2)
      ],
    );
  }
}

// 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don'
//                     't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn'
//                     't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.'
