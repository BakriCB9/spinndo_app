import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/core/constant.dart';
import 'package:app/core/utils/ui_utils.dart';

import 'package:app/features/profile/presentation/screens/edit_user_account.dart';
import 'package:app/features/profile/presentation/widget/profile_info/user_account/details_info.dart';
import 'package:app/main.dart';

class UserAccount extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String email;
  final int? isApprovid;
  final String typeAccount;
  final int? userId;
  const UserAccount({
    this.userId,
    required this.typeAccount,
    this.isApprovid,
    required this.firstName,
    required this.lastName,
    required this.email,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final myId = sharedPref.getInt(CacheConstant.userId);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Account', style: Theme.of(context).textTheme.labelLarge),
            typeAccount == 'Client'
                ? IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditUserAccountScreen(
                                typeAccount: 'Client',
                                firstName: firstName,
                                lastName: lastName,
                              )));
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.yellow,
                    ))
                : userId == myId
                    ? IconButton(
                        onPressed: isApprovid == 1
                            ? () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => EditUserAccountScreen(
                                        typeAccount: 'Provider',
                                        firstName: firstName,
                                        lastName: lastName)));
                              }
                            : () {
                                UIUtils.showMessage(
                                    "You have to wait to Accept Your Informations");
                              },
                        icon: Icon(
                          Icons.edit,
                          color: isApprovid == 1 ? Colors.yellow : Colors.grey,
                        ))
                    : const SizedBox()
          ],
        ),
        InfoDetails(
            icon: Icons.person_2_outlined,
            title: 'First Name',
            content: firstName),
        InfoDetails(
            icon: Icons.person_2_outlined,
            title: 'Last Name',
            content: lastName),
        InfoDetails(icon: Icons.email_outlined, title: 'Email', content: email),
      ],
    );
  }
}
