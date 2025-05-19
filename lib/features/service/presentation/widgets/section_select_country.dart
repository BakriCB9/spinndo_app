import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:app/features/service/data/models/get_all_countries_response/city.dart';
import 'package:app/features/service/domain/entities/cities.dart';
import 'package:app/features/service/domain/entities/countries.dart';
import 'package:app/features/service/presentation/cubit/service_setting_cubit.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SectionSelectCountry extends StatefulWidget {
  final ServiceSettingCubit serviceCubit;

  const SectionSelectCountry({required this.serviceCubit, super.key});

  @override
  State<SectionSelectCountry> createState() => _SectionSelectCountryState();
}

class _SectionSelectCountryState extends State<SectionSelectCountry> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = AppLocalizations.of(context)!;
    final drawerCubit = serviceLocator.get<DrawerCubit>();
    final isDarkMode = drawerCubit.themeMode == ThemeMode.dark;


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30.h),
        Text(
          localization.chooseCountry,
          style: theme.textTheme.titleMedium!,
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: DropdownButtonFormField<Countries>(
                  icon: SvgPicture.asset(
                    'asset/icons/drop_down.svg',
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      widget.serviceCubit.selectedCountry != null
                          ?  (theme.textTheme.labelMedium?.color ??
                          ColorManager.textColorLight)
                          : ColorManager.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                  dropdownColor: theme.primaryColorDark,
                  hint: Text(localization.country,
                      style: theme.textTheme.labelMedium
                  ),
                  menuMaxHeight: 200,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  value: widget.serviceCubit.selectedCountry,
                  items: widget.serviceCubit.countriesList!
                      .map((e) =>
                      DropdownMenuItem<Countries>(
                        value: e,
                        child: Text(e.name,
                          style: theme.textTheme.displayMedium),
                      ))
                      .toList(),
                  onChanged: (value) {
                    selectedCountryService(value!);
                  },
                ),
              ),
            ),
          ],
        ),
        widget.serviceCubit.selectedCountry != null &&
            widget.serviceCubit.selectedCountry?.id != -1
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h),
            Text(
              localization.chooseCity,
              textAlign: TextAlign.start,
              style:
              theme.textTheme.titleMedium!.copyWith(fontSize: 32.sp),
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: DropdownButtonFormField<Cities>(
                      dropdownColor: theme.primaryColorDark,
                      hint: Text(localization.city,
                          style: theme.textTheme.labelMedium

                           ),
                      icon: SvgPicture.asset(
                        'asset/icons/drop_down.svg',
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          widget.serviceCubit.selectedCountry != null
                              ?  (theme.textTheme.labelMedium?.color ??
                              ColorManager.textColorLight)
                              : ColorManager.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                      value: widget.serviceCubit.selectedCity,
                      menuMaxHeight: 200,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                      ),
                      items: widget.serviceCubit.citiesList
                          ?.map((e) =>
                          DropdownMenuItem<Cities>(
                            value: e,
                            child: Text(
                              e.name,
                              style: theme.textTheme.displayMedium
                                  ,
                            ),
                          )
                      )
                          .toList(),
                      onChanged: (value) {
                        selectedCityService(value!);
                      },
                    ),
                  ),
                ),
              ],
            )
          ],
        )
            : const SizedBox(),
        SizedBox(height: 30.h),
        GestureDetector(
          onTap: () {
            chooseCurrentLocation(!widget.serviceCubit.isCurrent);
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: widget.serviceCubit.isCurrent
                  ? Colors.amber.shade100
                  : isDarkMode?ColorManager.darkTextFieldBg:Colors.grey.shade100,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: widget.serviceCubit.isCurrent
                    ? Colors.amber
                    : isDarkMode?ColorManager.textColorLight: Colors.grey.shade300,
                width: 1.5,
              ),
              boxShadow: widget.serviceCubit.isCurrent
                  ? [
                BoxShadow(
                  color: Colors.amber.withOpacity(0.3),
                  blurRadius: 6,
                  offset: Offset(0, 3),
                )
              ]
                  : [],
            ),
            child: Row(
              children: [
                Icon(
                  widget.serviceCubit.isCurrent
                      ? Icons.check_circle
                      : Icons.location_on_outlined,
                  color: widget.serviceCubit.isCurrent
                      ? Colors.amber
                      : Colors.grey,
                ),
                SizedBox(width: 12),
                Text(
                  localization.currentLocation,
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 30.h),
        AnimatedSize(
            alignment: Alignment.topCenter,
            duration: const Duration(milliseconds: 500),
            child: (widget.serviceCubit.isCurrent != false &&
                widget.serviceCubit.selectedCountry?.id == null)
                ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(localization.distance,
                    style: theme.textTheme.displayMedium),
                SizedBox(height: 10.h),
                Slider(
                  activeColor: theme.primaryColor,
                  inactiveColor: drawerCubit.themeMode == ThemeMode.dark
                      ? Theme
                      .of(context)
                      .primaryColorLight
                      : Colors.grey.shade300,
                  value: widget.serviceCubit.selectedDistance!,
                  min: 0,
                  max: 25,
                  divisions: 5,
                  label:
                  "${widget.serviceCubit.selectedDistance?.toInt() ??
                      10} ${localization.km}",
                  onChanged: (value) {
                    distanceSelect(value);
                  },
                ),
                Text(
                    "${widget.serviceCubit.selectedDistance?.toInt() ??
                        10} ${localization.km}",
                    style: Theme
                        .of(context)
                        .textTheme
                        .displayMedium),
                SizedBox(height: 16.h),
              ],
            )
                : const SizedBox()),
      ],
    );
  }

  void selectedCountryService(Countries country) {
    setState(() {
      widget.serviceCubit.selectedDistance = null;
      widget.serviceCubit.isCurrent = false;
      widget.serviceCubit.selectedCity = null; // Reset the selected city
      widget.serviceCubit.citiesList?.clear(); // Clear the ci
      widget.serviceCubit.selectedCountry = country;
      if (country.cities.isNotEmpty) {
        widget.serviceCubit.citiesList =
            List.from(country.cities); // Use a new list instance
      } else {
        widget.serviceCubit.citiesList = [];
      }
      City addAllCities = City(
          id: -1,
          name: AppLocalizations.of(navigatorKey.currentContext!)!.allCities);
      widget.serviceCubit.citiesList?.add(addAllCities);
    });
  }

  void selectedCityService(Cities city) {
    setState(() {
      widget.serviceCubit.selectedCity = city;
    });
  }

  void chooseCurrentLocation(bool value) {
    setState(() {
      widget.serviceCubit.isCurrent = value;
      widget.serviceCubit.selectedDistance = 10;
      widget.serviceCubit.selectedCountry = null;
      widget.serviceCubit.selectedCity = null;
    });
  }

  void distanceSelect(double value) {
    setState(() {
      widget.serviceCubit.selectedDistance = value;
    });
  }
}
