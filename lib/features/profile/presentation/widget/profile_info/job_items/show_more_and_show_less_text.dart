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
    check(widget.txt);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        word.length < 30 || word.length - 30 < 20
            ? Text(
          word.join(' '),
          style: TextStyle(fontSize: 13.sp, color: Colors.grey),
        )
            : isExpanded
            ? Text(
          word.join(' '),
          style: TextStyle(
            fontSize: 13.sp,
            color: Colors.grey,
          ),
        )
            : Text(
          word.sublist(0, 30).join(' '),
          style: TextStyle(fontSize: 25.sp, color: Colors.grey),
        ),
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