import 'package:app/core/resources/color_manager.dart';
import 'package:app/features/auth/presentation/cubit/cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SectionAccountType extends StatefulWidget {
  final RegisterCubit authcubit;
  const SectionAccountType({required this.authcubit, super.key});

  @override
  State<SectionAccountType> createState() => _SectionAccountTypeState();
}

class _SectionAccountTypeState extends State<SectionAccountType> {
  bool isClient = true;
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0.w),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: [
              Radio<bool>(
                value: true,
                activeColor: ColorManager.primary,
                hoverColor: ColorManager.primary,
                groupValue: isClient,
                onChanged: (value) {
                  print('Client value is $value');
                  setState(() {
                    isClient = value!;
                    widget.authcubit.isClient = isClient;
                  });
                  print('Client value is ${widget.authcubit.isClient}');
                },
              ),
              Text(localization!.client,
                  style: Theme.of(context).textTheme.bodyMedium)
            ],
          ),
          SizedBox(width: 16.w),
          Row(children: [
            Radio<bool>(
              activeColor: ColorManager.primary,
              hoverColor: ColorManager.primary,
              value: false,
              groupValue: isClient,
              onChanged: (value) {
                setState(() {
                  print('Provider value is $value');
                  isClient = value!;
                  widget.authcubit.isClient = isClient;
                });
                print('Provider value is ${widget.authcubit.isClient}');
              },
            ),
            Text(localization.employee,
                style: Theme.of(context).textTheme.bodyMedium)
          ])
        ]));
  }
}
