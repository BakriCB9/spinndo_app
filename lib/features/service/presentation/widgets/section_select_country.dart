import 'package:app/core/di/service_locator.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:app/features/service/data/models/get_all_countries_response/city.dart';
import 'package:app/features/service/domain/entities/cities.dart';
import 'package:app/features/service/domain/entities/countries.dart';
import 'package:app/features/service/presentation/cubit/service_setting_cubit.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localization.chooseCountry,
          style: theme.textTheme.titleMedium!.copyWith(fontSize: 36.sp),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<Countries>(
                dropdownColor: theme.primaryColorDark,
                hint: Text(localization.country,
                    style: theme.textTheme.displayMedium),
                menuMaxHeight: 200,
                decoration:
                    const InputDecoration(errorBorder: InputBorder.none),
                value: widget.serviceCubit.selectedCountry,
                items: widget.serviceCubit.countriesList!
                    .map((e) => DropdownMenuItem<Countries>(
                          value: e,
                          child: Text(
                            e.name,
                            style: theme.textTheme.displayMedium,
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  selectedCountryService(value!); // Update with the new country
                },
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
                        theme.textTheme.titleMedium!.copyWith(fontSize: 36.sp),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<Cities>(
                          dropdownColor: theme.primaryColorDark,
                          hint: Text(localization.city,
                              style: theme.textTheme.displayMedium),
                          value: widget.serviceCubit.selectedCity,
                          menuMaxHeight: 200,
                          decoration: const InputDecoration(
                              errorBorder: InputBorder.none),
                          items: widget.serviceCubit.citiesList
                              ?.map((e) => DropdownMenuItem<Cities>(
                                    value: e,
                                    child: Text(
                                      e.name,
                                      style: theme.textTheme.displayMedium,
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            selectedCityService(value!);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : const SizedBox(),
        SizedBox(height: 30.h),
        Row(
          children: [
            Checkbox(
                activeColor: theme.primaryColor,
                value: widget.serviceCubit.isCurrent,
                onChanged: (value) {
                  chooseCurrentLocation(value!);
                }),
            SizedBox(width: 20.w),
            Text(
              localization.currentLocation,
              style: theme.textTheme.displayMedium,
            )
          ],
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
                            ? Theme.of(context).primaryColorLight
                            : Colors.grey.shade300,
                        value: widget.serviceCubit.selectedDistance!,
                        min: 0,
                        max: 25,
                        divisions: 5,
                        label:
                            "${widget.serviceCubit.selectedDistance?.toInt() ?? 10} ${localization.km}",
                        onChanged: (value) {
                          distanceSelect(value);
                        },
                      ),
                      Text(
                          "${widget.serviceCubit.selectedDistance?.toInt() ?? 10} ${localization.km}",
                          style: Theme.of(context).textTheme.displayMedium),
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
