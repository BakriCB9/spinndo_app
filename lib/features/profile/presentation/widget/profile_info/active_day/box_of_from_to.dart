import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class BoxFromDateToDate extends StatefulWidget {
  final String time;
  const BoxFromDateToDate({required this.time, super.key});

  @override
  State<BoxFromDateToDate> createState() => _BoxFromDateToDateState();
}

class _BoxFromDateToDateState extends State<BoxFromDateToDate> {
  late TimeOfDay _date;
  @override
  void initState() {
    super.initState();
    _date = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showTimePicker(
                context: context,
                //firstDate: DateTime.now(),
                //lastDate: DateTime.now());
                initialTime: TimeOfDay.now())
            .then(
          (value) {
            setState(() {
              if (value != null) {
                print('the value is $value');
                _date = value;
                //print('the date is   ############################# ${_date.hour} and ${_date.minute}');
              }
            });
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(10.r)),
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              '${_date.format(context) ?? TimeOfDay.now()}',
              //widget.time,
              style: TextStyle(fontSize: 13.sp, color: Colors.grey),
            ),
          ),
        ),
      ),
    );
  }
}
