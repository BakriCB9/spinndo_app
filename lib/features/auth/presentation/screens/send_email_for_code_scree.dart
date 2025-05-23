import 'package:app/core/const_variable.dart';
import 'package:app/core/routes/routes.dart';
import 'package:app/core/utils/ui_utils.dart';
import 'package:app/core/utils/validator.dart';
import 'package:app/core/widgets/custom_text_form_field.dart';
import 'package:app/features/auth/data/models/resend_code_request.dart';
import 'package:app/features/auth/presentation/cubit/cubit/login_cubit.dart';
import 'package:app/features/auth/presentation/cubit/cubit/login_state.dart';
import 'package:app/features/discount/presentation/view_model/cubit/discount_view_model_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SendEmailForCodeScreen extends StatefulWidget {
  const SendEmailForCodeScreen({super.key});

  @override
  State<SendEmailForCodeScreen> createState() => _SendEmailForCodeScreenState();
}

class _SendEmailForCodeScreenState extends State<SendEmailForCodeScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loginCubit = BlocProvider.of<LoginCubit>(context);
    final localization = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              Text(
                localization.forgetPassword,
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              Text(
                localization.enterEmailAssociated,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: 50),
              Form(
                key: _formKey,
                child: CustomTextFormField(
                  validator: (value) {
                    return Validator.isEmail(value)
                        ? null
                        : localization.validEmail;
                  },
                  controller: _emailController,
                  labelText: localization.email,
                  icon: Icons.email,
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: BlocListener<LoginCubit, LoginState>(
                  bloc: loginCubit,
                  listenWhen: (pre, cur) {
                    if (pre.sendCodeState != cur.sendCodeState) return true;
                    return false;
                  },
                  listener: (context, state) {
                    if (state.sendCodeState is BaseLoadingState) {
                      UIUtils.showLoadingDialog(context);
                    } else if (state.sendCodeState is BaseErrorState) {
                      UIUtils.hideLoading(context);
                      UIUtils.showMessage(
                          (state.sendCodeState as BaseErrorState).error!);
                    } else if (state.sendCodeState is BaseSuccessState) {
                      UIUtils.hideLoading(context);
                      Navigator.of(context)
                          .pushNamed(Routes.verificationRoutes, arguments: {
                        'email': _emailController.text,
                        'type': TypeVerificationComing.comeFromForgetPassword,
                        'cubit': loginCubit
                      });
                    }
                  },
                  child: ElevatedButton(

                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          loginCubit.resendCode(
                              ResendCodeRequest(email: _emailController.text));
                          return;
                        }
                        return;
                      },
                      child: Text(localization.confirm)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
