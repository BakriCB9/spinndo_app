import 'package:app/core/utils/ui_utils.dart';
import 'package:app/core/utils/validator.dart';
import 'package:app/core/widgets/custom_text_form_field.dart';
import 'package:app/core/widgets/loading_indicator.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:app/features/profile/presentation/widget/section_update_location.dart';
import 'package:app/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:app/features/profile/presentation/cubit/profile_states.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditJobDetails extends StatelessWidget {
  final String categoryName;
  final String serviceName;
  final String cityName;
  final String description;
  final String lat;
  final String lng;
  final String? webSite;

  const EditJobDetails(
      {this.webSite,
      required this.categoryName,
      required this.description,
      required this.cityName,
      required this.serviceName,
      super.key,
      required this.lat,
      required this.lng});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final profileCubit = serviceLocator.get<ProfileCubit>();

    final drawerCubit = serviceLocator.get<DrawerCubit>();
    profileCubit.descriptionController.text = description;
    profileCubit.serviceNameController.text = serviceName;
    if(webSite!=null){
      profileCubit.webSiteController.text=webSite!;
    }

    return Container(
      decoration: drawerCubit.themeMode == ThemeMode.dark
          ? const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("asset/images/bg.png"), fit: BoxFit.fill))
          : null,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              localization.editJobDetails,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: BlocBuilder<ProfileCubit, ProfileStates>(buildWhen: (pre, cur) {
            if (cur is GetCategoryLoading ||
                cur is GetCategoryError ||
                cur is SelectedCategoryState ||
                cur is GetCategorySuccess) {
              return true;
            }
            return false;
          }, builder: (context, state) {
            if (state is GetCategoryLoading) {
              return const LoadingIndicator(Colors.yellow);
            } else if (state is GetCategoryError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return SingleChildScrollView(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 100.h),
                      CustomTextFormField(
                        validator: (value) {
                          return Validator.hasMinLength(value)
                              ? null
                              : localization.nameLessThanTwo;
                        },
                        icon: Icons.home_repair_service_sharp,
                        labelText: localization.titleService,
                        controller: profileCubit.serviceNameController,
                        onChanged: (value) {
                          profileCubit.updateJobDetails(
                              curWebSite: webSite??'',
                              newWebSite: profileCubit.webSiteController.text,
                              curServiceName: serviceName,
                              newServiceName:
                                  profileCubit.serviceNameController.text,
                              curDescription: description,
                              newDescription:
                                  profileCubit.descriptionController.text);
                        },
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      CustomTextFormField(
                        validator: (value) {
                          return Validator.hasMinLength(value)
                              ? null
                              : localization.nameLessThanTwo;
                        },
                        icon: Icons.description,
                        labelText: localization.description,
                        controller: profileCubit.descriptionController,
                        onChanged: (value) {
                          profileCubit.updateJobDetails(
                              curWebSite: webSite??'',
                              newWebSite: profileCubit.webSiteController.text,
                              curServiceName: serviceName,
                              newServiceName:
                                  profileCubit.serviceNameController.text,
                              curDescription: description,
                              newDescription:
                                  profileCubit.descriptionController.text);
                        },
                      ),
                      SizedBox(height: 50.h),
                      CustomTextFormField(
                        validator: (value) {
                          return Validator.isWebsite(value)?null:localization.webSiteInvalide;
                        },
                        icon: Icons.link,
                        labelText: localization.webSite ,
                        controller: profileCubit.webSiteController,
                        onChanged: (value) {
                          profileCubit.updateJobDetails(
                              curWebSite: webSite??'',
                              newWebSite: profileCubit.webSiteController.text,
                              curServiceName: serviceName,
                              newServiceName:
                                  profileCubit.serviceNameController.text,
                              curDescription: description,
                              newDescription:
                                  profileCubit.descriptionController.text);
                        },
                      ),
                      SizedBox(height: 50.h),
                      BlocBuilder<ProfileCubit, ProfileStates>(
                        bloc: profileCubit,
                        builder: (context, state) {
                          return CascadingDropdowns(
                            categories: profileCubit.categoriesList,
                            isProfile: true,
                          );
                        },
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      SectionUpdateLocation(
                        cityName: cityName,
                        profileCubit: profileCubit,
                      ),
                      SizedBox(height: 40.h),
                      BlocBuilder<ProfileCubit, ProfileStates>(
                          buildWhen: (pre, cur) {
                        if (cur is IsUpdated || cur is IsNotUpdated)
                          return true;
                        return false;
                      }, builder: (context, state) {
                        if (state is IsUpdated) {
                          return BlocListener(
                            bloc: profileCubit,
                            listener: (context, state) {
                              if (state is UpdateLoading) {
                                UIUtils.showLoading(context);
                              } else if (state is UpdateError) {
                                UIUtils.hideLoading(context);
                                UIUtils.showMessage(state.message);
                              } else if (state is UpdateSuccess) {
                                UIUtils.hideLoading(context);
                                profileCubit.getUserRole();
                                Navigator.of(context).pop();
                              }
                            },
                            child: ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    profileCubit.updateProviderProfile(2);
                                    return;
                                  }
                                  return;
                                },
                                child: Text(localization.save)),
                          );
                        } else if (state is IsNotUpdated) {
                          return const SizedBox();
                        } else {
                          return const SizedBox();
                        }
                      })
                    ],
                  ),
                ),
              ));
            }
          })),
    );
  }
}
