import 'package:app/core/resources/color_manager.dart';
import 'package:app/features/auth/presentation/cubit/cubit/register_cubit.dart';
import 'package:flutter/material.dart';

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
        const Text('Remember me')
      ],
    );
  }
}
