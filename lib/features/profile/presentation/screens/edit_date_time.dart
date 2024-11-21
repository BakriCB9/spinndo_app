import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/features/auth/data/models/register_service_provider_request.dart';
import 'package:snipp/features/profile/presentation/widget/profile_info/active_day/box_of_from_to.dart';

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

class WorkingDayss {
  bool isSelected;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  WorkingDayss({
    this.isSelected = false,
    this.startTime,
    this.endTime,
  });
}

class WorkingSchedulePage extends StatefulWidget {
  @override
  _WorkingSchedulePageState createState() => _WorkingSchedulePageState();
}

class _WorkingSchedulePageState extends State<WorkingSchedulePage>
    with SingleTickerProviderStateMixin {
  final List<String> daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  final Map<String, WorkingDayss> workingHours = {};

  @override
  void initState() {
    super.initState();
    for (var day in daysOfWeek) {
      workingHours[day] = WorkingDayss();
    }
  }

  // Function to show time picker and set the selected time
  Future<void> _selectTime(String day, bool isStart) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        if (isStart) {
          workingHours[day]?.startTime = pickedTime;
        } else {
          workingHours[day]?.endTime = pickedTime;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Working Schedule'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: daysOfWeek.map((day) {
          final dayInfo = workingHours[day]!;

          return Column(
            children: [
              Row(
                children: [
                  Checkbox(
                      activeColor: Colors.green,
                      value: dayInfo.isSelected,
                      onChanged: (value) {
                        setState(() {
                          dayInfo.isSelected = value ?? false;
                          if (!dayInfo.isSelected) {
                            dayInfo.startTime = null;
                            dayInfo.endTime = null;
                          }
                        });
                      }),
                  SizedBox(width: 5.w),
                  Text(day)
                ],
              ),
              AnimatedSize(
                duration: Duration(milliseconds: 300),
                child: Row(
                  children: [
                    Expanded(flex: 1, child: SizedBox()),
                    Expanded(
                        flex: 2,
                        child: dayInfo.isSelected
                            ? BoxFromDateToDate(
                                time: 'From 12:00 pm',
                                type: 1,
                                // dateSelect: DateSelect(
                                //     day: "day", start: "start", end: "end"),
                              )
                            : SizedBox()),
                    SizedBox(
                      width: 20.w,
                    ),
                    Expanded(
                        flex: 2,
                        child: dayInfo.isSelected
                            ? BoxFromDateToDate(
                                time: 'To 6:00 Pm',
                                // dateSelect: DateSelect(
                                //     day: "day", start: "start", end: "end"),
                                type: 2,
                              )
                            : SizedBox())
                  ],
                ),
              )
            ],
          );
        }).toList(),
      ),
    );
  }
}
