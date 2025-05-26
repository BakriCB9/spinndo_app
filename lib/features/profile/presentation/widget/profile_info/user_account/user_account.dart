import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/resources/font_manager.dart';
import 'package:app/features/packages/presentation/view_model/packages_cubit.dart';
import 'package:flutter/material.dart';
import 'package:app/core/constant.dart';
import 'package:app/core/utils/ui_utils.dart';

import 'package:app/features/profile/presentation/screens/edit_user_account.dart';
import 'package:app/features/profile/presentation/widget/profile_info/user_account/details_info.dart';
import 'package:app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserAccount extends StatelessWidget {
  final String firstNameAr;
  final String lastNameAr;
  final String firstName;
  final String lastName;
  final bool? isApprovid;
  final String typeAccount;
  final String phoneNumber;
  final int? userId;
  final String? accountStatus;

  const UserAccount({
    this.userId,
    required this.phoneNumber,
    required this.firstNameAr,
    required this.lastNameAr,
    required this.typeAccount,
    this.isApprovid,
    required this.firstName,
    required this.lastName,
    this.accountStatus,
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final localization = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final myId = sharedPref.getInt(CacheConstant.userId);

    final packagesCubit = context.read<PackagesCubit>();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text("${firstName} ${lastName} / ${firstNameAr} ${lastNameAr}",
                    style: theme.textTheme.labelLarge!.copyWith(fontSize: FontSize.s20)),
                if (accountStatus=='premium')
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.verified,
                      color: ColorManager.primary,
                      size: 20,
                    ),
                  ),
              ],
            ),
            typeAccount == 'Client'
                ? IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditUserAccountScreen(
                                phoneNumber: phoneNumber,
                                firstNameAr: firstNameAr,
                                lastNameAr: lastNameAr,
                                typeAccount: 'Client',
                                firstName: firstName,
                                lastName: lastName,
                              )));
                    },
                    icon: const Icon(
                      Icons.edit_outlined,
                      color: ColorManager.primary,
                    ))
                : userId == myId
                    ? IconButton(
                        onPressed: isApprovid == true
                            ? () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => EditUserAccountScreen(
                                        phoneNumber: phoneNumber,
                                        typeAccount: 'Provider',
                                        firstNameAr: firstNameAr,
                                        lastNameAr: lastNameAr,
                                        firstName: firstName,
                                        lastName: lastName)));
                              }
                            : () {
                                UIUtils.showMessage(
                                    localization.plsWaitAccepted);
                              },
                        icon: Icon(
                          Icons.edit_outlined,
                          color:
                              isApprovid == true ?ColorManager.primary : Colors.grey,
                        ))
                    : const SizedBox()
          ],
        ),
        SizedBox(height: 30.h),
        Row(
          children: [
            SvgPicture.asset(
              'asset/icons/phone.svg',
              width: 25,
              height: 25,
              colorFilter: ColorFilter.mode(
                ColorManager.primary,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 24.w),
            Text(
                '${phoneNumber}',
                style: theme.textTheme.displayMedium!
            ),
          ],
        ),
        SizedBox(height: 30.h),
        Divider(color: Colors.grey, thickness: 0.2)
      ],
    );
  }
}
