import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/resources/values_manager.dart';
import 'package:app/core/utils/ui_utils.dart';
import 'package:app/features/profile/data/models/provider_update/update_provider_request.dart';
import 'package:app/features/profile/domain/entities/provider_profile/provider_priofile_workingday.dart';
import 'package:app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:app/features/profile/presentation/cubit/profile_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/features/auth/data/models/register_service_provider_request.dart';
import 'package:app/features/profile/presentation/widget/profile_info/active_day/box_of_from_to.dart';

class WorkingSchedulePage extends StatefulWidget {
  final List<ProviderPriofileWorkingday> listOfworkday;
  const WorkingSchedulePage({super.key, required this.listOfworkday});

  @override
  State<WorkingSchedulePage> createState() => _WorkingSchedulePageState();
}

class _WorkingSchedulePageState extends State<WorkingSchedulePage> {
  final _profileCubit = serviceLocator.get<ProfileCubit>();
  @override
  void dispose() {
    for (int i = 0; i < _profileCubit.dateSelect.length; i++) {
      _profileCubit.dateSelect[i].daySelect = false;
      _profileCubit.dateSelect[i].end = '15:00';
      _profileCubit.dateSelect[i].start = '08:00';
      _profileCubit.dateSelect[i].arrowSelect = true;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < widget.listOfworkday.length; i++) {
      for (int j = 0; j < _profileCubit.dateSelect.length; j++) {
        if (_profileCubit.dateSelect[j].day == widget.listOfworkday[i].day) {
          _profileCubit.dateSelect[j].daySelect = true;
          _profileCubit.dateSelect[j].start =
              widget.listOfworkday[i].start!.substring(0, 5);

          _profileCubit.dateSelect[j].end =
              widget.listOfworkday[i].end!.substring(0, 5);
          break;
        }
      }
    }
    return Scaffold(
        appBar: AppBar(
        title: Text(
        'Edit Time ',
        style: TextStyle(fontSize: 35.sp, color: Colors.black),
    ),
    actions: [
    IconButton(
    onPressed: () {

    _profileCubit.updateProviderProfile(
    UpdateProviderRequest(listOfDay:_profileCubit.dateSelect),
    3);

    },
    icon: Icon(Icons.check, color: Theme.of(context).primaryColor))
    ],
    ),
    body: BlocListener<ProfileCubit,ProfileStates>(
    listener: (context,state){
    if(state is UpdateLoading){
    UIUtils.showLoading(context);
    }else if (state is UpdateError){
    UIUtils.hideLoading(context);
    UIUtils.showMessage(state.message);
    }
    else if (state is UpdateSuccess){
    UIUtils.hideLoading(context);
    Navigator.of(context).pop();
    _profileCubit.getUserRole();
    }
    },
    child: Padding(
    padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
    child: ListView.builder(
    itemCount: _profileCubit.dateSelect.length,
    itemBuilder: (context, index) {
    String day = _profileCubit.dateSelect[index].day;
    return BlocBuilder<ProfileCubit, ProfileStates>(
    bloc: _profileCubit,
    builder: (context, state) {
    return Card(
    margin: EdgeInsets.symmetric(vertical: 16.h, horizontal: 0.w),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(AppSize.s28.r),
    ),
    elevation: 0,
    child: Padding(
    padding:
    EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
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
    value:
    _profileCubit.dateSelect[index].daySelect,
    onChanged: (value) {
    _profileCubit.onDayUpdate(
    value, _profileCubit.dateSelect[index]);
    },
    ),
    ),
    Expanded(
    child: Text(
    _profileCubit.dateSelect[index].daySelect
    ? _profileCubit
        .dateSelect[index].arrowSelect
    ? day
        : "$day   ${_profileCubit.dateSelect[index].start} - ${_profileCubit.dateSelect[index].end}"
        : day,
    style: _profileCubit.dateSelect[index].daySelect
    ? Theme.of(context).textTheme.displayMedium
        : Theme.of(context)
        .textTheme
        .displayMedium!
        .copyWith(color: Colors.grey),
    ),
    ),
    if (_profileCubit.dateSelect[index].daySelect)
    IconButton(
    icon: Icon(_profileCubit
        .dateSelect[index].arrowSelect
    ? Icons.keyboard_arrow_left
        : Icons.keyboard_arrow_down),
    onPressed: () {
    _profileCubit.onArrowUpdate(
    !_profileCubit
        .dateSelect[index].arrowSelect,
    _profileCubit.dateSelect[index]);
    }),
    ],
    ),
    if (_profileCubit.dateSelect[index].daySelect)
    if (_profileCubit.dateSelect[index].arrowSelect)
    Row(
    children: [
    Expanded(
    child: DropdownButton<String>(
    dropdownColor:
    Theme.of(context).primaryColorDark,
    menuMaxHeight: 200,
    isExpanded: true,
    value: _buildTimeOptions().any((item) =>
    item.value ==
    _profileCubit
        .dateSelect[index].start)
    ? _profileCubit.dateSelect[index].start
        : null,
    // _profileCubit.dateSelect[index].start,
    style: Theme.of(context)
        .textTheme
        .displayMedium,
    iconEnabledColor: ColorManager.primary,
    onChanged: (value) {
    _profileCubit.onStartTimeUpdate(value!,
    _profileCubit.dateSelect[index]);
    },
    items: _buildTimeOptions(),
    ),
    ),
    Padding(
    padding:
    EdgeInsets.symmetric(horizontal: 8.w),
    child: Text(
    " to ",
    style: Theme.of(context)
        .textTheme
        .displayMedium,
    ),
    ),
    Expanded(
    child: DropdownButton<String>(
    dropdownColor:
    Theme.of(context).primaryColorDark,
    isExpanded: true,
    menuMaxHeight: 200,
    iconEnabledColor: ColorManager.primary,
    value: _buildTimeOptions().any((item) =>
    item.value ==
    _profileCubit.dateSelect[index].end)
    ? _profileCubit.dateSelect[index].end
        : null,
    //_profileCubit.dateSelect[index].end,
    style: Theme.of(context)
    .textTheme
    .displayMedium,
      onChanged: (value) {
        _profileCubit.onEndTimeUpdate(value!,
            _profileCubit.dateSelect[index]);
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
        )))
        .toList();
  }
}


// class EditDateTimeScreen extends StatefulWidget {
//   final List<String> dayAtcive;
// //     List<String> days = [
// //   'Saturday',
// //   'Sunday',
// //   'Monday',
// //   'Tuesday',
// //   'Wednesday',
// //   'Thursday',
// //   'Friday'
// // ];

// class WorkingDayss {
//   bool isSelected;
//   TimeOfDay? startTime;
//   TimeOfDay? endTime;
//
//   WorkingDayss({
//     this.isSelected = false,
//     this.startTime,
//     this.endTime,
//   });
// }

// class WorkingSchedulePage extends StatefulWidget {
//   @override
//   _WorkingSchedulePageState createState() => _WorkingSchedulePageState();
// }
//
// class _WorkingSchedulePageState extends State<WorkingSchedulePage>
//     with SingleTickerProviderStateMixin {
//   final List<String> daysOfWeek = [
//     'Monday',
//     'Tuesday',
//     'Wednesday',
//     'Thursday',
//     'Friday',
//     'Saturday',
//     'Sunday'
//   ];
//   final Map<String, WorkingDayss> workingHours = {};
//
//   @override
//   void initState() {
//     super.initState();
//     for (var day in daysOfWeek) {
//       workingHours[day] = WorkingDayss();
//     }
//   }
//
//   // Function to show time picker and set the selected time
//   Future<void> _selectTime(String day, bool isStart) async {
//     final TimeOfDay? pickedTime = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
//     if (pickedTime != null) {
//       setState(() {
//         if (isStart) {
//           workingHours[day]?.startTime = pickedTime;
//         } else {
//           workingHours[day]?.endTime = pickedTime;
//         }
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Working Schedule'),
//       ),
//       body: ListView(
//         padding: EdgeInsets.all(16.0),
//         children: daysOfWeek.map((day) {
//           final dayInfo = workingHours[day]!;
//
//           return Column(
//             children: [
//               Row(
//                 children: [
//                   Checkbox(
//                       activeColor: Colors.green,
//                       value: dayInfo.isSelected,
//                       onChanged: (value) {
//                         setState(() {
//                           dayInfo.isSelected = value ?? false;
//                           if (!dayInfo.isSelected) {
//                             dayInfo.startTime = null;
//                             dayInfo.endTime = null;
//                           }
//                         });
//                       }),
//                   SizedBox(width: 5.w),
//                   Text(day)
//                 ],
//               ),
//               AnimatedSize(
//                 duration: Duration(milliseconds: 300),
//                 child: Row(
//                   children: [
//                     Expanded(flex: 1, child: SizedBox()),
//                     Expanded(
//                         flex: 2,
//                         child: dayInfo.isSelected
//                             ? BoxFromDateToDate(
//                                 time: 'From 12:00 pm',
//                                 type: 1,
//                                 // dateSelect: DateSelect(
//                                 //     day: "day", start: "start", end: "end"),
//                               )
//                             : SizedBox()),
//                     SizedBox(
//                       width: 20.w,
//                     ),
//                     Expanded(
//                         flex: 2,
//                         child: dayInfo.isSelected
//                             ? BoxFromDateToDate(
//                                 time: 'To 6:00 Pm',
//                                 // dateSelect: DateSelect(
//                                 //     day: "day", start: "start", end: "end"),
//                                 type: 2,
//                               )
//                             : SizedBox())
//                   ],
//                 ),
//               )
//             ],
//           );
//         }).toList(),
//       ),
//     );
//   }
// }