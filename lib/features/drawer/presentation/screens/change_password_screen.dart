import 'package:app/core/di/service_locator.dart';
import 'package:app/core/utils/ui_utils.dart';
import 'package:app/core/utils/validator.dart';
import 'package:app/core/widgets/custom_text_form_field.dart';
import 'package:app/features/drawer/data/model/change_password_request.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_states.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _newConfirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _drawerCubit = serviceLocator.get<DrawerCubit>();
  @override
  dispose() {
    super.dispose();
    _formKey;
    _currentPasswordController;
    _newConfirmPasswordController;
    _newConfirmPasswordController;
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change password'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50.h,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      validator: (value) {
                        final ans = Validator.isPassword(value);
                        if (!ans) {
                          return localization.passwordLessThanSix;
                        }
                        return null;
                      },
                      isPassword: true,
                      keyboardType: TextInputType.visiblePassword,
                      controller: _currentPasswordController,
                      labelText: 'Current Password',
                    ),
                    SizedBox(height: 50.h),
                    CustomTextFormField(
                      validator: (value) {
                        final ans = Validator.isPassword(value);
                        if (!ans) {
                          return localization.passwordLessThanSix;
                        }
                        return null;
                      },
                      isPassword: true,
                      keyboardType: TextInputType.visiblePassword,
                      controller: _newPasswordController,
                      labelText: 'New Passwrod',
                    ),
                    SizedBox(height: 50.h),
                    CustomTextFormField(
                      validator: (value) {
                        if (value!.length < 6) {
                          return localization.passwordLessThanSix;
                        } else {
                          if (value != _newConfirmPasswordController.text) {
                            return localization.passwordNotMatched;
                          }
                          return null;
                        }
                      },
                      isPassword: true,
                      keyboardType: TextInputType.visiblePassword,
                      controller: _newConfirmPasswordController,
                      labelText: 'Confirm new Password',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50.h),
              SizedBox(
                width: double.infinity,
                child: BlocListener<DrawerCubit, DrawerStates>(
                  bloc: _drawerCubit,
                  listener: (context, state) {
                    if (state is ChangePasswordLoadingState) {
                      UIUtils.showLoading(context);
                    } else if (state is ChangePasswordSuccessState) {
                      UIUtils.hideLoading(context);
                      UIUtils.showMessage(state.data);
                      Navigator.of(context).pop();
                    } else if (state is ChangePasswordErrorState) {
                      UIUtils.hideLoading(context);
                      UIUtils.showMessage(state.message);
                    }
                  },
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 10)),
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        _drawerCubit.changePassword(ChangePasswordRequest(
                            currentPassword: _currentPasswordController.text,
                            newConfrimPassword: _newPasswordController.text,
                            newPassword: _newConfirmPasswordController.text));
                      },
                      child: const Text('Save Password')),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
