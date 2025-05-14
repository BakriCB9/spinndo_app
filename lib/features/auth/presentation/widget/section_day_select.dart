import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/resources/values_manager.dart';
import 'package:app/features/auth/data/models/register_service_provider_request.dart';
import 'package:app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:app/features/auth/presentation/cubit/cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SectionDaySelect extends StatefulWidget {
  final RegisterCubit registerCubit;
  const SectionDaySelect({required this.registerCubit, super.key});

  @override
  State<SectionDaySelect> createState() => _SectionDaySelectState();
}

class _SectionDaySelectState extends State<SectionDaySelect> {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final registerCubit = widget.registerCubit;
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: registerCubit.dateSelect.length,
        itemBuilder: (context, index) {
          String day = registerCubit.dateSelect[index].day;
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
                                    registerCubit.dateSelect[index].daySelect,
                                onChanged: (value) {
                                  onDayUpdate(
                                      value, registerCubit.dateSelect[index]);
                                },
                              ),
                            ),
                            Expanded(
                              child: Text(
                                registerCubit.dateSelect[index].daySelect
                                    ? registerCubit
                                            .dateSelect[index].arrowSelect
                                        ? day
                                        : "$day   ${registerCubit.dateSelect[index].start} - ${registerCubit.dateSelect[index].end}"
                                    : day,
                                style: registerCubit.dateSelect[index].daySelect
                                    ? Theme.of(context).textTheme.displayMedium
                                    : Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(color: Colors.grey),
                              ),
                            ),
                            if (registerCubit.dateSelect[index].daySelect)
                              IconButton(
                                  icon: Icon(registerCubit
                                          .dateSelect[index].arrowSelect
                                      ? Icons.keyboard_arrow_left
                                      : Icons.keyboard_arrow_down),
                                  onPressed: () {
                                    onArrowUpdate(
                                        !registerCubit
                                            .dateSelect[index].arrowSelect,
                                        registerCubit.dateSelect[index]);
                                  }),
                          ],
                        ),
                        if (registerCubit.dateSelect[index].daySelect)
                          if (registerCubit.dateSelect[index].arrowSelect)
                            Row(children: [
                              Expanded(
                                child: DropdownButton<String>(
                                  dropdownColor:
                                      Theme.of(context).primaryColorDark,
                                  menuMaxHeight: 200,
                                  isExpanded: true,
                                  value: registerCubit.dateSelect[index].start,
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                  iconEnabledColor: ColorManager.primary,
                                  onChanged: (value) {
                                    onStartTimeUpdate(value!,
                                        registerCubit.dateSelect[index]);
                                  },
                                  items: _buildTimeOptions(),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Text(
                                  localization.to,
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                              ),
                              Expanded(
                                child: DropdownButton<String>(
                                  dropdownColor:
                                      Theme.of(context).primaryColorDark,
                                  isExpanded: true,
                                  menuMaxHeight: 200,
                                  iconEnabledColor: ColorManager.primary,
                                  value: registerCubit.dateSelect[index].end,
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                  onChanged: (value) {
                                    onEndTimeUpdate(value!,
                                        registerCubit.dateSelect[index]);
                                  },
                                  items: _buildTimeOptions(),
                                ),
                              )
                            ])
                      ])));
        });
  }

  onDayUpdate(bool daySelect, DateSelect date) {
    setState(() {
      date.daySelect = daySelect;
    });
  }

  onArrowUpdate(bool arrowSelect, DateSelect date) {
    setState(() {
      date.arrowSelect = arrowSelect;
    });
  }

  onStartTimeUpdate(String start, DateSelect date) {
    setState(() {
      date.start = start;
    });
  }

  onEndTimeUpdate(String end, DateSelect date) {
    setState(() {
      date.end = end;
    });
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
