import 'package:app/core/const_variable.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/routes/routes.dart';
import 'package:app/core/utils/ui_utils.dart';
import 'package:app/core/widgets/custom_appbar.dart';
import 'package:app/core/widgets/custom_text_form_field.dart';
import 'package:app/features/drawer/data/model/change_email/change_email_request.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ChangeEmailScreen extends StatefulWidget {
  const ChangeEmailScreen({super.key});

  @override
  State<ChangeEmailScreen> createState() => _ChangeEmailScreenState();
}

class _ChangeEmailScreenState extends State<ChangeEmailScreen> {
  final TextEditingController _oldEmailController = TextEditingController();
  final TextEditingController _newEmailController = TextEditingController();
  final _drawerCubit = serviceLocator.get<DrawerCubit>();
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppbar(appBarText: localization.changeEmail),
            SizedBox(height: 30.h,),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 46.w),
              child: CustomTextFormField(
                  labelText: 'current Email', controller: _oldEmailController),
            ),
            const SizedBox(height: 30),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 46.w),
              child: CustomTextFormField(
                  labelText: 'new Email', controller: _newEmailController),
            ),
            const SizedBox(height: 30),
            Padding(

              padding:  EdgeInsets.symmetric(horizontal: 46.w),
              child: SizedBox(
                width: double.infinity,

                child: BlocListener<DrawerCubit, DrawerStates>(
                  bloc: _drawerCubit,
                  listener: (context, state) {
                    if (state is ChangeEmailLoadingState) {
                      UIUtils.showLoadingDialog(context);
                    } else if (state is ChangeEmailErrorState) {
                      UIUtils.hideLoading(context);
                      UIUtils.showMessage(state.message);
                    } else if (state is ChangeEmailSuccessState) {
                      UIUtils.hideLoading(context);
                      Navigator.of(context).pushNamed(Routes.verificationRoutes,
                          arguments: {'email': _newEmailController.text,'type':TypeVerificationComing.comeFromChangeEmail});
                    }
                  },
                  child: ElevatedButton(
                    onPressed: () {
                      _drawerCubit.changeEmail(ChangeEmailRequest(
                          newEmail: _newEmailController.text,
                          oldEmail: _oldEmailController.text));
                    },
                    child: Text('Save'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
