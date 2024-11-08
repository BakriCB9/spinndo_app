import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/features/profile/presentation/screens/edit_user_account.dart';
import 'package:snipp/features/profile/presentation/widget/profile_info/user_account/details_info.dart';

class UserAccount extends StatelessWidget {
  const UserAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Account',
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue)),
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EditUserAccountScreen()));
                },
                icon: const Icon(Icons.edit))
          ],
        ),
        InfoDetails(
            icon: Icons.person_2_outlined,
            title: 'First Name',
            content: 'Bakri'),
        InfoDetails(
            icon: Icons.person_2_outlined,
            title: 'Last Name',
            content: 'aweja'),
        InfoDetails(
            icon: Icons.email_outlined,
            title: 'Email',
            content: 'Bakkaraweja@gmail.com'),
        InfoDetails(
            icon: Icons.phone, title: 'Phone Number', content: '0959280119'),
      ],
    );
  }
}
