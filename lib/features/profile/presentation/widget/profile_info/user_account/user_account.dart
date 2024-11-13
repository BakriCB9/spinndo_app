import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/core/di/service_locator.dart';
import 'package:snipp/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:snipp/features/profile/domain/entities/client.dart';
import 'package:snipp/features/profile/presentation/screens/edit_user_account.dart';
import 'package:snipp/features/profile/presentation/widget/profile_info/user_account/details_info.dart';

class UserAccount extends StatelessWidget {
  const UserAccount({super.key, required this.client});
final Client client;
  @override
  Widget build(BuildContext context) {
    final _authCubit = serviceLocator.get<AuthCubit>();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Account',
                style: TextStyle(
                    fontSize: 25.sp,
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
//            content: '${_authCubit.firstNameContoller.text}'

            content:client.firstName!
        ),
        InfoDetails(
            icon: Icons.person_2_outlined,
            title: 'Last Name',
            content: '${_authCubit.lastNameContoller.text}'),
        InfoDetails(
            icon: Icons.email_outlined,
            title: 'Email',
            content: '${_authCubit.emailController.text}'),
        // InfoDetails(
        //     icon: Icons.phone, title: 'Phone Number', content: '0959280119'),
      ],
    );
  }
}