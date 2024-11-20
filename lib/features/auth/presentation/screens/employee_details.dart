import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/core/di/service_locator.dart';
import 'package:snipp/core/resources/color_manager.dart';
import 'package:snipp/core/widgets/custom_text_form_field.dart';

import 'package:snipp/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:snipp/features/auth/presentation/cubit/auth_states.dart';
import 'package:snipp/features/auth/presentation/widget/custom_auth_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snipp/mapss.dart';

import 'deploma_protofile_image_screen.dart';

class EmployeeDetails extends StatefulWidget {
  const EmployeeDetails({super.key});

  static const String routeName = '/employee';

  @override
  State<EmployeeDetails> createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails> {
  List<String> categories = [
    '  barber',
    '  doctor',
    '  teacher',
    '  chef',
    '  lawyer'
  ];
  String? selectedCategory;

  File? pickedImage;
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

  final _authCubit = serviceLocator.get<AuthCubit>();

  @override
  Widget build(BuildContext context) {final localization = AppLocalizations.of(context)!;
    return CustomAuthForm(
   child:  Column(
        children: [
          SizedBox(height: 20.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1.w, color: ColorManager.lightGrey),
              borderRadius: BorderRadius.all(
                Radius.circular(16.r),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.category,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(width: 24.w,),
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Text(
                       localization.selectCat,
                        style:Theme.of(context).textTheme.bodySmall!.copyWith(color: ColorManager.darkGrey)
                      ),
                      value: selectedCategory,
                      isExpanded: true,
                      items: categories.map((category) {
                        return DropdownMenuItem<String>(
                          value: category,
                          child: Text(
                            category,
                              style:Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).primaryColor)

                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value;
                        });
                      },
                      borderRadius:
                           BorderRadius.all(Radius.circular(20.r)),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Theme.of(context).primaryColor,
                        size: 40.sp,
                      ),
                      dropdownColor: ColorManager.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          CustomTextFormField(
            controller: _authCubit.serviceNameController,
            icon: Icons.work,
            labelText: localization.jobTitle,
          ),
          SizedBox(height: 20.h),
      InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(Mapss.routeName);
        },
        child: Container(child: Row(children: [
          Icon( Icons.location_on_outlined,),
        Text(localization.address,)
        ],),
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 1.w, color: ColorManager.lightGrey),
            borderRadius: BorderRadius.all(
              Radius.circular(16.r),
            ),
          ),),
      ),
          // CustomTextFormField(
          //   controller: _authCubit.addressController,
          //   icon: Icons.location_on_outlined,
          //   labelText: localization.address,
          // ),
          SizedBox(height: 20.h),
          CustomTextFormField(
            controller: _authCubit.serviceDescriptionController,
            icon: Icons.description,
            labelText: localization.description,
            maxLines: 5,
            minLines: 1,
          ),
          SizedBox(height: 20.h),
          // Container(
          //     width: double.infinity,
          //     decoration: BoxDecoration(
          //       color: Colors.white,
          //       border: Border.all(width: 1.w, color: ColorManager.lightGrey),
          //       borderRadius: BorderRadius.all(
          //         Radius.circular(16.r),
          //       ),
          //     ),
          //     child: TextButton(
          //         onPressed: () {
          //           showModalBottomSheet(
          //               isDismissible: false,
          //               isScrollControlled: true,
          //               context: context,
          //               constraints: BoxConstraints(
          //                   maxHeight:
          //                       MediaQuery.of(context).size.height * .60,
          //                   minHeight:
          //                       MediaQuery.of(context).size.height / 2),
          //               builder: (context) {
          //                 return Padding(
          //                     padding: EdgeInsets.symmetric(
          //                         horizontal: 40.0.w, vertical: 30.h),
          //                     child: BlocBuilder<AuthCubit, AuthState>(
          //                         bloc: _authCubit,
          //                         builder: (context, state) {
          //                           return Column(
          //                               crossAxisAlignment:
          //                                   CrossAxisAlignment.start,
          //                               children: [
          //                                 Row(
          //                                   children: [
          //                                     Theme(
          //                                         data: ThemeData(
          //                                           splashColor: Colors
          //                                               .transparent,
          //                                         ),
          //                                         child: InkWell(
          //                                           onTap: () {
          //                                             Navigator.of(
          //                                                     context)
          //                                                 .pop();
          //                                           },
          //                                           child: const Icon(
          //                                               Icons.close),
          //                                         )),
          //                                     Expanded(
          //                                         child: Text(
          //                                       'Choose Time',
          //                                       style: TextStyle(
          //                                           fontSize: 35.sp,
          //                                           fontWeight:
          //                                               FontWeight.bold),
          //                                       textAlign:
          //                                           TextAlign.center,
          //                                     ))
          //                                   ],
          //                                 ),
          //                                 SizedBox(height: 20.h),
          //                                 Expanded(
          //                                     child: ListView(
          //                                         children: _authCubit
          //                                             .dateSelect
          //                                             .map((e) {
          //                                   return Row(children: [
          //                                     Expanded(
          //                                       flex: 1,
          //                                       child: Checkbox(
          //                                           fillColor:
          //                                               WidgetStatePropertyAll(e
          //                                                       .isSelect
          //                                                   ? Colors.green
          //                                                   : Colors
          //                                                       .white),
          //                                           value: e.isSelect,
          //                                           onChanged: (value) {
          //                                             _authCubit
          //                                                 .onSelectDay(
          //                                                     value!, e);
          //                                             print(
          //                                                 'the day is${e.day}');
          //                                           }),
          //                                     ),
          //                                     Expanded(
          //                                         flex: 10,
          //                                         child: Row(children: [
          //                                           Expanded(
          //                                             child: Align(
          //                                               alignment:
          //                                                   Alignment
          //                                                       .topLeft,
          //                                               child: FittedBox(
          //                                                 fit: BoxFit
          //                                                     .scaleDown,
          //                                                 child: Text(
          //                                                   e.day,
          //                                                   style: TextStyle(
          //                                                       fontSize:
          //                                                           25.sp,
          //                                                       color: Colors
          //                                                           .grey),
          //                                                 ),
          //                                               ),
          //                                             ),
          //                                           ),
          //                                           SizedBox(width: 10.w),
          //                                           Expanded(
          //                                               flex: 4,
          //                                               child: Row(
          //                                                   children: [
          //                                                     Expanded(
          //                                                         child: BoxFromDateToDate(
          //                                                             type:
          //                                                                 1,
          //                                                             dateSelect:
          //                                                                 e,
          //                                                             time:
          //                                                                 'From ${e.start}')),
          //                                                     SizedBox(
          //                                                       width:
          //                                                           10.w,
          //                                                     ),
          //                                                     Expanded(
          //                                                         child: BoxFromDateToDate(
          //                                                             dateSelect:
          //                                                                 e,
          //                                                             type:
          //                                                                 2,
          //                                                             time:
          //                                                                 'To ${e.end}'))
          //                                                   ]))
          //                                         ]))
          //                                   ]);
          //                                 }).toList()))
          //                               ]);
          //                         }));
          //               });
          //         },
          //         child: Row(children: [
          //           Icon(
          //             Icons.timelapse_outlined,
          //             color: Theme.of(context).primaryColor,
          //           ),
          //           SizedBox(
          //             width: 12.w,
          //           ),
          //           Text(localization.selectDays,
          //                 style:Theme.of(context).textTheme.bodySmall!.copyWith(color: ColorManager.darkGrey)
          //
          //           )]))),
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
                    margin: EdgeInsets.symmetric(vertical: 16.h, horizontal: 32.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(30.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Transform.scale(
                                scale: 0.7,
                                child: Switch(
                                  activeColor: Colors.green,
                                  inactiveThumbColor: Colors.green,
                                  inactiveTrackColor: Colors.green.shade300,
                                  value: _authCubit.dateSelect[index].daySelect,
                                  onChanged: (value) {

                                    _authCubit.onDayUpdate(value, _authCubit.dateSelect[index]);
                                  },
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  _authCubit.dateSelect[index].daySelect ?  _authCubit.dateSelect[index].arrowSelect?
                                  day:"$day   ${ _authCubit.dateSelect[index].start} - ${  _authCubit.dateSelect[index].end}":day,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color:  _authCubit.dateSelect[index].daySelect
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                              if ( _authCubit.dateSelect[index].daySelect)
                                IconButton(
                                    icon: Icon( _authCubit.dateSelect[index].arrowSelect
                                        ? Icons.arrow_back_ios_new
                                        : Icons.arrow_downward_rounded),
                                    onPressed: () {
                                      _authCubit.onArrowUpdate(!_authCubit.dateSelect[index].arrowSelect,_authCubit.dateSelect[index]);

                                    }),
                            ],
                          ),
                          if ( _authCubit.dateSelect[index].daySelect)
                            if( _authCubit.dateSelect[index].arrowSelect)
                              Row(
                                children: [
                                  Expanded(
                                    child: DropdownButton<String>(

                                      isExpanded: true,
                                      value:  _authCubit.dateSelect[index].start,
                                      iconEnabledColor: Colors.green,
                                      onChanged: (value) {
                                        _authCubit.onStartTimeUpdate(value!,_authCubit.dateSelect[index]);

                                      },
                                      items: _buildTimeOptions(),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8),
                                    child: Text("to"),
                                  ),
                                  Expanded(
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      iconEnabledColor: Colors.green,
                                      value: _authCubit.dateSelect[index].end,
                                      onChanged: (value) {
                                        _authCubit.onEndTimeUpdate(value!,_authCubit.dateSelect[index]);

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
                final ans=_authCubit.isAnotherDaySelected();
                if(ans){
                  Navigator.of(context).pushNamed(
                      DeplomaProtofileImageScreen.routeName);
                  return ;
                }

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('At least one day must be selected')),

                );
              },
              child: Text(
                "Next",
                          style:Theme.of(context).textTheme.bodyLarge

            ),
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
          style: const TextStyle(color: Colors.black),
        )))
        .toList();
  }

}
