import 'package:flutter/material.dart';

class WorkingDay {
  bool isSelected;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  WorkingDay({
    this.isSelected = false,
    this.startTime,
    this.endTime,
  });
}