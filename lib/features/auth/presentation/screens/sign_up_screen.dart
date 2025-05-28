import 'package:app/core/routes/routes.dart';
import 'package:app/core/utils/ui_utils.dart';
import 'package:app/core/utils/validator.dart';
import 'package:app/features/auth/presentation/cubit/cubit/register_cubit.dart';
import 'package:app/features/auth/presentation/cubit/cubit/register_state.dart';
import 'package:app/features/auth/presentation/widget/section_account_type.dart';
import 'package:app/features/auth/presentation/widget/section_remember_me.dart';
import 'package:app/features/discount/presentation/view_model/cubit/discount_view_model_cubit.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/widgets/custom_text_form_field.dart';
import 'package:app/features/auth/data/models/register_request.dart';
import 'package:app/features/auth/presentation/screens/employee_details.dart';
import 'package:app/features/auth/presentation/widget/custom_auth_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final _registerCubit = serviceLocator.get<RegisterCubit>();

  RegisterState? previousState;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final drawerCubit = serviceLocator.get<DrawerCubit>();

    return CustomAuthForm(
        canBack: false,

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(children: [
            SizedBox(height: 60.h),
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
                    controller: _registerCubit.firstNameArcontroller,
                    icon: Icons.person_2_outlined,
                    labelText: localization.firstNameAr,
                  ),
                  SizedBox(height: 30.h),
                  CustomTextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return localization.enterName;
                      } else if (!Validator.hasMinLength(value, minLength: 2)) {
                        return localization.nameLessThanTwo;
                      }
                      return null;
                    },
                    controller: _registerCubit.lastNameArCOntroller,
                    icon: Icons.person_2_outlined,
                    labelText: localization.lastNameAr,
                  ),
                  SizedBox(height: 30.h),
                  CustomTextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return localization.enterName;
                      } else if (!Validator.hasMinLength(value, minLength: 2)) {
                        return localization.nameLessThanTwo;
                      }
                      return null;
                    },
                    controller: _registerCubit.firstNameContoller,
                    icon: Icons.person_2_outlined,
                    labelText: localization.firstName,
                  ),
                  SizedBox(height: 30.h),
                  CustomTextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return localization.enterName;
                        } else if (!Validator.hasMinLength(value, minLength: 2)) {
                          return localization.nameLessThanTwo;
                        }
                        return null;
                      },
                      controller: _registerCubit.lastNameContoller,
                      icon: Icons.person_2_outlined,
                      labelText: localization.lastName),
                  SizedBox(height: 30.h),
                  CustomTextFormField(
                      validator: (value) {
                        if (!Validator.isEmail(value)) {
                          return localization.validEmail;
                        }
                        return null;
                      },
                      controller: _registerCubit.emailController,
                      icon: Icons.email_outlined,
                      labelText: localization.email),
                  SizedBox(height: 30.h),
                  Row(children: [
                    Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorDark,
                            borderRadius: BorderRadius.circular(25.r),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: CountryCodePicker(
                              barrierColor: Colors.grey.withOpacity(0.2),
                              dialogBackgroundColor:
                                  Theme.of(context).primaryColorDark,
                              flagWidth: 25,
                              textStyle: Theme.of(context).textTheme.bodyMedium,
                              padding: EdgeInsets.zero,
                              backgroundColor: Theme.of(context).primaryColorDark,
                              searchStyle: Theme.of(context).textTheme.bodyMedium,
                              onChanged: (value) {
                                _registerCubit.countryCode = value.dialCode!;
                              },
                              showCountryOnly: true,
                              showOnlyCountryWhenClosed: false,
                              alignLeft: true),
                        )),
                    SizedBox(width: 25.w),
                    Expanded(
                        flex: 3,
                        child: CustomTextFormField(
                            keyboardType: TextInputType.phone,
                            controller: _registerCubit.phoneNumberController,
                            labelText: localization.phoneNumber,
                            icon: Icons.phone_outlined,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return localization.validePhoneNumber;
                              }
                              return null;
                            }))
                  ]),
                  SizedBox(height: 30.h),
                  CustomTextFormField(
                      validator: (value) {
                        if (!Validator.isPassword(value)) {
                          return localization.passwordLessThanSix;
                        }
                        if (!RegExp(r'[A-Za-z]').hasMatch(value!)) {
                          return localization.passwordMustContainAtLeastOneLetter;
                        }
                        if (!RegExp(r'\d').hasMatch(value)) {
                          return localization.passwordMustContainAtLeastOneNumber;
                        }
                        return null;
                      },
                      controller: _registerCubit.passwordController,
                      icon: Icons.lock_outline_rounded,
                      isPassword: true,
                      labelText: localization.password),
                  SizedBox(height: 30.h),
                  CustomTextFormField(
                    validator: (value) {
                      if (!Validator.isPassword(value)) {
                        return localization.passwordLessThanSix;
                      } else if (_registerCubit.passwordController.text !=
                          _registerCubit.confirmPasswordController.text) {
                        return localization.passwordNotMatched;
                      }
                      return null;
                    },
                    controller: _registerCubit.confirmPasswordController,
                    icon: Icons.lock_outline_rounded,
                    isPassword: true,
                    labelText: localization.confirmPassword,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            SectionRememberMe(authCubit: _registerCubit),
            SizedBox(height: 20.h),
            SectionAccountType(authcubit: _registerCubit),
            BlocListener<RegisterCubit, RegisterState>(
                bloc: _registerCubit,
                listenWhen: (pre, cur) {
                  if (pre.registerClientState != cur.registerClientState ||
                      pre.getCategoryState != cur.getCategoryState) {
                    previousState = pre;
                    return true;
                  }
                  return false;
                },
                listener: (_, state) {
                  if (state.registerClientState is BaseLoadingState ||
                      state.getCategoryState is BaseLoadingState) {
                    UIUtils.showLoadingDialog(context);
                  } else if (state.registerClientState is BaseSuccessState) {
                    UIUtils.hideLoading(context);
                    Navigator.of(context).pushNamed(Routes.verificationRoutes,
                        arguments: {'email':_registerCubit.emailController.text});
                  } else if (state.registerClientState is BaseErrorState &&
                      previousState?.registerClientState !=
                          state.registerClientState) {
                    final result = state.registerClientState as BaseErrorState;
                    UIUtils.hideLoading(context);
                    UIUtils.showMessage(result.error!);
                  } else if (state.getCategoryState is BaseSuccessState &&
                      previousState?.getCategoryState != state.getCategoryState) {
                    UIUtils.hideLoading(context);
                    Navigator.of(context).pushNamed(Routes.employeDetails,
                        arguments: _registerCubit);

                  } else if (state.getCategoryState is BaseErrorState &&
                      previousState?.getCategoryState != state.getCategoryState) {
                    final result = state.getCategoryState as BaseErrorState;
                    UIUtils.hideLoading(context);
                    UIUtils.showMessage(result.error!);
                  }
                },
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            36),
                      ),
                    ),
                    onPressed: () {
                      _register(context);
                    },
                    child: Text(
                        _registerCubit.isClient
                            ? localization.signUp
                            : localization.next,
                        style: Theme.of(context).textTheme.bodyLarge),
                  ),
                )),
            SizedBox(height: 30.h),
            Center(
                child: InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed(Routes.loginRoute);
                    },
                    child: Text(localization.alreadyHaveAccount,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight:FontWeight.w400)))),
            SizedBox(height: 100.h)
          ]),
        ));
  }

  _register(BuildContext context) {
    if (formKey.currentState!.validate()) {
      if (_registerCubit.isClient) {
        _registerCubit.register(RegisterRequest(
            phoneNumber: _registerCubit.countryCode +
                _registerCubit.phoneNumberController.text,
            first_name_ar: _registerCubit.firstNameArcontroller.text,
            last_name_ar: _registerCubit.lastNameArCOntroller.text,
            first_name: _registerCubit.firstNameContoller.text,
            last_name: _registerCubit.lastNameContoller.text,
            email: _registerCubit.emailController.text,
            password: _registerCubit.passwordController.text));
      } else {
        if (_registerCubit.selectedCategory == null) {
          _registerCubit.getCategories();
        } else {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return BlocProvider.value(
              value: _registerCubit,
              child: EmployeeDetails(),
            );
          }));
        }
      }
    }
    return;
  }
}
