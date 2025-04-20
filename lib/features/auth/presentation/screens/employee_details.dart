import 'dart:io';

import 'package:app/features/service/domain/entities/child_category.dart';
import 'package:app/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/resources/values_manager.dart';
import 'package:app/core/utils/validator.dart';
import 'package:app/core/widgets/custom_text_form_field.dart';
import 'package:app/core/widgets/loading_indicator.dart';

import 'package:app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:app/features/auth/presentation/cubit/auth_states.dart';
import 'package:app/features/auth/presentation/screens/map_screen.dart';
import 'package:app/features/auth/presentation/widget/custom_auth_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:app/features/service/domain/entities/categories.dart';

import 'deploma_protofile_image_screen.dart';

class EmployeeDetails extends StatelessWidget {
  EmployeeDetails({super.key});

  static const String routeName = '/employee';

  File? pickedImage;

  final _drawerCubit = serviceLocator.get<DrawerCubit>();

  List<File>? pickedImages = [];

  int? indexChildCategory;

  final List<String> daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  final formKey = GlobalKey<FormState>();

  // final _authCubit = serviceLocator.get<AuthCubit>();
  // List<Categories> parentCategories = []; // Replace with actual data
  // List<ChildCategory> subcategories = []; // Replace with actual data

  @override
  Widget build(BuildContext context) {
    final _authCubit = BlocProvider.of<AuthCubit>(context);
    // print(_authCubit.selectedCategoryId);
    //  final ans= BlocProvider.of<AuthCubit>(context);
    // print(
    //     'the value of auth cubit location is ${_authCubit.country?.address ?? 'No address added yet'}');
    final localization = AppLocalizations.of(context)!;
    return CustomAuthForm(
      child: Column(
        children: [
          SizedBox(height: 60.h),
          Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: 20.h),
                BlocBuilder<AuthCubit, AuthState>(
                  bloc: _authCubit,
                  builder: (context, state) {
                    return CascadingDropdowns(
                        authCubit: _authCubit,
                        categories: _authCubit.categoriesList);
                  },
                ),
                CustomTextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return localization.nameLessThanTwo;
                    } else if (!Validator.hasMinLength(
                      value,
                      minLength: 2,
                    )) {
                      return localization.nameLessThanTwo;
                    }
                    return null;
                  },
                  controller: _authCubit.serviceNameController,
                  icon: Icons.work,
                  labelText: localization.jobTitle,
                ),
                SizedBox(height: 40.h),
                CustomTextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return localization.nameLessThanTwo;
                    } else if (!Validator.hasMinLength(
                      value,
                      minLength: 2,
                    )) {
                      return localization.nameLessThanTwo;
                    }
                    return null;
                  },
                  controller: _authCubit.serviceDescriptionController,
                  icon: Icons.description,
                  labelText: localization.description,
                  maxLines: 5,
                  minLines: 1,
                ),
                SizedBox(height: 40.h),
                BlocBuilder<AuthCubit, AuthState>(
                  bloc: _authCubit,
                  builder: (context, state) {
                    return InkWell(
                      onTap: () {
                        _authCubit.getCurrentLocation();
                        _authCubit.loadMapStyle(
                            _drawerCubit.themeMode == ThemeMode.dark
                                ? true
                                : false);
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return BlocProvider.value(
                            value: _authCubit,
                            child: const MapScreen(),
                          );
                        }));
                        // Navigator.of(context).pushNamed(MapScreen.routeName);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.w, vertical: 28.h),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorDark,
                          borderRadius: BorderRadius.all(
                            Radius.circular(AppSize.s28.r),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.location_on_outlined),
                            SizedBox(width: 24.w),
                            BlocBuilder<AuthCubit, AuthState>(
                              bloc: _authCubit,
                              buildWhen: (previous, current) {
                                if (current is GetLocationCountryLoading ||
                                    current is GetLocationCountryErrorr ||
                                    current is GetLocationCountrySuccess)
                                  return true;
                                return false;
                              },
                              builder: (context, state) {
                                if (state is GetLocationCountryLoading) {
                                  return LoadingIndicator(
                                      Theme.of(context).primaryColor);
                                } else if (state is GetLocationCountryErrorr) {
                                  return Text(state.message);
                                } else if (state is GetLocationCountrySuccess) {
                                  return Expanded(
                                    child: Text(
                                        maxLines: 4,
                                        "${_authCubit.country?.address ?? "please try again"}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium),
                                  );
                                } else {
                                  return Text(localization.chooseLocation,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium);
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 40.h),
                CustomTextFormField(
                  controller: _authCubit.websiteController,
                  labelText: 'WebSite',
                  icon: Icons.web,
                ),
                SizedBox(height: 40.h),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _authCubit.dateSelect.length,
                  itemBuilder: (context, index) {
                    String day = _authCubit.dateSelect[index].day;
                    return BlocBuilder<AuthCubit, AuthState>(
                      bloc: _authCubit,
                      builder: (context, state) {
                        return Card(
                          margin: EdgeInsets.symmetric(
                              vertical: 16.h, horizontal: 0.w),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppSize.s28.r),
                          ),
                          elevation: 0,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 4.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Transform.scale(
                                      scale: 0.7,
                                      child: Switch(
                                        activeColor: ColorManager.primary,
                                        inactiveThumbColor:
                                            Theme.of(context).primaryColor,
                                        inactiveTrackColor:
                                            Theme.of(context).primaryColorDark,
                                        value: _authCubit
                                            .dateSelect[index].daySelect,
                                        onChanged: (value) {
                                          _authCubit.onDayUpdate(value,
                                              _authCubit.dateSelect[index]);
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        _authCubit.dateSelect[index].daySelect
                                            ? _authCubit.dateSelect[index]
                                                    .arrowSelect
                                                ? day
                                                : "$day   ${_authCubit.dateSelect[index].start} - ${_authCubit.dateSelect[index].end}"
                                            : day,
                                        style: _authCubit
                                                .dateSelect[index].daySelect
                                            ? Theme.of(context)
                                                .textTheme
                                                .displayMedium
                                            : Theme.of(context)
                                                .textTheme
                                                .displayMedium!
                                                .copyWith(color: Colors.grey),
                                      ),
                                    ),
                                    if (_authCubit.dateSelect[index].daySelect)
                                      IconButton(
                                          icon: Icon(_authCubit
                                                  .dateSelect[index].arrowSelect
                                              ? Icons.keyboard_arrow_left
                                              : Icons.keyboard_arrow_down),
                                          onPressed: () {
                                            _authCubit.onArrowUpdate(
                                                !_authCubit.dateSelect[index]
                                                    .arrowSelect,
                                                _authCubit.dateSelect[index]);
                                          }),
                                  ],
                                ),
                                if (_authCubit.dateSelect[index].daySelect)
                                  if (_authCubit.dateSelect[index].arrowSelect)
                                    Row(
                                      children: [
                                        Expanded(
                                          child: DropdownButton<String>(
                                            dropdownColor: Theme.of(context)
                                                .primaryColorDark,
                                            menuMaxHeight: 200,
                                            isExpanded: true,
                                            value: _authCubit
                                                .dateSelect[index].start,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium,
                                            iconEnabledColor:
                                                ColorManager.primary,
                                            onChanged: (value) {
                                              _authCubit.onStartTimeUpdate(
                                                  value!,
                                                  _authCubit.dateSelect[index]);
                                            },
                                            items: _buildTimeOptions(),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.w),
                                          child: Text(
                                            localization.to,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium,
                                          ),
                                        ),
                                        Expanded(
                                          child: DropdownButton<String>(
                                            dropdownColor: Theme.of(context)
                                                .primaryColorDark,
                                            isExpanded: true,
                                            menuMaxHeight: 200,
                                            iconEnabledColor:
                                                ColorManager.primary,
                                            value: _authCubit
                                                .dateSelect[index].end,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium,
                                            onChanged: (value) {
                                              _authCubit.onEndTimeUpdate(value!,
                                                  _authCubit.dateSelect[index]);
                                            },
                                            items: _buildTimeOptions(),
                                          ),
                                        ),
                                      ],
                                    ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: 40.h),
                Container(
                  margin: EdgeInsets.only(bottom: 30.h),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        final ans = _authCubit.isAnotherDaySelected();
                        if (ans && _authCubit.isCountySuccess) {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return BlocProvider.value(
                              value: _authCubit,
                              child: DeplomaProtofileImageScreen(
                                authCubit: _authCubit,
                              ),
                            );
                          }));
                          // Navigator.of(context)
                          //     .pushNamed(DeplomaProtofileImageScreen.routeName);
                          return;
                        } else {
                          if (_authCubit.selectedCategory == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(localization.categoryRequired,
                                      style: TextStyle(
                                          fontSize: 28.sp,
                                          color: Colors.white))),
                            );
                          } else if (_authCubit.isCountySuccess == false) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(localization.locationRequired,
                                      style: TextStyle(
                                          fontSize: 28.sp,
                                          color: Colors.white))),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(localization
                                      .atleastonedaymustbeselected)),
                            );
                          }
                        }
                      }
                    },
                    child: Text(localization.next,
                        style: Theme.of(context).textTheme.bodyLarge),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> _buildTimeOptions() {
    List<String> times = [];
    for (int hour = 0; hour < 24; hour++) {
      for (int minute = 0; minute < 60; minute += 30) {
        times.add(
            "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}");
      }
    }
    return times
        .map((time) => DropdownMenuItem(
            value: time,
            child: Text(
              time,
            )))
        .toList();
  }
}
