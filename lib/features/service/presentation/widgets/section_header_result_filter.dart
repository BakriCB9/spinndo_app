import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/resources/font_manager.dart';
import 'package:app/core/routes/routes.dart';
import 'package:app/features/google_map/presentation/view/google_map_screen.dart';
import 'package:app/features/service/domain/entities/services.dart';
import 'package:app/features/service/presentation/cubit/service_setting_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SectionHeaderResultFilter extends StatefulWidget {
  final ValueNotifier<List<Services>?> services;

  const SectionHeaderResultFilter({required this.services, super.key});

  @override
  State<SectionHeaderResultFilter> createState() =>
      _SectionHeaderResultFilterState();
}

class _SectionHeaderResultFilterState extends State<SectionHeaderResultFilter> {
  final servceSettingCubit = serviceLocator.get<ServiceSettingCubit>();
  bool sortByName = false;
  bool sortByDistance = false;
  bool sortByNumberOfvisitor = false;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: SvgPicture.asset(
            'asset/icons/back.svg',
            width: 20,
            height: 20,
            colorFilter: ColorFilter.mode(
              ColorManager.grey,
              BlendMode.srcIn,
            ),
          ),
        ),
        SizedBox(width: 40.w),
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Directionality.of(context) == TextDirection.rtl
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Text(
              localization.filterResults,
              style: theme.textTheme.titleLarge?.copyWith(fontSize: FontSize.s22,fontWeight: FontWeight.w600),
            ),
          ),
        ),
        //google map
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            width: 90.r,
            height: 90.r,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(2, 4),
                ),
              ],
            ),
            child: IconButton(
              onPressed: () async {
                Navigator.of(context).pushNamed(Routes.googleMapSccren, arguments: {
                  "type": MapType.showMarkers,
                  "countryName": servceSettingCubit.selectedCity?.name ??
                      servceSettingCubit.selectedCountry?.name,
                  "latlng": servceSettingCubit.getCurrentLocation
                });
                //TODO
              },
              icon: Icon(
                Icons.map,
                color:ColorManager.primary,
                size: 40.sp,
              ),
            ),
          ),
        ),
        widget.services.value!.isNotEmpty
            ? PopupMenuButton(
                icon: Icon(
                    sortByName
                        ? Icons.sort_by_alpha_sharp
                        : sortByDistance
                            ? Icons.social_distance_sharp
                            : sortByNumberOfvisitor
                                ? Icons.visibility_outlined
                                : Icons.sort_sharp,
                    color: theme.primaryColorLight,
                    size: 45.sp),
                color: theme.primaryColorDark,
                itemBuilder: (context) => [
                      popMenu(
                          id: 1,
                          title: localization.sortByName,
                          theme: theme,
                          onClick: () {
                            widget.services.value = List.from(
                                widget.services.value!
                                  ..sort((a, b) => a.name!.compareTo(b.name!)));

                            setState(() {
                              sortByDistance = false;
                              sortByName = true;
                              sortByNumberOfvisitor = false;
                            });
                          }),
                      popMenu(
                          id: 2,
                          title: localization.sortByDistance,
                          theme: theme,
                          onClick: () {
                            widget.services.value =
                                List.from(widget.services.value!
                                  ..sort(
                                    (a, b) =>
                                        a.distance!.compareTo(b.distance!),
                                  ));

                            setState(() {
                              sortByDistance = true;
                              sortByName = false;
                              sortByNumberOfvisitor = false;
                            });
                          }),
                      popMenu(
                          id: 3,
                          title: localization.sortByVisitor,
                          theme: theme,
                          onClick: () {
                            widget.services.value =
                                List.from(widget.services.value!
                                  ..sort(
                                    (a, b) => a.numberOfvisitors!
                                        .compareTo(b.numberOfvisitors!),
                                  ));

                            setState(() {
                              sortByDistance = false;
                              sortByName = false;
                              sortByNumberOfvisitor = true;
                            });
                          }),
                    ])
            : const SizedBox(),
      ],
    );
  }

  PopupMenuItem popMenu(
      {required String title,
      required int id,
      required ThemeData theme,
      required Function onClick}) {
    return PopupMenuItem(
        height: 60.h,
        onTap: () {
          onClick();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: theme.textTheme.labelSmall!
                  .copyWith(color: theme.primaryColorLight, fontSize: 22.sp),
            ),
            sortByDistance && id == 2
                ? const CircelWidget()
                : sortByName && id == 1
                    ? const CircelWidget()
                    : sortByNumberOfvisitor && id == 3
                        ? const CircelWidget()
                        : const SizedBox()
          ],
        ));
  }
}

class CircelWidget extends StatelessWidget {
  const CircelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20.w,
      height: 20.h,
      decoration: const BoxDecoration(
          shape: BoxShape.circle, color: ColorManager.primary),
    );
  }
}


