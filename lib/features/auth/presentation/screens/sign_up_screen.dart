import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/core/di/service_locator.dart';
import 'package:snipp/core/resources/color_manager.dart';
import 'package:snipp/core/resources/theme_manager.dart';

// import 'package:snipp/core/di/service_locator.dart';
import 'package:snipp/core/widgets/custom_text_form_field.dart';
import 'package:snipp/features/auth/data/models/register_request.dart';
import 'package:snipp/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:snipp/features/auth/presentation/cubit/auth_states.dart';
import 'package:snipp/features/auth/presentation/screens/employee_details.dart';
import 'package:snipp/features/auth/presentation/widget/custom_auth_form.dart';
import 'package:snipp/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/utils/ui_utils.dart';
import '../../../../core/utils/validator.dart';
import 'sign_in_screen.dart';
import 'verfication_code_screen.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  static const String routeName = '/signup';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();

  final _authCubit = serviceLocator.get<AuthCubit>();

  @override
  Widget build(BuildContext context) {
    // double avatarRadius = MediaQuery.of(context).size.width * 0.3;
    final localization = AppLocalizations.of(context)!;

    return CustomAuthForm(
        child: Column(children: [
      Form(
        key: formKey,
        child: Column(
          children: [
            CustomTextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return localization.enterName;
                } else if (!Validator.hasMinLength(
                  value,
                  minLength: 2,
                )) {
                  return localization.nameLessThanTwo;
                }
                return null;
              },
              controller: _authCubit.firstNameContoller,
              icon: Icons.person,
              labelText: localization.firstName,
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomTextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return localization.enterName;
                } else if (!Validator.hasMinLength(
                  value,
                  minLength: 2,
                )) {
                  return localization.nameLessThanTwo;
                }
                return null;
              },
              controller: _authCubit.lastNameContoller,
              icon: Icons.person,
              labelText: localization.lastName,
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomTextFormField(
              validator: (value) {
                if (!Validator.isEmail(value)) {
                  return localization.validEmail;
                }
                return null;
              },
              controller: _authCubit.emailController,
              icon: Icons.email,
              labelText: localization.email,
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomTextFormField(
              validator: (value) {
                if (!Validator.isPassword(value)) {
                  return localization.passwordLessThanSix;
                }
                return null;
              },
              controller: _authCubit.passwordController,
              icon: Icons.lock,
              isPassword: true,
              labelText: localization.password,
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomTextFormField(
              validator: (value) {
                if (!Validator.isPassword(value)) {
                  return localization.passwordLessThanSix;
                } else if (_authCubit.passwordController.text !=
                    _authCubit.confirmPasswordController.text) {
                  return localization.passwordNotMatched;
                }
                return null;
              },
              controller: _authCubit.confirmPasswordController,
              icon: Icons.lock,
              isPassword: true,
              labelText: localization.confirmPassword,
            ),
          ],
        ),
      ),
      SizedBox(
        height: 20.h,
      ),
      BlocBuilder<AuthCubit, AuthState>(
        bloc: _authCubit,
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Radio<bool>(
                      value: true,
                      activeColor: ColorManager.primary,
                      hoverColor: ColorManager.primary,
                      groupValue: _authCubit.isClient,
                      onChanged: (value) {
                        _authCubit.onChooseAccountType(value!);
                      },
                    ),
                    Text(localization.client,
                        style: Theme.of(context).textTheme.bodyMedium)
                  ],
                ),
                SizedBox(width: 16.w),
                Row(
                  children: [
                    Radio<bool>(
                      activeColor: ColorManager.primary,
                      hoverColor: ColorManager.primary,
                      value: false,
                      groupValue: _authCubit.isClient,
                      onChanged: (value) {
                        _authCubit.onChooseAccountType(value!);
                      },
                    ),
                    Text(localization.employee,
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      BlocConsumer<AuthCubit, AuthState>(
          bloc: _authCubit,
          listener: (_, state) {
            if (state is RegisterLoading) {
              UIUtils.showLoading(context, 'asset/animation/loading.json');
            } else if (state is RegisterSuccess) {
              UIUtils.hideLoading(context);
              Navigator.of(context).pushNamed(
                VerficationCodeScreen.routeName,
              );
            } else if (state is RegisterError) {
              UIUtils.hideLoading(context);
              UIUtils.showMessage(state.message);
              if (state.message.contains("The email has already been taken.")) {
                Navigator.of(context).pushNamed(
                  VerficationCodeScreen.routeName,
                );
              }
            }
          },
          buildWhen: (previous, current) {
            if ((previous is AuthInitial || previous is ChooseAccountState) &&
                current is ChooseAccountState) {
              return true;
            }
            return false;
          },
          builder: (context, state) {
            return SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _register,
                child: Text(
                    _authCubit.isClient
                        ? localization.signUp
                        : localization.next,
                    style: Theme.of(context).textTheme.bodyLarge),
              ),
            );
          }),
      SizedBox(height: 20.h),
      Center(
          child: Padding(
        padding: EdgeInsets.only(bottom: 30.h),
        child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(SignInScreen.routeName);
            },
            child: Text(localization.alreadyHaveAccount,
                style: Theme.of(context).textTheme.titleMedium)),
      ))
    ]));
  }

  _register() {
    if (_authCubit.isClient) {
      if (formKey.currentState!.validate()) {
        _authCubit.register(RegisterRequest(
            first_name: _authCubit.firstNameContoller.text,
            last_name: _authCubit.lastNameContoller.text,
            email: _authCubit.emailController.text,
            password: _authCubit.passwordController.text));
      } else {
        return;
      }
    } else {
      if (formKey.currentState!.validate()) {
        Navigator.of(context).pushNamed(EmployeeDetails.routeName);
      } else {
        return;
      }
    }
  }
}
