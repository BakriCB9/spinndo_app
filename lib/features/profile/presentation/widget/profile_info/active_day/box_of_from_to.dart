import 'package:app/core/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    final theme = Theme.of(context);

    return InkWell(
      //onTap: widget.dateSelect.daySelect

      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(widget.time,
    style: theme.textTheme.labelMedium!,
          ),
        ),
      ),
    ));
  }
}
