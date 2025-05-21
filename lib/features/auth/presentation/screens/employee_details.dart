import 'package:app/features/auth/presentation/cubit/cubit/register_cubit.dart';
import 'package:app/features/auth/presentation/cubit/cubit/register_state.dart';
import 'package:app/features/auth/presentation/widget/custom_auth_form.dart';
import 'package:app/features/auth/presentation/widget/section_day_select.dart';
import 'package:app/features/auth/presentation/widget/section_location.dart';

import 'package:app/features/discount/presentation/view_model/cubit/discount_view_model_cubit.dart';
import 'package:app/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/core/utils/validator.dart';
import 'package:app/core/widgets/custom_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'deploma_protofile_image_screen.dart';

class EmployeeDetails extends StatefulWidget {
  const EmployeeDetails({super.key});

  static const String routeName = '/employee';

  @override
  State<EmployeeDetails> createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final registerCubit = BlocProvider.of<RegisterCubit>(context);
    final localization = AppLocalizations.of(context)!;
    return CustomAuthForm(
      child: Column(
        children: [
          SizedBox(height: 60.h),
          Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: 20.h),
                BlocBuilder<RegisterCubit, RegisterState>(
                  bloc: registerCubit,
                  builder: (context, state) {
                    if (state.getCategoryState is BaseSuccessState) {
                      final result = state.getCategoryState as BaseSuccessState;
                      return CascadingDropdowns(
                          authCubit: registerCubit, categories: result.data);
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                CustomTextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return localization.nameLessThanTwo;
                    } else if (!Validator.hasMinLength(
                      value,
                      minLength: 2,
                    )) {
                      return localization.nameLessThanTwo;
                    }
                    return null;
                  },
                  controller: registerCubit.serviceNameController,
                  icon: Icons.work,
                  labelText: localization.jobTitle,
                ),
                SizedBox(height: 40.h),
                CustomTextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return localization.nameLessThanTwo;
                    } else if (!Validator.hasMinLength(
                      value,
                      minLength: 2,
                    )) {
                      return localization.nameLessThanTwo;
                    }
                    return null;
                  },
                  controller: registerCubit.serviceDescriptionController,
                  icon: Icons.description,
                  labelText: localization.description,
                  maxLines: 5,
                  minLines: 1,
                ),
                SizedBox(height: 40.h),
                //TODOdd

                SectionLocation(
                  registerCubit: registerCubit,
                ),
                //TODOd
                SizedBox(height: 40.h),
                CustomTextFormField(
                  controller: registerCubit.websiteController,
                  labelText: 'WebSite',
                  icon: Icons.web,
                ),
                SizedBox(height: 40.h),
                //TODO
                SectionDaySelect(registerCubit: registerCubit),
                //TODO
                SizedBox(height: 40.h),
                Container(
                  margin: EdgeInsets.only(bottom: 30.h),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        final ans = registerCubit.isAnotherDaySelected();
                        if (ans &&
                            registerCubit.countryName != null &&
                            registerCubit.selectedCategory != null) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => DeplomaProtofileImageScreen(
                                registerCubit: registerCubit,
                              )));

                          return;
                        } else {
                          if (registerCubit.selectedCategory == null) {
                            showSnackBar(localization.categoryRequired);
                          } else if (registerCubit.countryName == null) {
                            showSnackBar(localization.locationRequired);
                          } else {
                            showSnackBar(
                                localization.atleastonedaymustbeselected);
                          }
                        }
                      }
                      return;
                    },
                    child: Text(localization.next,
                        style: Theme.of(context).textTheme.bodyLarge),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  showSnackBar(String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(content,
              style: TextStyle(fontSize: 28.sp, color: Colors.white))),
    );
  }
}