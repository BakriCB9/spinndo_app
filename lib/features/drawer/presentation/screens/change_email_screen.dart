import 'package:app/core/const_variable.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/routes/routes.dart';
import 'package:app/core/utils/ui_utils.dart';
import 'package:app/core/widgets/custom_text_form_field.dart';
import 'package:app/features/drawer/data/model/change_email/change_email_request.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change email'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              CustomTextFormField(
                  labelText: 'current Email', controller: _oldEmailController),
              const SizedBox(height: 30),
              CustomTextFormField(
                  labelText: 'new Email', controller: _newEmailController),
              const SizedBox(height: 30),
              BlocListener<DrawerCubit, DrawerStates>(
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
            ],
          ),
        ),
      ),
    );
  }
}
