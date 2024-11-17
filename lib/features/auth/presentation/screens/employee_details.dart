import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/core/di/service_locator.dart';
import 'package:snipp/core/widgets/custom_text_form_field.dart';

import 'package:snipp/features/auth/data/models/register_service_provider_request.dart';
import 'package:snipp/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:snipp/features/auth/presentation/cubit/auth_states.dart';
import 'package:snipp/features/profile/presentation/widget/profile_info/active_day/box_of_from_to.dart';

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
  Widget build(BuildContext context) {
    // File? Pic = ModalRoute.of(context)!.settings.arguments as File?;
    File? argsPic = ModalRoute.of(context)!.settings.arguments as File?;
    double avatarRadius = MediaQuery.of(context).size.width * 0.3;
    //final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFF0F8FF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
            child: Column(
              children: [
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Icon(Icons.arrow_back)),
                    ),
                    CircleAvatar(
                      radius: avatarRadius * 0.7,
                      backgroundColor: Colors.blue.shade300,
                      backgroundImage:
                          argsPic == null ? null : FileImage(argsPic),
                      child: argsPic == null
                          ? Icon(
                              Icons.person,
                              size: avatarRadius,
                              color: Colors.white,
                            )
                          : null,
                    ),
                    SizedBox(height: 8.h),
                    Text('Spinndo',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 20.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 2, color: Colors.grey.shade300),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.r),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.category,
                        color: Colors.blue.shade300,
                      ),
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            hint: Text(
                              "  Select Category",
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.grey.shade700),
                            ),
                            value: selectedCategory,
                            isExpanded: true,
                            items: categories.map((category) {
                              return DropdownMenuItem<String>(
                                value: category,
                                child: Text(
                                  category,
                                  style: TextStyle(fontSize: 32.sp),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedCategory = value;
                              });
                            },
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.blue,
                              size: 24.w,
                            ),
                            dropdownColor: Colors.blue.shade100,
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
                  labelText: 'Job Title',
                ),
                SizedBox(height: 20.h),
                CustomTextFormField(
                  controller: _authCubit.addressController,
                  icon: Icons.location_on_outlined,
                  labelText: 'Address',
                ),
                SizedBox(height: 20.h),
                CustomTextFormField(
                  controller: _authCubit.serviceDescriptionController,
                  icon: Icons.description,
                  labelText: 'Description',
                  maxLines: 5,
                  minLines: 1,
                ),
                SizedBox(height: 20.h),
                Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 2, color: Colors.grey.shade300),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.r),
                      ),
                    ),
                    child: TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                              isDismissible: false,
                              isScrollControlled: true,
                              context: context,
                              constraints: BoxConstraints(
                                  maxHeight:
                                      MediaQuery.of(context).size.height * .60,
                                  minHeight:
                                      MediaQuery.of(context).size.height / 2),
                              builder: (context) {
                                return Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 40.0.w, vertical: 30.h),
                                    child: BlocBuilder<AuthCubit, AuthState>(
                                        bloc: _authCubit,
                                        builder: (context, state) {
                                          return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Theme(
                                                        data: ThemeData(
                                                          splashColor: Colors
                                                              .transparent,
                                                        ),
                                                        child: InkWell(
                                                          onTap: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: const Icon(
                                                              Icons.close),
                                                        )),
                                                    Expanded(
                                                        child: Text(
                                                      'Choose Time',
                                                      style: TextStyle(
                                                          fontSize: 35.sp,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ))
                                                  ],
                                                ),
                                                SizedBox(height: 20.h),
                                                Expanded(
                                                    child: ListView(
                                                        children: _authCubit
                                                            .dateSelect
                                                            .map((e) {
                                                  return Row(children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Checkbox(
                                                          fillColor:
                                                              WidgetStatePropertyAll(e
                                                                      .isSelect
                                                                  ? Colors.green
                                                                  : Colors
                                                                      .white),
                                                          value: e.isSelect,
                                                          onChanged: (value) {
                                                            _authCubit
                                                                .onSelectDay(
                                                                    value!, e);
                                                            print(
                                                                'the day is${e.day}');
                                                          }),
                                                    ),
                                                    Expanded(
                                                        flex: 10,
                                                        child: Row(children: [
                                                          Expanded(
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: FittedBox(
                                                                fit: BoxFit
                                                                    .scaleDown,
                                                                child: Text(
                                                                  e.day,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          25.sp,
                                                                      color: Colors
                                                                          .grey),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(width: 10.w),
                                                          Expanded(
                                                              flex: 4,
                                                              child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                        child: BoxFromDateToDate(
                                                                            type:
                                                                                1,
                                                                            dateSelect:
                                                                                e,
                                                                            time:
                                                                                'From ${e.start}')),
                                                                    SizedBox(
                                                                      width:
                                                                          10.w,
                                                                    ),
                                                                    Expanded(
                                                                        child: BoxFromDateToDate(
                                                                            dateSelect:
                                                                                e,
                                                                            type:
                                                                                2,
                                                                            time:
                                                                                'To ${e.end}'))
                                                                  ]))
                                                        ]))
                                                  ]);
                                                }).toList()))
                                              ]);
                                        }));
                              });
                        },
                        child: Row(children: [
                          Icon(
                            Icons.timelapse_outlined,
                            color: Colors.blue.shade300,
                          ),
                          SizedBox(
                            width: 12.w,
                          ),
                          Text("Select Days",
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16,
                                  color: Colors.grey.shade700))
                        ]))),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(bottom: 20.h),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        DeplomaProtofileImageScreen.routeName,
                      );
                    },
                    child: Text(
                      "Next",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.blue),
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r))),
                        padding: WidgetStatePropertyAll(
                            EdgeInsets.symmetric(vertical: 12.h))),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  dialog() {
    // showDialog(
    //     context: context,
    //     builder: (context) => AlertDialog(
    //           content: WorkingSchedulePage(),
    //         ));
  }
}
