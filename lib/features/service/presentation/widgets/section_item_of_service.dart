import 'package:app/core/constant.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/utils/app_shared_prefrence.dart';
import 'package:app/core/utils/ui_utils.dart';
import 'package:app/core/widgets/cash_network.dart';
import 'package:app/features/favorite/presentation/view/favorite.dart';
import 'package:app/features/service/domain/entities/services.dart';
import 'package:app/features/service/presentation/screens/show_details.dart';
import 'package:app/main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SectionItemOfService extends StatelessWidget {
  final int index;
  final Services service;
  const SectionItemOfService(
      {required this.index, required this.service, super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return AnimationConfiguration.staggeredList(
      position: index,
      delay: const Duration(milliseconds: 200),
      child: SlideAnimation(
        duration: const Duration(milliseconds: 2500),
        curve: Curves.fastLinearToSlowEaseIn,
        child: FadeInAnimation(
          curve: Curves.fastLinearToSlowEaseIn,
          duration: const Duration(milliseconds: 3000),
          child: GestureDetector(
            onTap: () {
              if (isLogIn() == null) {
                UIUtils.showMessage(
                    localization.youdonthaveaccountyouhavetosignin);
                return;
              }
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ShowDetails(id: service.providerId!),
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              elevation: 10,
              shadowColor: Colors.black38,
              child: Padding(
                padding: EdgeInsets.all(32.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    service.providerImage != null
                        ? CircleAvatar(
                      radius: 50.r,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60.r),
                        child: service.providerImage!.toLowerCase().endsWith('.svg')
                            ? SvgPicture.network(
                          service.providerImage!,
                          width: 100.w,
                          height: 100.h,
                          placeholderBuilder: (context) =>
                          const CircularProgressIndicator(),
                        )
                            : CachedNetworkImage(
                          imageUrl: service.providerImage!,
                          width: 100.w,
                          height: 100.h,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                        ),
                      ),
                    )
                        : CircleAvatar(
                      radius: 50.r,
                      backgroundColor: ColorManager.primary,
                      child: Icon(Icons.person, size: 60.r, color: ColorManager.white),
                    ),

                    SizedBox(width: 20.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  service.name ?? "Service Name",
                                  style: theme.textTheme.labelMedium!
                                      .copyWith(color: theme.primaryColorLight),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Expanded(
                                  child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    CircleAvatar(
                                      radius: 12.r,
                                      backgroundColor: ColorManager.primary,
                                    ),
                                    SizedBox(width: 10.w),
                                    Text(
                                      service.distance != null
                                          ? '${service.distance!.toStringAsFixed(2)} ${localization.km}'
                                          : '',
                                      style: theme.textTheme.labelSmall!
                                          .copyWith(
                                              color: theme.primaryColorLight),
                                      textAlign: TextAlign.end,
                                    ),
                                  ],
                                ),
                              ))
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            "${localization.provider}: ${service.providerName ?? "Unknown"}",
                            style: theme.textTheme.labelMedium!
                                .copyWith(fontSize: 26.sp),
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            "${localization.description} : ${service.description}" ??
                                '',
                            style: theme.textTheme.labelMedium!
                                .copyWith(fontSize: 26.sp),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            children: [
                              Icon(Icons.category,
                                  size: 34.r, color: ColorManager.primary),
                              SizedBox(width: 10.w),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  service.categoryName ?? "Category",
                                  style: theme.textTheme.labelMedium!.copyWith(
                                      fontSize: 26.sp,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      const Icon(Icons.visibility_outlined),
                                      const SizedBox(width: 5),
                                      Expanded(
                                          child: FittedBox(
                                        alignment: Directionality.of(context) ==
                                                TextDirection.rtl
                                            ? Alignment.centerRight
                                            : Alignment.centerLeft,
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                            '${service.numberOfvisitors == null ? "0" : service.numberOfvisitors}',
                                            style: theme.textTheme.labelMedium!
                                                .copyWith(fontSize: 24.sp)),
                                      ))
                                    ],
                                  )),
                              FavoriteWidget(
                                  onPressed: () async {
                                      await saveServiceLocationToPrefs(service.latitude!, service.longitude!);},
                                isFavorite: service.isFavorite,
                                userId: service.providerId.toString(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? isLogIn() {
    final sharedPrefrence = serviceLocator.get<SharedPreferencesUtils>();
    return sharedPrefrence.getData(key: CacheConstant.tokenKey) as String?;
  }

  Future<void> saveServiceLocationToPrefs(String latitude, String longitude) async {
    await sharedPref.setString(CacheConstant.lat, latitude);
    await sharedPref.setString(CacheConstant.long, longitude);
  }


}
