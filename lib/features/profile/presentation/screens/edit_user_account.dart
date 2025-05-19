import 'package:app/core/utils/ui_utils.dart';
import 'package:app/core/utils/validator.dart';
import 'package:app/core/widgets/custom_text_form_field.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:app/features/profile/presentation/cubit/profile_states.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditUserAccountScreen extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String firstNameAr;
  final String lastNameAr;
  final String typeAccount;
  final String email;
  final String phoneNumber;
  const EditUserAccountScreen(
      {required this.firstName,
      required this.firstNameAr,
      required this.lastNameAr,
      required this.lastName,
      required this.typeAccount,
      required this.email,
      required this.phoneNumber,
      super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final _profileCubit = serviceLocator.get<ProfileCubit>();
    _profileCubit.firstNameEditController.text = firstName;
    _profileCubit.lastNameEditController.text = lastName;
    _profileCubit.firstNameArEditController.text = firstNameAr;
    _profileCubit.lastNameArEditController.text = lastNameAr;
    _profileCubit.phoneNumberController.text = phoneNumber;

    final drawerCubit = serviceLocator.get<DrawerCubit>();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Container(
      decoration: drawerCubit.themeMode == ThemeMode.dark
          ? const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("asset/images/bg.png"), fit: BoxFit.fill))
          : null,
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 15.h),
                  SizedBox(
                    height: 70.h,
                  ),
                  CustomTextFormField(
                    validator: (value) {
                      final ans = Validator.hasMinLength(value);
                      return ans ? null : localization.nameLessThanTwo;
                    },
                    labelText: localization.firstNameAr,
                    icon: Icons.person,
                    controller: _profileCubit.firstNameArEditController,
                    onChanged: (value) {
                      _profileCubit.updateInfo(
                        curphoneNumber: phoneNumber,
                        newPhoneNumber:
                            _profileCubit.phoneNumberController.text,
                        curFirst: firstName,
                        curFirstAr: firstNameAr,
                        newFirstAr:
                            _profileCubit.firstNameArEditController.text,
                        curLastAr: lastNameAr,
                        newLastAr: _profileCubit.lastNameArEditController.text,
                        newFirst: _profileCubit.firstNameEditController.text,
                        curLast: lastName,
                        newLast: _profileCubit.lastNameEditController.text,
                      );
                    },
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  CustomTextFormField(
                    validator: (value) {
                      final ans = Validator.hasMinLength(value);
                      return ans ? null : localization.nameLessThanTwo;
                    },
                    controller: _profileCubit.lastNameArEditController,
                    labelText: localization.lastNameAr,
                    icon: Icons.person,
                    onChanged: (value) {
                      _profileCubit.updateInfo(
                          curphoneNumber: phoneNumber,
                          newPhoneNumber:
                              _profileCubit.phoneNumberController.text,
                          curFirst: firstName,
                          curFirstAr: firstNameAr,
                          newFirstAr:
                              _profileCubit.firstNameArEditController.text,
                          curLastAr: lastNameAr,
                          newLastAr:
                              _profileCubit.lastNameArEditController.text,
                          newFirst: _profileCubit.firstNameEditController.text,
                          curLast: lastName,
                          newLast: _profileCubit.lastNameEditController.text);
                    },
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  CustomTextFormField(
                    validator: (value) {
                      final ans = Validator.hasMinLength(value);
                      return ans ? null : localization.nameLessThanTwo;
                    },
                    controller: _profileCubit.firstNameEditController,
                    labelText: localization.firstName,
                    icon: Icons.person,
                    onChanged: (value) {
                      _profileCubit.updateInfo(
                          curphoneNumber: phoneNumber,
                          newPhoneNumber:
                              _profileCubit.phoneNumberController.text,
                          curFirst: firstName,
                          curFirstAr: firstNameAr,
                          newFirstAr:
                              _profileCubit.firstNameArEditController.text,
                          curLastAr: lastNameAr,
                          newLastAr:
                              _profileCubit.lastNameArEditController.text,
                          newFirst: _profileCubit.firstNameEditController.text,
                          curLast: lastName,
                          newLast: _profileCubit.lastNameEditController.text);
                    },
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  CustomTextFormField(
                    validator: (value) {
                      final ans = Validator.hasMinLength(value);
                      return ans ? null : localization.nameLessThanTwo;
                    },
                    controller: _profileCubit.lastNameEditController,
                    labelText: localization.lastName,
                    icon: Icons.person,
                    onChanged: (value) {
                      _profileCubit.updateInfo(
                          curphoneNumber: phoneNumber,
                          newPhoneNumber:
                              _profileCubit.phoneNumberController.text,
                          curFirst: firstName,
                          curFirstAr: firstNameAr,
                          newFirstAr:
                              _profileCubit.firstNameArEditController.text,
                          curLastAr: lastNameAr,
                          newLastAr:
                              _profileCubit.lastNameArEditController.text,
                          newFirst: _profileCubit.firstNameEditController.text,
                          curLast: lastName,
                          newLast: _profileCubit.lastNameEditController.text);
                    },
                  ),
                  SizedBox(height: 50.h),
                  CustomTextFormField(
                    controller: _profileCubit.phoneNumberController,
                    labelText: localization.phoneNumber,
                    icon: Icons.phone,
                    onChanged: (value) {
                      _profileCubit.updateInfo(
                          curphoneNumber: phoneNumber,
                          newPhoneNumber:
                              _profileCubit.phoneNumberController.text,
                          curFirst: firstName,
                          curFirstAr: firstNameAr,
                          newFirstAr:
                              _profileCubit.firstNameArEditController.text,
                          curLastAr: lastNameAr,
                          newLastAr:
                              _profileCubit.lastNameArEditController.text,
                          newFirst: _profileCubit.firstNameEditController.text,
                          curLast: lastName,
                          newLast: _profileCubit.lastNameEditController.text);
                    },
                  ),
                  SizedBox(height: 30.h),
                  BlocBuilder<ProfileCubit, ProfileStates>(
                      buildWhen: (pre, cur) {
                    if (cur is IsUpdated || cur is IsNotUpdated) return true;
                    return false;
                  }, builder: (context, state) {
                    if (state is IsUpdated) {
                      return BlocListener<ProfileCubit, ProfileStates>(
                        listenWhen: (pre, cur) {
                          if (cur is UpdateLoading ||
                              cur is UpdateError ||
                              cur is UpdateSuccess) {
                            return true;
                          }
                          return false;
                        },
                        listener: (context, state) {
                          if (state is UpdateLoading) {
                            UIUtils.showLoadingDialog(context);
                          } else if (state is UpdateError) {
                            UIUtils.hideLoading(context);
                            UIUtils.showMessage(state.message);
                          } else if (state is UpdateSuccess) {
                            UIUtils.hideLoading(context);
                            Navigator.of(context).pop();
                            _profileCubit.getUserRole();
                          }
                        },
                        child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                if (typeAccount == 'Client') {
                                  _profileCubit.updateClientProfile();
                                } else {
                                  _profileCubit.updateProviderProfile(1);
                                }
                                return;
                              } else {
                                return;
                              }
                            },
                            child: Text(localization.save)),
                      );
                    } else {
                      return const SizedBox();
                    }
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
