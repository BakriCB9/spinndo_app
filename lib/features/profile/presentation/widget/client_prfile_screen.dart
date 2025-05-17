import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/utils/ui_utils.dart';
import 'package:app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:app/features/auth/presentation/cubit/auth_states.dart';
import 'package:app/features/profile/presentation/screens/updgrade_account/emplye_updgrade_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:app/features/profile/domain/entities/client_profile.dart';
import 'package:app/features/profile/presentation/widget/profile_info/user_account/user_account.dart';
import 'package:app/features/profile/presentation/widget/sliver_header_widget.dart';

class ClientProfileScreen extends StatefulWidget {
  final ClientProfile clientProfile;
  const ClientProfileScreen({required this.clientProfile, super.key});

  @override
  State<ClientProfileScreen> createState() => _ClientProfileScreenState();
}

final ScrollController _control = ScrollController();

class _ClientProfileScreenState extends State<ClientProfileScreen> {
  final _drawerCubit = serviceLocator.get<DrawerCubit>();
  final _authCubit = serviceLocator.get<AuthCubit>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: _drawerCubit.themeMode == ThemeMode.dark
          ? const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("asset/images/bg.png"), fit: BoxFit.fill))
          : BoxDecoration(
              color: Colors.white.withOpacity(0.1),
            ),
      child: CustomScrollView(
        controller: _control,
        slivers: [
          SliverPersistentHeader(
            delegate: SliverPersistentDelegate(
                widget.clientProfile.id, size, widget.clientProfile.imagePath),
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
                  UserAccount(
                    lastNameAr: widget.clientProfile.lastNameAr,
                    firstNameAr: widget.clientProfile.firstNameAr,
                    typeAccount: 'Client',
                    firstName: widget.clientProfile.firstName,
                    lastName: widget.clientProfile.lastName,
                    email: widget.clientProfile.email, phone: widget.clientProfile.phone,
                  ),
                  const SizedBox(height: 20),
                  BlocListener<AuthCubit, AuthState>(
                    bloc: _authCubit,
                    listener: (context, state) {
                      if (state is GetCategoryLoading) {
                        UIUtils.showLoading(context);
                      } else if (state is GetCategoryError) {
                        UIUtils.hideLoading(context);
                        UIUtils.showMessage(state.message);
                      } else if (state is GetCategorySuccess) {
                        UIUtils.hideLoading(context);
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return BlocProvider.value(
                              value: _authCubit, child: EmployeeDetails());
                        }));
                      }
                    },
                    child: TextButton(
                        onPressed: () {
                          _authCubit.getCategories();
                          // Navigator.of(context)
                          //     .push(MaterialPageRoute(builder: (conetxt) {
                          //   return EmployeeDetails();
                          // }));
                        },
                        child: Text(
                          'Updgrade account',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  fontSize: 25.sp,
                                  decoration: TextDecoration.underline,
                                  decorationColor: ColorManager.primary),
                        )),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
