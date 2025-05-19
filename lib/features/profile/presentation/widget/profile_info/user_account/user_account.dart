import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:app/core/constant.dart';
import 'package:app/core/utils/ui_utils.dart';

import 'package:app/features/profile/presentation/screens/edit_user_account.dart';
import 'package:app/features/profile/presentation/widget/profile_info/user_account/details_info.dart';
import 'package:app/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserAccount extends StatelessWidget {
  final String firstNameAr;
  final String lastNameAr;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final bool? isApprovid;
  final String typeAccount;
  final int? userId;

  const UserAccount({
    this.userId,
    required this.firstNameAr,
    required this.lastNameAr,
    required this.typeAccount,
    this.isApprovid,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    final myId = sharedPref.getInt(CacheConstant.userId);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 24.h),
          // SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${firstName} ${lastName} / ${firstNameAr} ${lastNameAr}",
                style: theme.textTheme.labelLarge!),
              typeAccount == 'Client'
                  ? IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditUserAccountScreen(
                          firstNameAr: firstNameAr,
                          lastNameAr: lastNameAr,
                          typeAccount: 'Client',
                          firstName: firstName,
                          lastName: lastName,
                          email: email,
                          phone: phone,
                        )));
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: ColorManager.primary,
                  ))
                  : userId == myId
                  ? IconButton(
                  onPressed: isApprovid == true
                      ? () {
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) =>
                                EditUserAccountScreen(
                                  typeAccount: 'Provider',
                                  firstNameAr: firstNameAr,
                                  lastNameAr: lastNameAr,
                                  firstName: firstName,
                                  lastName: lastName,
                                  email: email,
                                  phone: phone,
                                )));
                  }
                      : () {
                    UIUtils.showMessage(
                        "You have to wait to Accept Your Informations");
                  },
                  icon: SvgPicture.asset(
                    'asset/icons/edit.svg',
                    width: 20,
                    height: 18,
                    colorFilter: ColorFilter.mode(
                      isApprovid == true
                          ? ColorManager.primary
                          : Colors.grey,
                      BlendMode.srcIn,
                    ),
                  ),
                 )
                  : const SizedBox(),
            ],
          ),
          SizedBox(height: 50.h),
          Row(
            children: [
              SvgPicture.asset(
                'asset/icons/email.svg',
                height: 23,
                colorFilter: ColorFilter.mode(
                  ColorManager.primary,
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(width: 24.w),
              Text(
                '${email}',
                style: theme.textTheme.displayMedium!
              ),
            ],
          ),
          SizedBox(height: 50.h),
          Row(
            children: [
              SvgPicture.asset(
                'asset/icons/phone.svg',
                width: 25,
                height: 28,
                colorFilter: ColorFilter.mode(
                  ColorManager.primary,
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(width: 24.w),
              Text(
                '${phone}',
                style: theme.textTheme.displayMedium!
              ),
            ],
          ),
          SizedBox(height: 30.h),
          Divider(color: Colors.grey, thickness: 0.2)

        ],
      ),
    );
  }
}
