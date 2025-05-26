import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ShowMoreAndShowLess extends StatefulWidget {
  final String txt;
  final String status;
  const ShowMoreAndShowLess({required this.txt, required this.status, super.key});

  @override
  State<ShowMoreAndShowLess> createState() => _ShowMoreAndShowLessState();
}

class _ShowMoreAndShowLessState extends State<ShowMoreAndShowLess> {
  List<String> word = [];
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    check(widget.txt);
    final localization = AppLocalizations.of(context)!;
    bool isPremium = widget.status == 'premium';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0),
          child: Row(
            children: [
              if (!isPremium)
                const Icon(Icons.lock, size: 16, color: Colors.grey),
              if (isPremium && word.length > 30 && word.length - 30 > 20)
                InkWell(
                  onTap: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  child: Text(
                    isExpanded ? localization.showLess : localization.showMore,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: ColorManager.primary,
                      fontSize: FontSize.s13,
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 4.h),
        ShaderMask(
          shaderCallback: (bounds) {
            if (!isPremium) {
              return LinearGradient(
                colors: [ColorManager.grey3, Colors.white],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
            } else {
              return const LinearGradient(
                colors: [Colors.transparent, Colors.transparent],
              ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
            }
          },
          blendMode: isPremium ? BlendMode.dst : BlendMode.srcIn,
          child: Text(
            _getDisplayText(isPremium),
            style: theme.textTheme.displayMedium?.copyWith(
              fontSize: FontSize.s16,
              color: isPremium ? Colors.black : Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  String _getDisplayText(bool isPremium) {
    if (!isPremium) {
      return word.length > 30 ? '${word.sublist(0, 30).join(' ')}...' : widget.txt;
    } else {
      if (word.length < 30 || word.length - 30 < 20) {
        return widget.txt;
      }
      return isExpanded ? widget.txt : word.sublist(0, 30).join(' ');
    }
  }

  void check(String text) {
    word = text.split(' ');
  }
}
