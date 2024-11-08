// import 'dart:async';

// import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class SLiverListHeader extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack();
  }

  @override
  double get maxExtent => 200;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

// class TextWidgetCustom extends StatefulWidget {
//   final String text;
//   const TextWidgetCustom({required this.text, super.key});

//   @override
//   State<TextWidgetCustom> createState() => _TextWidgetCustomState();
// }

// class _TextWidgetCustomState extends State<TextWidgetCustom> {
//   ScrollController _controller=ScrollController();
//   late Timer _timer;
//   @override
//   void initState() {
//     startAutoScroll();
//     super.initState();
//   }
//   void startAutoScroll(){
//    int speed=1;
//    _timer=Timer.periodic(Duration(milliseconds:30), (_){
//     print('the value of Offset is ${_controller.offset}');
//     if(_controller.hasClients){
//       _controller.jumpTo(_controller.offset+speed);

//     }
//     _controller.jumpTo(0);

//    });
//   }
//   @override
//   Widget build(BuildContext context) {
//     print(
//         'the size of width is ${MediaQuery.of(context).size.width / 2} and lenght text is ${widget.text.length}');
//     // return text.length < MediaQuery.of(context).size.width / 2
//     //     ? Text(
//     //         text,
//     //         style: TextStyle(color: Colors.white, fontSize: 20),
//     //       )
//     //     : const Text('');
//     return SingleChildScrollView(
//       controller: _controller,
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: List.generate(
//             widget.text.length,
//             (index) => Text(
//                   widget.text[index],
//                   style: TextStyle(fontSize: 20, color: Colors.white),
//                 )),
//       ),
//     );
//   }
// }
