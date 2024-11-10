import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:snipp/features/auth/data/models/register_service_provider_request.dart';

class BoxFromDateToDate extends StatefulWidget {
  final String time;
  DateSelect dateSelect;
  final int type;

  BoxFromDateToDate(
      {required this.time,
      super.key,
      required this.dateSelect,
      required this.type});

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
                widget.type == 1
                    ? widget.dateSelect.start = value.format(context)
                    : widget.dateSelect.end = value.format(context);
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
              '${widget.type == 1 ? widget.dateSelect.start : widget.dateSelect.end}',
              //widget.time,
              style: TextStyle(fontSize: 13.sp, color: Colors.grey),
            ),
          ),
        ),
      ),
    );
  }
}
