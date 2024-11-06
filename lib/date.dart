import 'package:flutter/material.dart';

class WorkingHour {
  bool selected;
  TimeOfDay? start;
  TimeOfDay? end;

  WorkingHour({
    this.selected = false,
    this.start,
    this.end,
  });
}

class WorkingSchedulePage extends StatefulWidget {
  @override
  _WorkingSchedulePageState createState() => _WorkingSchedulePageState();
}

class _WorkingSchedulePageState extends State<WorkingSchedulePage> {
  // List of days of the week
  final List<String> daysOfWeek = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

  // Map to keep track of selected days and their working hours using WorkingHour model
  final Map<String, WorkingHour> workingHours = {};

  // Initialize each day with a WorkingHour instance
  @override
  void initState() {
    super.initState();
    for (var day in daysOfWeek) {
      workingHours[day] = WorkingHour();
    }
  }

  // Function to show time picker and set time
  Future<void> _selectTime(String day, String type) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        if (type == 'start') {
          workingHours[day]?.start = pickedTime;
        } else {
          workingHours[day]?.end = pickedTime;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Working Days & Hours'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: daysOfWeek.map((day) {
            final bool isSelected = workingHours[day]?.selected ?? false;
            final TimeOfDay? startTime = workingHours[day]?.start;
            final TimeOfDay? endTime = workingHours[day]?.end;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: isSelected,
                      onChanged: (bool? value) {
                        setState(() {
                          workingHours[day]?.selected = value ?? false;
                          if (!value!) {
                            workingHours[day]?.start = null;
                            workingHours[day]?.end = null;
                          }
                        });
                      },
                    ),
                    Text(day),
                  ],
                ),
                if (isSelected) ...[
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Text(
                            startTime != null ? "Start: ${startTime.format(context)}" : 'Select Start Time',
                          ),
                          trailing: Icon(Icons.access_time),
                          onTap: () => _selectTime(day, 'start'),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text(
                            endTime != null ? "End: ${endTime.format(context)}" : 'Select End Time',
                          ),
                          trailing: Icon(Icons.access_time),
                          onTap: () => _selectTime(day, 'end'),
                        ),
                      ),
                    ],
                  ),
                ],
                Divider(),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:snipp/profile/view/widget/profile_info/active_day/box_of_from_to.dart';

// class WorkingDay {
//   bool isSelected;
//   TimeOfDay? startTime;
//   TimeOfDay? endTime;

//   WorkingDay({
//     this.isSelected = false,
//     this.startTime,
//     this.endTime,
//   });
// }

// class WorkingSchedulePage extends StatefulWidget {
//   @override
//   _WorkingSchedulePageState createState() => _WorkingSchedulePageState();
// }

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
//   final Map<String, WorkingDay> workingHours = {};

//   @override
//   void initState() {
//     super.initState();
//     for (var day in daysOfWeek) {
//       workingHours[day] = WorkingDay();
//     }
//   }

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

//           return Column(
//             // crossAxisAlignment: CrossAxisAlignment.start,
//             // mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Checkbox(
                    
//                     activeColor: Colors.green,
                    
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
//               dayInfo.isSelected
//                   ? AnimatedSize(
//                     duration: Duration(seconds: 2),
//                     curve: Curves.easeInOut,
//                     child: Row(
//                         children: [
//                           Expanded(
//                             flex: 1,
//                             child:SizedBox() ),
//                           Expanded(
//                             flex: 2,
//                             child: BoxFromDateToDate(time: 'From 12:00 pm')),
//                           SizedBox(width: 20.w,),
//                           Expanded(
//                             flex: 2,
//                             child: BoxFromDateToDate(time: 'To 6:00 Pm'))
//                         ],
//                       ),
//                   )
//                   : SizedBox()
//             ],
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
