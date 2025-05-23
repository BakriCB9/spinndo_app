import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowMoreAndShowLess extends StatefulWidget {
  final String txt;
  const ShowMoreAndShowLess({required this.txt, super.key});

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        word.length < 30 || word.length - 30 < 20
            ? Text(word.join(' '),
            style: theme.textTheme.displayMedium?.copyWith(
                fontSize: FontSize.s16
            ))
            : isExpanded
            ? Text(word.join(' '),
            style: theme.textTheme.displayMedium?.copyWith(
                fontSize: FontSize.s16
            ))
            : Text(word.sublist(0, 30).join(' '),
            style: theme.textTheme.displayMedium?.copyWith(
                fontSize: FontSize.s16
            )),
        SizedBox(
          width: 5.w,
        ),
        word.length > 30 && word.length - 30 > 20
            ? InkWell(
          onTap: () {
            isExpanded = !isExpanded;
            setState(() {});
          },
          child: Text(isExpanded ? 'show less' : 'show more'),
        )
            : const SizedBox(),
      ],
    );
  }

  void check(String text) {
    word = text.split(' ');
  }
}
