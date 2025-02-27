import 'package:app/core/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget({super.key});

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          InkWell(
            onTap: () {
              //Forgot password Tapped
            },
            child: Text('forgotPassword'),
          ),
        ],
      ),
    );

    //  Material(
    //   color: Colors.transparent,
    //   // elevation: 1,
    //   child: InkWell(
    //     splashColor: Colors.transparent,
    //     onTap: () {
    //       isSelected = !isSelected;
    //       print('islsss sssssss $isSelected');
    //       setState(() {});
    //     },
    //     child: isSelected
    //         ? Icon(
    //             Icons.favorite,
    //             color: ColorManager.red,
    //             size: 45.w,
    //           )
    //         : Icon(
    //             Icons.favorite_border_outlined,
    //             size: 45.w,
    //           ),
    //   ),
    // );

    //     Material(
    //   color: Colors.transparent,
    //   child: Ink(
    //     decoration: ShapeDecoration(shape: CircleBorder(), color: Colors.blue),
    //     child: IconButton(
    //         onPressed: () {},
    //         icon: Icon(
    //           Icons.android,
    //           color: Colors.white,
    //         )),
    //   ),
    // );
    //////////////////////////
    // Icon(
    //   Icons.favorite,
    //   color: Colors.red,
    // );
    // IconButton(
    //     selectedIcon: const Icon(
    //       Icons.favorite,
    //       color: ColorManager.red,
    //     ),
    //     // constraints: BoxConstraints(
    //     //     minWidth: 0, minHeight: 0, maxWidth: 0, maxHeight: 0),
    //     isSelected: isSelected,
    //     padding: EdgeInsets.zero,
    //     onPressed: () {
    //       setState(() {
    //         isSelected = !isSelected;
    //       });
    //     },
    //     icon: const Icon(Icons.favorite_border_outlined));
  }
}
