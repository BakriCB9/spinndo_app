import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.dateSelect.isSelect
          ? () {
              showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              ).then(
                (value) {
                  setState(() {
                    if (value != null) {
                      TimeOfDay aux =
                          TimeOfDay(hour: value.hour, minute: value.minute);
                      if (widget.type == 2) {
                        aux = TimeOfDay(
                            hour: value.hour + 12, minute: value.minute);
                      } else {
                        aux.hour.toString().padLeft(2, '0');
                      }

                      widget.type == 1
                          ? widget.dateSelect.start =
                              '0${aux.format(context).split(' ')[0]}'
                          : widget.dateSelect.end =
                              aux.format(context).split(' ')[0];
                    }
                  });
                },
              );
            }
          : null,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            border: Border.all(
                color: widget.dateSelect.isSelect ? Colors.blue : Colors.grey),
            borderRadius: BorderRadius.circular(10.r)),
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              widget.type == 1
                  ? (widget.dateSelect.start ?? 'Select start time')
                  : (widget.dateSelect.end ?? 'Select end time'),
              style: TextStyle(fontSize: 25.sp, color: Colors.grey),
            ),
          ),
        ),
      ),
    );
  }
}
