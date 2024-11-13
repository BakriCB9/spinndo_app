import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/core/di/service_locator.dart';
import 'package:snipp/core/widgets/custom_text_form_field.dart';
import 'package:snipp/date.dart';
import 'package:snipp/core/utils/image_functions.dart';
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
    File? Pic = ModalRoute.of(context)!.settings.arguments as File?;
    File? argsPic = ModalRoute.of(context)!.settings.arguments as File?;
    double avatarRadius = MediaQuery.of(context).size.width * 0.3;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFF0F8FF),
      // appBar: AppBar(
      //   backgroundColor: Color(0xFFF0F8FF),
      // ),
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
    Align(alignment: Alignment.centerLeft,child: InkWell(
    onTap: (){
    Navigator.of(context).pop();
    },
    child:const  Icon(Icons.arrow_back)),),

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
    Text(
    'Spinndo',
    style: TextStyle(fontWeight: FontWeight.bold),
    ),
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
    maxHeight: MediaQuery.of(context).size.height * .60,
    minHeight: MediaQuery.of(context).size.height / 2),
    builder: (context) {
    return Padding(
    padding: EdgeInsets.symmetric(
    horizontal: 40.0.w, vertical: 30.h),
    child: BlocBuilder<AuthCubit, AuthState>(
    bloc: _authCubit,
    builder: (context, state) {
    return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Row(
    children: [
    Theme(
    data: ThemeData(
    splashColor: Colors.transparent,
    ),
    child: InkWell(
    onTap: () {
    Navigator.of(context).pop();
    },
    child: const Icon(Icons.close),
    )),
    Expanded(
    child: Text(
    'Choose Time',
    style: TextStyle(
    fontSize: 35.sp,
    fontWeight: FontWeight.bold),
    textAlign: TextAlign.center,
    ))
    ],
    ),
    SizedBox(height: 20.h),
    Expanded(
    child: ListView(
    children: _authCubit.dateSelect.map(
    (e) {
    return Row(
    children: [
    Expanded(
    flex: 1,
    child: Checkbox(
    fillColor:
    WidgetStatePropertyAll(
    e.isSelect
    ? Colors.green
        : Colors.white),
    value: e.isSelect,
    onChanged: (value) {

    _authCubit.onSelectDay(
    value!, e);

    int  frequentOfSelect=0;
    DateSelect dateChoosen=DateSelect(day: '');
    for(int i=0;i<_authCubit.dateSelect.length;i++){
    if(_authCubit.dateSelect[i].isSelect){frequentOfSelect++;dateChoosen=_authCubit.dateSelect[i];}
    }
    if(frequentOfSelect==1){
    for(int i=0;i<_authCubit.dateSelect.length;i++){
    _authCubit.dateSelect[i].start=dateChoosen.start;
    _authCubit.dateSelect[i].end=dateChoosen.end;
    }
    }
    },
    ),
    ),
    Expanded(
    flex: 10,
    child: Row(
    children: [
    Expanded(
    child: Align(
    alignment:
    Alignment.topLeft,
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
    type: 1,
    dateSelect:
    e,
    time:
    'From ${e.start}')),
    SizedBox(
    width: 10.w,
    ),
    Expanded(
    child: BoxFromDateToDate(
    dateSelect:
    e,
    type: 2,
    time:
    'To ${e.end}'))
    ],
    ))
    ],
    ),
    ),
    ],
    );
    },
    ).toList(),
    ),
    ),
    ],
    );
    },
    ),
    );
    },
    );
    },
    child: Row(
    children: [
    Icon(
    Icons.timelapse_outlined,
    color: Colors.blue.shade300,
    ),
    SizedBox(
    width: 12.w,
    ),
    Text(
    "Select Days",
    style: TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 16,
    color: Colors.grey.shade700),
    ),
    ],
    ),
    ),
    ),
    SizedBox(
    height: 20,
    ),
    //     InkWell(
    //       child: Container(
    // width: double.infinity,     padding: EdgeInsets.symmetric(vertical: 10),             decoration: BoxDecoration(
    //               border: Border.all(width: 2, color: Colors.grey.shade300),borderRadius: BorderRadius.all(Radius.circular(15.r))),
    //           child: Row(
    //             children: [
    //               Icon(Icons.date_range,color: Colors.blue.shade300,),Text(
    //                 "  Select Days",
    //                 style: TextStyle(color: Colors.grey.shade700),
    //               ),
    //             ],
    //           )),
    //       onTap: () {
    //         showDialog(
    //           context: context,
    //           builder: (context) {
    //             return AlertDialog(
    //               content: StatefulBuilder(
    //                 builder: (context, setState) {
    //                   return AlertDialog(
    //                     title: const Text('Select Working Days'),
    //                     content: SingleChildScrollView(
    //                       child: Column(
    //                         mainAxisSize: MainAxisSize.min,
    //                         children: daysOfWeek.map((day) {
    //                           final dayInfo = workingHours[day]!;
    //                           return AnimatedContainer(
    //                             duration: const Duration(milliseconds: 300),
    //                             curve: Curves.easeInOut,
    //                             child: Card(
    //                               elevation: 2,
    //                               margin: const EdgeInsets.symmetric(
    //                                   vertical: 6),
    //                               child: ExpansionTile(
    //                                 title: Row(
    //                                   children: [
    //                                     Checkbox(
    //                                       value: dayInfo.isSelected,
    //                                       onChanged: (bool? value) {
    //                                         setState(() {
    //                                           dayInfo.isSelected =
    //                                               value ?? false;
    //                                           if (!dayInfo.isSelected) {
    //                                             dayInfo.startTime = null;
    //                                             dayInfo.endTime = null;
    //                                           }
    //                                         });
    //                                       },
    //                                     ),
    //                                     Text(
    //                                       day,
    //                                       style: const TextStyle(
    //                                           fontSize: 16,
    //                                           fontWeight: FontWeight.bold),
    //                                     ),
    //                                   ],
    //                                 ),
    //                                 children: dayInfo.isSelected
    //                                     ? [
    //                                         Padding(
    //                                           padding: const EdgeInsets
    //                                               .symmetric(
    //                                               horizontal: 16.0),
    //                                           child: Column(
    //                                             children: [
    //                                               ListTile(
    //                                                 title: Text(
    //                                                   dayInfo.startTime !=
    //                                                           null
    //                                                       ? "Start: ${dayInfo.startTime!.format(context)}"
    //                                                       : "Select Start Time",
    //                                                 ),
    //                                                 trailing: const Icon(
    //                                                     Icons.access_time),
    //                                                 onTap: () =>
    //                                                     _selectTime(
    //                                                         day, true),
    //                                               ),
    //                                               ListTile(
    //                                                 title: Text(
    //                                                   dayInfo.endTime !=
    //                                                           null
    //                                                       ? "End: ${dayInfo.endTime!.format(context)}"
    //                                                       : "Select End Time",
    //                                                 ),
    //                                                 trailing: const Icon(
    //                                                     Icons.access_time),
    //                                                 onTap: () =>
    //                                                     _selectTime(
    //                                                         day, false),
    //                                               ),
    //                                             ],
    //                                           ),
    //                                         ),
    //                                       ]
    //                                     : [],
    //                               ),
    //                             ),
    //                           );
    //                         }).toList(),
    //                       ),
    //                     ),
    //                     actions: [
    //                       TextButton(
    //                         onPressed: () {
    //                           Navigator.of(context)
    //                               .pop(); // Close the dialog
    //                         },
    //                         child: const Text('Done'),
    //                       ),
    //                     ],
    //                   );
    //                 },
    //               ),
    //             );
    //           },
    //         );
    //       },
    //     ),

    // Container(
    //   margin: EdgeInsets.symmetric(horizontal: 10.w),
    //   width: double.infinity,
    //   child: ElevatedButton(
    //     onPressed: () async {
    //       File? temp = await ImageFunctions.CameraPicker();
    //       if (temp != null) {
    //         pickedImage = temp;
    //       }
    //       setState(() {});
    //     },
    //     child: Text(
    //       "Upload Deploma Image",
    //       style: TextStyle(fontSize: 20.sp, color: Colors.white),
    //     ),
    //     style: ButtonStyle(
    //         backgroundColor: WidgetStatePropertyAll(Colors.blue),
    //         shape: WidgetStatePropertyAll(RoundedRectangleBorder(
    //             borderRadius: BorderRadius.circular(15.r))),
    //         padding: WidgetStatePropertyAll(
    //             EdgeInsets.symmetric(vertical: 10.h))),
    //   ),
    // ),
    // SizedBox(height: 20.h,),
    // CircleAvatar(
    //   backgroundImage:
    //       pickedImage == null ? null : FileImage(pickedImage!),
    // ),
    // Container(
    //   margin: EdgeInsets.symmetric(horizontal: 10.w),
    //   width: double.infinity,
    //   child: ElevatedButton(
    //     onPressed: () async {
    //       List<File>? temps = await ImageFunctions.galleryPickers();
    //       if (temps != null) {
    //         pickedImages = temps;
    //       }
    //       setState(() {});
    //     },
    //     child: Text(
    //       "Upload protofile Images",
    //       style: TextStyle(fontSize: 20.sp, color: Colors.white),
    //     ),
    //     style: ButtonStyle(
    //         backgroundColor: WidgetStatePropertyAll(Colors.blue),
    //         shape: WidgetStatePropertyAll(RoundedRectangleBorder(
    //             borderRadius: BorderRadius.circular(15.r))),
    //         padding: WidgetStatePropertyAll(
    //             EdgeInsets.symmetric(vertical: 10.h))),
    //   ),
    // ),
    // Row(children: List.generate(3, (index){
    //   return Padding(
    //     padding: const EdgeInsets.all(8.0),
    //     child: CircleAvatar(
    //         backgroundImage: pickedImages!=null && pickedImages!.length>index?FileImage(pickedImages![index]):null,
    //         child: pickedImages==null||pickedImages!.length<=index?Icon(Icons.image,size: 30.sp,color: Colors.blue,):null),
    //   );
    // }),),
    //  SizedBox(height: 20.h,),
    //  Container(
    //    margin: EdgeInsets.symmetric(horizontal: 10.w),
    //    width: double.infinity,
    //    child: ElevatedButton(
    //      onPressed: () {
    //        Navigator.of(context).pushNamed(UploadProfileImage.routeName);
    //      },
    //      child: Text(
    //        "Next >>",
    //        style: TextStyle(color: Colors.white, fontSize: 18.sp),
    //      ),
    //      style: ButtonStyle(
    //          backgroundColor: WidgetStatePropertyAll(Colors.blue),
    //          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
    //              borderRadius: BorderRadius.circular(15.r))),
    //          padding: WidgetStatePropertyAll(
    //              EdgeInsets.symmetric(vertical: 10.h))),
    //    ),
      //  ),
      //  SizedBox(height: 20.h,),
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