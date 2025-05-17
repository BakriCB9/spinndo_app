import 'package:flutter/material.dart';
import 'package:app/core/constant.dart';
import 'package:app/core/utils/ui_utils.dart';

import 'package:app/features/profile/presentation/screens/edit_user_account.dart';
import 'package:app/features/profile/presentation/widget/profile_info/user_account/details_info.dart';
import 'package:app/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

    final myId = sharedPref.getInt(CacheConstant.userId);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(localization.account,
                style: Theme.of(context).textTheme.labelLarge),
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
                                email: email, phone: phone,
                              )));

                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.yellow,
                    ))
                : userId == myId
                    ? IconButton(
                        onPressed: isApprovid == true
                            ? () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => EditUserAccountScreen(
                                          typeAccount: 'Provider',
                                          firstNameAr: firstNameAr,
                                          lastNameAr: lastNameAr,
                                          firstName: firstName,
                                          lastName: lastName,
                                          email: email, phone: phone,
                                        )));
                              }
                            : () {
                                UIUtils.showMessage(
                                    "You have to wait to Accept Your Informations");
                              },
                        icon: Icon(
                          Icons.edit,
                          color:
                              isApprovid == true ? Colors.yellow : Colors.grey,
                        ))
                    : const SizedBox()
          ],
        ),
        InfoDetails(
            icon: Icons.person_2_outlined,
            title: localization.firstNameAr,
            content: firstNameAr),
        InfoDetails(
            icon: Icons.person_2_outlined,
            title: localization.lastNameAr,
            content: lastNameAr),
        InfoDetails(
            icon: Icons.person_2_outlined,
            title: localization.firstName,
            content: firstName),
        InfoDetails(
            icon: Icons.person_2_outlined,
            title: localization.lastName,
            content: lastName),
        InfoDetails(
            icon: Icons.email_outlined,
            title: localization.email,
            content: email),
        InfoDetails(
            icon: Icons.phone,
            title: localization.phoneNumber,
            content: phone),
      ],
    );
  }
}
