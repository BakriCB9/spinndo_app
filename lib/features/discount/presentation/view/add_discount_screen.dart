import 'package:app/core/constant.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/utils/ui_utils.dart';
import 'package:app/core/widgets/custom_text_form_field.dart';
import 'package:app/features/discount/data/model/discount_request/add_discount_request.dart';
import 'package:app/features/discount/presentation/view_model/cubit/discount_view_model_cubit.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DiscountScreen extends StatelessWidget {
  static const String routeName = 'discount';
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController discountCodeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final discountCubit = serviceLocator<DiscountViewModelCubit>();
    final localization = AppLocalizations.of(context)!;
    final _drawerCubit = serviceLocator.get<DrawerCubit>();
    final myId = sharedPref.getInt(CacheConstant.userId);
    return Container(
      decoration: _drawerCubit.themeMode == ThemeMode.dark
          ? const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("asset/images/bg.png"), fit: BoxFit.fill))
          : null,
      child: Scaffold(
        appBar: AppBar(title: Text(localization.disco)),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                      keyboardType: TextInputType.numberWithOptions(),
                      labelText: localization.discountLabel,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return localization.discountRequired;
                        } else if (int.parse(value) > 100) {
                          return "it must be less than 100";
                        }
                        return null;
                      },
                      controller: discountController),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                      labelText: localization.codeLabel,
                      
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return localization.codeRequired;
                        }
                      },
                      controller: discountCodeController),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: BlocListener<DiscountViewModelCubit,
                        DiscountViewModelState>(
                      bloc: discountCubit,
                      listener: (context, state) {
                        if (state.addDiscountState is BaseLoadingState) {
                          UIUtils.showLoading(context);
                        } else if (state.addDiscountState is BaseErrorState) {
                          final text = state.addDiscountState as BaseErrorState;
                          UIUtils.hideLoading(context);
                          UIUtils.showMessage(text.error!);
                        } else if (state.addDiscountState is BaseSuccessState) {
                          final text =
                              state.addDiscountState as BaseSuccessState;
                          UIUtils.hideLoading(context);

                          Navigator.of(context).pop();
                          UIUtils.showMessage(text.data);
                        }
                      },
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: ColorManager.primary),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              discountCubit.addDiscount(AddDiscountRequest(
                                  discount: int.parse(discountController.text),
                                  discountCode: discountCodeController.text,
                                  userId: myId!));
                            }
                          },
                          child: Text(
                            localization.addDiscount,
                            style: theme.bodyMedium,
                          )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
