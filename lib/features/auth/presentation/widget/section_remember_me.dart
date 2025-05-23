import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/resources/font_manager.dart';
import 'package:app/features/auth/presentation/cubit/cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class SectionRememberMe extends StatefulWidget {
  final RegisterCubit authCubit;
  const SectionRememberMe({required this.authCubit, super.key});

  @override
  State<SectionRememberMe> createState() => _SectionRememberMeState();
}

class _SectionRememberMeState extends State<SectionRememberMe> {
  bool isAgree = false;
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Row(
      children: [
        Checkbox(
            activeColor: ColorManager.primary,
            value: isAgree,
            onChanged: (value) {
              setState(() {
                isAgree = value!;
                // widget.authCubit.isAgree = value;
              });
            }),
        const SizedBox(width: 10),
         Text(localization.rememberMe,  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize:FontSize.s16 ),
             )
      ],
    );
  }
}
