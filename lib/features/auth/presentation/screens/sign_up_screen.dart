import 'package:app/features/auth/presentation/widget/section_remember_me.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/widgets/custom_text_form_field.dart';
import 'package:app/features/auth/data/models/register_request.dart';
import 'package:app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:app/features/auth/presentation/cubit/auth_states.dart';
import 'package:app/features/auth/presentation/screens/employee_details.dart';
import 'package:app/features/auth/presentation/widget/custom_auth_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import '../../../../core/utils/ui_utils.dart';
import '../../../../core/utils/validator.dart';
import 'sign_in_screen.dart';
import 'verfication_code_screen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  static const String routeName = '/signup';

  final formKey = GlobalKey<FormState>();

  final _authCubit = serviceLocator.get<AuthCubit>();
  final _drawerCubit = serviceLocator.get<DrawerCubit>();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return CustomAuthForm(
        canBack: false,
        isGuest: true,
        child: Column(children: [
          SizedBox(
            height: 60.h,
          ),
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
                  controller: _authCubit.firstNameArcontroller,
                  icon: Icons.person,
                  labelText: 'First name ar',
                ),
                SizedBox(
                  height: 30.h,
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
                  controller: _authCubit.lastNameArCOntroller,
                  icon: Icons.person,
                  labelText: 'Last name ar',
                ),
                SizedBox(
                  height: 30.h,
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
                  controller: _authCubit.firstNameContoller,
                  icon: Icons.person,
                  labelText: localization.firstName,
                ),
                SizedBox(
                  height: 30.h,
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
                  height: 30.h,
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
                  height: 30.h,
                ),
                CustomTextFormField(
                  controller: _authCubit.phoneNumberController,
                  labelText: 'Phone Number',
                  icon: Icons.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return localization.validEmail;
                    }
                    if (!Validator.isEGPhoneNumber(value)) {
                      return localization.valideCorrectPhoneNumber;
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 30.h,
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
                SizedBox(height: 30.h),
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
          SectionRememberMe(
            authCubit: _authCubit,
          ),
          SizedBox(
            height: 20.h,
          ),
          BlocBuilder<AuthCubit, AuthState>(
            bloc: _authCubit,
            buildWhen: (previous, current) {
              if (current is ChooseAccountState) {
                return true;
              }
              return false;
            },
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
                }
                if (state is GetCategoryLoading) {
                  UIUtils.showLoading(context, 'asset/animation/loading.json');
                } else if (state is GetCategorySuccess) {
                  UIUtils.hideLoading(context);
                  Navigator.of(context).pushNamed(EmployeeDetails.routeName);
                } else if (state is GetCategoryError) {
                  UIUtils.hideLoading(context);
                  UIUtils.showMessage(state.message);
                }
              },
              buildWhen: (previous, current) {
                if (
                    //(previous is AuthInitial || previous is ChooseAccountState) &&
                    current is ChooseAccountState) {
                  return true;
                }
                return false;
              },
              builder: (context, state) {
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _register(context);
                    },
                    child: Text(
                        _authCubit.isClient
                            ? localization.signUp
                            : localization.next,
                        style: Theme.of(context).textTheme.bodyLarge),
                  ),
                );
              }),
          SizedBox(height: 30.h),
          Center(
              child: InkWell(
                  onTap: () {
                    _authCubit.emailController.clear();
                    _authCubit.passwordController.clear();
                    _authCubit.confirmPasswordController.clear();
                    _authCubit.firstNameContoller.clear();
                    _authCubit.lastNameContoller.clear();
                    _authCubit.firstNameArcontroller.clear();
                    _authCubit.lastNameArCOntroller.clear();
                    Navigator.of(context)
                        .pushReplacementNamed(SignInScreen.routeName);
                  },
                  child: Text(localization.alreadyHaveAccount,
                      style: Theme.of(context).textTheme.titleMedium))),
          SizedBox(
            height: 100.h,
          )
        ]));
  }

  _register(BuildContext context) {
    print("dddddddddddddd");
    print(_authCubit.firstNameContoller);
    print(_authCubit.lastNameContoller);
    print("dddddddddddddd");
    if (_authCubit.isClient) {
      if (formKey.currentState!.validate()) {
        _authCubit.register(RegisterRequest(
            first_name_ar: _authCubit.firstNameArcontroller.text,
            last_name_ar: _authCubit.lastNameArCOntroller.text,
            first_name: _authCubit.firstNameContoller.text,
            last_name: _authCubit.lastNameContoller.text,
            email: _authCubit.emailController.text,
            password: _authCubit.passwordController.text));
      } else {
        return;
      }
    } else {
      if (formKey.currentState!.validate()) {
        if (_authCubit.selectedCategory == null) {
          _authCubit.getCategories();
        } else {
          Navigator.of(context).pushNamed(EmployeeDetails.routeName);
        }
      } else {
        return;
      }
      // print('yes it else now RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR');
      // print(
      //     'the value of validate is now  ${formKey.currentState!.validate()}');
      // if (formKey.currentState!.validate() &&
      //     _authCubit.selectedCategory == null) {
      //   print('********************************');
      //   _authCubit.getCategories();
      //   print('we get the element nnow bakri');
      // } else {
      //   //_authCubit.getCategories();
      //   Navigator.of(context).pushNamed(EmployeeDetails.routeName);
      // }
    }
  }
}
