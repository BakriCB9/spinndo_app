import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/profile/view/widget/profile_info/active_day/custom_day_of_active.dart';
import 'package:snipp/profile/view/widget/profile_info/job_items/description.dart';
import 'package:snipp/profile/view/widget/protofile_and_diploma/custom_diploma_and_protofile.dart';

import 'package:snipp/profile/view/widget/protofile_and_diploma/diploma_and_protofile.dart';
import 'package:snipp/profile/view/widget/profile_info/user_account/user_account.dart';
import 'package:snipp/profile/view/widget/sliver_header_widget.dart';

class TestWidget extends StatefulWidget {
  const TestWidget({super.key});

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  ScrollController _control = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  int typeSelect = 1;

  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        controller: _control,
        slivers: [
          SliverPersistentHeader(
            delegate: SliverPersistentDelegate(size),
            pinned: true,
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15.h),
                  const UserAccount(),
                  SizedBox(height: 15.h),
                  const CustomDescription(),
                  SizedBox(height: 10.h),
                  const CustomDayActive(),
                  SizedBox(height: 30.h),
                  // SizedBox(height: 30.h),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: InkWell(
                  //           onTap: () {
                  //             setState(() {
                  //               typeSelect = 1;
                  //             });
                  //           },
                  //           child: DiplomaAndProtofile(
                  //               active: typeSelect == 1,
                  //               type: 1,
                  //               text: 'Diploma')),
                  //     ),
                  //     Expanded(
                  //       child: InkWell(
                  //           onTap: () {
                  //             setState(() {
                  //               typeSelect = 2;
                  //             });
                  //           },
                  //           child: DiplomaAndProtofile(
                  //               active: typeSelect == 2,
                  //               type: 2,
                  //               text: 'Protofile')),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 20.h,
                  // ),
                  // Column(children: [
                  //   Row(children: [
                  //     Expanded(
                  //         child: AspectRatio(
                  //             aspectRatio: 1,
                  //             child: Image.asset(
                  //               'asset/images/info.png',
                  //               fit: BoxFit.cover,
                  //             ))),
                  //     SizedBox(
                  //       width: 10.w,
                  //     ),
                  //     Expanded(
                  //         child: AspectRatio(
                  //             aspectRatio: 1,
                  //             child: Image.asset(
                  //               'asset/images/info.png',
                  //               fit: BoxFit.cover,
                  //             )))
                  //   ])
                  // ]),
                  CustomDiplomaAndProtofile(),
                  SizedBox(height: 100.h)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class SliverPersistentDelegate extends SliverPersistentHeaderDelegate {
//   final Size size;

//   SliverPersistentDelegate(this.size);

//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     final double maxHeaderHeight = size.height * .3;

//     final double maxImageSize = size.height * 0.22;
//     final double minImageSize = size.height * 0.06;

//     final percent = shrinkOffset / (maxHeaderHeight);
//     final currentImageSize =
//         (maxImageSize * (1 - percent)).clamp(minImageSize, maxImageSize);
//     final currentImagePosition =
//         ((size.width / 2 - minImageSize) * (1 - percent))
//             .clamp(minImageSize, maxImageSize);
//     final double currentPositionforText = (maxHeaderHeight / 2) * (1 - percent);
//     final double initPositionForText = size.height * 0.24;
//     final percent2 = shrinkOffset / maxHeaderHeight;

//     return Container(
//       color: Colors.black,
//       child: Container(
//         color: Theme.of(context)
//             .appBarTheme
//             .backgroundColor!
//             .withOpacity(percent2 * 2 < 1 ? percent2 * 2 : 1),
//         child: Stack(
//           children: [
//             Positioned(
//                 left: currentImageSize < maxHeaderHeight * 0.6
//                     ? currentImagePosition
//                     : null,
//                 top: currentImageSize < maxHeaderHeight * 0.6
//                     ? size.height * 0.04
//                     : null,
//                 bottom: currentImageSize < maxHeaderHeight * 0.6 ? size.height*0.007 : null,
//                 child: Container(
//                   width: currentImageSize < maxHeaderHeight * 0.6
//                       ? currentImageSize
//                       : null,
//                   decoration: BoxDecoration(
//                       shape: currentImageSize < maxHeaderHeight * 0.6
//                           ? BoxShape.circle
//                           : BoxShape.rectangle,
//                       image: const DecorationImage(
//                           image: AssetImage(
//                             'asset/images/messi.jpg',
//                           ),
//                           fit: BoxFit.cover)),
//                 )),
//             Positioned(
//                 left: 0,
//                 top: size.height * 0.04,
//                 child: BackButton(
//                   onPressed: () {},
//                   color: Colors.white,
//                 )),
//             Positioned(
//                 right: size.width*0.03,
//                 top: size.height * 0.04,
//                 child: IconButton(
//                     onPressed: () {},
//                     icon: const Icon(
//                       Icons.edit,
//                       color: Colors.white,
//                     ))),
//             AnimatedPositioned(
//                 duration: const Duration(milliseconds: 200),
//                 top: currentImageSize < maxHeaderHeight * 0.6
//                     ? max(currentPositionforText, size.height * 0.05)
//                     : initPositionForText * (1 - percent),
//                 left: currentImageSize < maxHeaderHeight * 0.6
//                     ? max(((size.width / 1.1)) * (1 - percent),
//                         minImageSize * 2.2)
//                     : size.width*0.03,
//                 bottom: 0,
//                 child: const Text(
//                   'bakri aweja',
//                   style: TextStyle(fontSize: 20, color: Colors.white),
//                 ))
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   double get maxExtent => size.height * 0.3;

//   @override
//   double get minExtent => size.height * .11;

//   @override
//   bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
//     return false;
//   }
// }
