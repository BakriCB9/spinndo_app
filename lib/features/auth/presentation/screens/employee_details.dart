import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/core/di/service_locator.dart';
import 'package:snipp/core/resources/color_manager.dart';
import 'package:snipp/core/utils/validator.dart';
import 'package:snipp/core/widgets/custom_text_form_field.dart';
import 'package:snipp/core/widgets/loading_indicator.dart';

import 'package:snipp/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:snipp/features/auth/presentation/cubit/auth_states.dart';
import 'package:snipp/features/auth/presentation/screens/map_screen.dart';
import 'package:snipp/features/auth/presentation/widget/custom_auth_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snipp/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:snipp/features/service/domain/entities/categories.dart';

import 'deploma_protofile_image_screen.dart';

class EmployeeDetails extends StatelessWidget {
   EmployeeDetails({super.key});

  static const String routeName = '/employee';

  File? pickedImage;
   final _drawerCubit = serviceLocator.get<DrawerCubit>();

  List<File>? pickedImages = [];

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

  final _authCubit = serviceLocator.get<AuthCubit>();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return CustomAuthForm(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            SizedBox(height: 20.h),
            BlocBuilder<AuthCubit, AuthState>(
              bloc: _authCubit,
              builder: (context, state) {
                return DropdownButtonFormField<Categories>(dropdownColor:    _drawerCubit.themeMode== ThemeMode.dark
                    ? ColorManager.black
                    : ColorManager.white,
                  menuMaxHeight: 400,
                  validator: (value) {
                    if (value == null) {
                      return "please select category";
                    }
                    return null;
                  },
                  hint: Row(
                    children: [  Icon(
                      Icons.category,
                      color: Theme.of(context).primaryColor,
                    ),
                      SizedBox(
                        width: 24.w,
                      ),
                      const Text("select category",style: TextStyle(color: ColorManager.black,fontWeight: FontWeight.w500),),
                    ],
                  ),
                  decoration: const InputDecoration(errorBorder: InputBorder.none
                  ),
                  items: _authCubit.categoriesList!
                      .map((e) => DropdownMenuItem<Categories>(
                            value: e,
                            child: Text(e.name,style: TextStyle(color:     _drawerCubit.themeMode== ThemeMode.dark
                                ? ColorManager.primary
                                : ColorManager.black,),),
                          ))
                      .toList(),
                  onChanged: (value) {
                    _authCubit.selectedCategoryEvent(value!);
                  },
                );
              },
            ),
            SizedBox(height: 20.h),
            CustomTextFormField(  validator: (value) {
              if (value == null || value.isEmpty) {
                return "enter more than 2 charecters";
              } else if (!Validator.hasMinLength(
                value,
                minLength: 2,
              )) {
                return "enter more than 2 charecters";
              }
              return null;
            },
              controller: _authCubit.serviceNameController,
              icon: Icons.work,
              labelText: localization.jobTitle,
            ),
            SizedBox(height: 20.h),
            BlocBuilder<AuthCubit, AuthState>(
              bloc: _authCubit,
              builder: (context, state) {
                return InkWell(
                  onTap: () {
                    _authCubit.getCurrentLocation();
                    Navigator.of(context).pushNamed(MapScreen.routeName);
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                    decoration: BoxDecoration(
                      color:    _drawerCubit.themeMode== ThemeMode.dark
                          ? ColorManager.primary
                          : ColorManager.white,
                      border:
                          Border.all(width: 1.w, color: ColorManager.grey2),
                      borderRadius: BorderRadius.all(
                        Radius.circular(16.r),
                      ),
                    ),
                    child: Row(
                      children: [
                         Icon(Icons.location_on_outlined,
                            color:     _drawerCubit.themeMode== ThemeMode.dark
                                ? ColorManager.black
                                : ColorManager.primary,),
                        SizedBox(
                          width: 24.w,
                        ),
                        BlocBuilder<AuthCubit, AuthState>(
                          bloc: _authCubit,
                          builder: (context, state) {
                            if (state is GetLocationCountryLoading) {
                              return  LoadingIndicator(Theme.of(context).primaryColor);
                            } else if (state is GetLocationCountryErrorr) {
                              return Text(state.message);
                            } else if (state is GetLocationCountrySuccess) {   return Text(
                              "${state.country.countryName} ${state.country.cityName}",style: TextStyle(color: Colors.black,fontSize: 16),
                            );}else {
                              return const Text("select locationn",style: TextStyle(color: Colors.black,fontSize: 16),);
                            }
                          },
                        )
                      ],
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: 20.h),
            CustomTextFormField(  validator: (value) {
              if (value == null || value.isEmpty) {
                return "enter more than 2 charecters";
              } else if (!Validator.hasMinLength(
                value,
                minLength: 2,
              )) {
                return "enter more than 2 charecters";
              }
              return null;
            },
              controller: _authCubit.serviceDescriptionController,
              icon: Icons.description,
              labelText: localization.description,
              maxLines: 5,
              minLines: 1,
            ),
            SizedBox(height: 20.h),

            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _authCubit.dateSelect.length,
              itemBuilder: (context, index) {
                String day = _authCubit.dateSelect[index].day;
                return BlocBuilder<AuthCubit, AuthState>(
                  bloc: _authCubit,
                  builder: (context, state) {
                    return Card(color:     _drawerCubit.themeMode== ThemeMode.dark
                        ? ColorManager.primary
                        : ColorManager.white,
                      margin:
                          EdgeInsets.symmetric(vertical: 16.h, horizontal: 0.w),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w
                            ,vertical: 10.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Transform.scale(
                                  scale: 0.7,
                                  child: Switch(
                                    activeColor:     _drawerCubit.themeMode== ThemeMode.dark
                                        ? ColorManager.black
                                        : ColorManager.green,
inactiveThumbColor:     _drawerCubit.themeMode== ThemeMode.dark
    ? ColorManager.primary
    : ColorManager.primary,
                                    inactiveTrackColor:     _drawerCubit.themeMode== ThemeMode.dark
                                        ? ColorManager.black
                                        : ColorManager.white,
                                    value: _authCubit.dateSelect[index].daySelect,
                                    onChanged: (value) {
                                      _authCubit.onDayUpdate(
                                          value, _authCubit.dateSelect[index]);
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    _authCubit.dateSelect[index].daySelect
                                        ? _authCubit.dateSelect[index].arrowSelect
                                            ? day
                                            : "$day   ${_authCubit.dateSelect[index].start} - ${_authCubit.dateSelect[index].end}"
                                        : day,
                                    style: TextStyle(
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          _authCubit.dateSelect[index].daySelect
                                              ? (Colors.black)
                                              : Colors.grey,
                                    ),
                                  ),
                                ),
                                if (_authCubit.dateSelect[index].daySelect)
                                  IconButton(
                                      icon: Icon(
                                          _authCubit.dateSelect[index].arrowSelect
                                              ? Icons.keyboard_arrow_left
                                              : Icons.keyboard_arrow_down),
                                      onPressed: () {
                                        _authCubit.onArrowUpdate(
                                            !_authCubit
                                                .dateSelect[index].arrowSelect,
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
                                        isExpanded: true,
                                        value: _authCubit.dateSelect[index].start,
                                        iconEnabledColor: Colors.green,
                                        onChanged: (value) {
                                          _authCubit.onStartTimeUpdate(value!,
                                              _authCubit.dateSelect[index]);
                                        },
                                        items: _buildTimeOptions(),
                                      ),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      child: Text("to"),
                                    ),
                                    Expanded(
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        iconEnabledColor: Colors.green,
                                        value: _authCubit.dateSelect[index].end,
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
            SizedBox(height: 20.h),
            Container(
              margin: EdgeInsets.only(bottom: 20.h),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if(formKey.currentState!.validate()){

                  final ans = _authCubit.isAnotherDaySelected();
                  if (ans && _authCubit.isCountySuccess) {
                    Navigator.of(context)
                        .pushNamed(DeplomaProtofileImageScreen.routeName);
                    return;
                  }else{
                    if(_authCubit.isCountySuccess==false){
                      ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(
                            content: Text('location required',style: TextStyle(fontSize: 28.sp,color: Colors.white))),
                      );
                    }else{  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('At least one day must be selected')),
                    );}

                  }}



                },
                child: Text("Next", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color:     _drawerCubit.themeMode== ThemeMode.dark
                    ? ColorManager.black
                    : ColorManager.white,)),
              ),
            ),
          ],
        ),
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
              style: const TextStyle(color: Colors.black),
            )))
        .toList();
  }
}
