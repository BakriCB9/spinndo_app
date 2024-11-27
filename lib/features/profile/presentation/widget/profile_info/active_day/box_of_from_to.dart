import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/features/auth/data/models/register_service_provider_request.dart';

class BoxFromDateToDate extends StatefulWidget {
  final String time;
  // DateSelect dateSelect;
  final int type;

  BoxFromDateToDate(
      {required this.time,
      super.key,
      // required this.dateSelect,
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
      //onTap: widget.dateSelect.daySelect

      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(widget.time,
                style: Theme.of(context).textTheme.labelMedium),
          ),
        ),
      ),
    );
  }
}
