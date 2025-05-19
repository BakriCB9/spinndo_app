import 'dart:io';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/routes/routes.dart';
import 'package:app/features/auth/presentation/cubit/cubit/register_cubit.dart';
import 'package:app/features/auth/presentation/cubit/cubit/register_state.dart';
import 'package:app/features/auth/presentation/widget/custom_auth_form.dart';
import 'package:app/features/auth/presentation/widget/section_certificate_image.dart';
import 'package:app/features/auth/presentation/widget/section_protofile_image.dart';
import 'package:app/features/discount/presentation/view_model/cubit/discount_view_model_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/utils/ui_utils.dart';
import 'package:app/features/auth/data/models/register_service_provider_request.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeplomaProtofileImageScreen extends StatefulWidget {
  DeplomaProtofileImageScreen({this.registerCubit, super.key});
  RegisterCubit? registerCubit;
  static const String routeName = '/deploma';

  @override
  State<DeplomaProtofileImageScreen> createState() =>
      _DeplomaProtofileImageScreenState();
}

class _DeplomaProtofileImageScreenState
    extends State<DeplomaProtofileImageScreen> {
  final drawerCubit = serviceLocator.get<DrawerCubit>();

  @override
  Widget build(BuildContext context) {
    final isDarkMode = drawerCubit.themeMode == ThemeMode.dark;
    final localization = AppLocalizations.of(context)!;
    final theme = Theme.of(context).textTheme;
    return Container(
      decoration: isDarkMode
          ? const BoxDecoration(
          color: ColorManager.darkBg
      ): null,
      child: CustomAuthForm(
        hasAvatar: false,
        hasTitle: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(localization.uploadCertificateImage,
                  style: theme.titleLarge!.copyWith(fontSize: 40.sp)),
              SizedBox(height: 50.h),
              SectionCertificateImage(registerCubit: widget.registerCubit!),

              SizedBox(height: 50.h),

              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(localization.uploadProtofileImage,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 40.sp)),
              ),
              SizedBox(height: 50.h),

              SectionProtofileImage(registerCubit: widget.registerCubit!),

              
              SizedBox(height: 20.h),
              SizedBox(height: 30.h),
              BlocListener<RegisterCubit, RegisterState>(
                bloc: widget.registerCubit,
                listener: (context, state) {
                  if (state.registerProviderState is BaseLoadingState) {
                    UIUtils.showLoadingDialog(context);
                  } else if (state.registerProviderState is BaseErrorState) {
                    final message =
                        state.registerProviderState as BaseErrorState;
                    UIUtils.hideLoading(context);
                    UIUtils.showMessage(message.error!);
                    widget.registerCubit!.listOfFileImagesProtofile
                        .add(File(""));
                  } else if (state.registerProviderState is BaseSuccessState) {
                    UIUtils.hideLoading(context);
                    Navigator.of(context).pushNamed(Routes.verificationRoutes,
                        arguments: widget.registerCubit!.emailController.text);
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 20.h),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (widget.registerCubit!.certificateImage == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                localization.youhavetouploadCertificateimage,
                                style: TextStyle(
                                    fontSize: 28.sp, color: Colors.white)),
                          ),
                        );
                        return;
                      }
                      widget.registerCubit!.listOfFileImagesProtofile
                          .removeLast();
                      try {
                        widget.registerCubit!.registerService(RegisterServiceProviderRequest(
                            websiteService: widget.registerCubit!
                                    .websiteController.text.isEmpty
                                ? null
                                : widget.registerCubit!.websiteController.text,
                            phone: widget.registerCubit!.countryCode +
                                widget
                                    .registerCubit!.phoneNumberController.text,
                            firstNameAr: widget
                                .registerCubit!.firstNameArcontroller.text,
                            lastNameAr:
                                widget.registerCubit!.lastNameArCOntroller.text,
                            firstName:
                                widget.registerCubit!.firstNameContoller.text,
                            lastName:
                                widget.registerCubit!.lastNameContoller.text,
                            email: widget.registerCubit!.emailController.text,
                            listOfDay: widget.registerCubit!.dateSelect,
                            password:
                                widget.registerCubit!.passwordController.text,
                            nameService: widget
                                .registerCubit!.serviceNameController.text,
                            descriptionService: widget.registerCubit!
                                .serviceDescriptionController.text,
                            categoryIdService: widget
                                .registerCubit!.selectedCategory!.id
                                .toString(),
                            cityNameService: widget.registerCubit!.countryName!,
                            certificate: widget.registerCubit!.certificateImage!,
                            latitudeService: widget.registerCubit!.lat!.toString(),
                            longitudeService: widget.registerCubit!.lang!.toString(),
                            images: widget.registerCubit!.listOfFileImagesProtofile));
                      } catch (e) {
                        widget.registerCubit!.listOfFileImagesProtofile
                            .add(File(''));
                      }
                    },
                    child: Text(localization.signUp,
                        style: Theme.of(context).textTheme.bodyLarge),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
