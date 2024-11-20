import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomAuthForm extends StatelessWidget {
    CustomAuthForm({super.key, required this.child,this.isGuest=true,this.hasTitle=true,this.hasAvatar=true});
  final bool isGuest;
   final bool hasAvatar;
   final bool hasTitle;
  final  Widget child;
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Scaffold(

      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
           isGuest?   Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    Profile_Screen.routeName,
                  );
                },
                child: Text(
                  localization.guest,
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleSmall,
                ),
              ),
            ):const SizedBox(),
           hasAvatar? CircleAvatar(
                radius: 152.sp,
                backgroundColor: Theme
                    .of(context)
                    .primaryColor,
                child: Icon(
                  Icons.person,
                  size: 246.sp,
                  color: ColorManager.white,
                )):const SizedBox(),
            SizedBox(height: 20.h),
           hasTitle? Text('Spinndo',
                style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge,
                textAlign: TextAlign.center):const SizedBox(),
            SizedBox(height: 40.h),
                child
          ]
            ,
        ),
      ),
    ),)
    ,
    );
  }
}
