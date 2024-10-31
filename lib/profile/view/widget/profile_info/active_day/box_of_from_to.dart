import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BoxFromDateToDate extends StatelessWidget {
 final String time;
  const BoxFromDateToDate({required this.time,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: Center(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    time,
                                    style: TextStyle(
                                        fontSize: 13.sp, color: Colors.grey),
                                  ),
                                ),
                              ),
                            );
  }
}