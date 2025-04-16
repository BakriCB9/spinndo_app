import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/utils/ui_utils.dart';
import 'package:app/core/widgets/custom_text_form_field.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:app/features/service_requist/data/model/request_model/update_my_service_request.dart';
import 'package:app/features/service_requist/doamin/entity/get_service_entity.dart';
import 'package:app/features/service_requist/presentation/view-model/cubit/service_request_cubit.dart';
import 'package:app/features/service_requist/presentation/view-model/cubit/service_request_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddServiceRequestScreen extends StatefulWidget {
  final ServiceRequestEntity? serviceRequestEntity;
  final int? userId;
  const AddServiceRequestScreen({
    super.key,
    this.userId,
    this.serviceRequestEntity,
  });
  static const String routeName = 'addService';
  @override
  State<AddServiceRequestScreen> createState() =>
      _AddServiceRequestScreenState();
}

class _AddServiceRequestScreenState extends State<AddServiceRequestScreen> {
  late final _drawerCubit;
  late GlobalKey<FormState> _keyform;
  //late ServiceRequestCubit _serviceRequestCubit;
  @override
  void initState() {
    _keyform = GlobalKey<FormState>();
    // _serviceRequestCubit = serviceLocator.get<ServiceRequestCubit>();
    _drawerCubit = serviceLocator.get<DrawerCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _serviceRequestCubit = BlocProvider.of<ServiceRequestCubit>(context);
    if (widget.serviceRequestEntity != null) {
      _serviceRequestCubit.titleController.text =
          widget.serviceRequestEntity!.title!;
      _serviceRequestCubit.descriptionController.text =
          widget.serviceRequestEntity!.desCription!;
      _serviceRequestCubit.durationController.text =
          widget.serviceRequestEntity!.dayDuration!.toString();

      _serviceRequestCubit.priceController.text =
          widget.serviceRequestEntity!.price!.toString();
    }
    final localization = AppLocalizations.of(context)!;
    final theme = Theme.of(context).textTheme;
    return Container(
      decoration: _drawerCubit.themeMode == ThemeMode.dark
          ? const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("asset/images/bg.png"), fit: BoxFit.fill))
          : null,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.serviceRequestEntity != null
              ? localization.save
              : localization.addRequest),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Form(
              key: _keyform,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(localization.title, style: theme.labelLarge),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return localization.requiredTitle;
                      }
                      return null;
                    },
                    controller: _serviceRequestCubit.titleController,
                    hintText: localization.enterTheTitle,
                  ),
                  const SizedBox(height: 25),
                  Text(localization.description, style: theme.labelLarge),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return localization.requiredDescrip;
                      }
                    },
                    controller: _serviceRequestCubit.descriptionController,
                    hintText: localization.enterTheDescrip,
                  ),
                  const SizedBox(height: 25),
                  Text(localization.price, style: theme.labelLarge),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return localization.requiredPrice;
                      }
                    },
                    controller: _serviceRequestCubit.priceController,
                    hintText: localization.entertheprice,
                    keyboardType: const TextInputType.numberWithOptions(),
                  ),
                  const SizedBox(height: 25),
                  Text(localization.duration, style: theme.labelLarge),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return localization.requirdDuration;
                      }
                    },
                    keyboardType: const TextInputType.numberWithOptions(),
                    controller: _serviceRequestCubit.durationController,
                    hintText: localization.entertheDuration,
                  ),
                  const SizedBox(height: 50),
                  SizedBox(
                    width: double.infinity,
                    child:
                        BlocListener<ServiceRequestCubit, ServiceRequestState>(
                      bloc: _serviceRequestCubit,
                      listener: (context, state) {
                        if (state.createServiceState is BaseLoadingState ||
                            state.updateServiceState is BaseLoadingState) {
                          UIUtils.showLoading(context);
                        } else if (state.createServiceState is BaseErrorState ||
                            state.updateServiceState is BaseErrorState) {
                          final errorState;

                          if (state.createServiceState is BaseErrorState) {
                            errorState =
                                state.createServiceState as BaseErrorState;
                          } else {
                            errorState =
                                state.updateServiceState as BaseErrorState;
                          }

                          UIUtils.hideLoading(context);
                          UIUtils.showMessage(errorState.error!);
                        } else if (state.createServiceState
                                is BaseSuccessState ||
                            state.updateServiceState is BaseSuccessState) {
                          UIUtils.hideLoading(context);

                          UIUtils.showMessage('Successs');
                          // _serviceRequestCubit.getServiceRequest(widget.userId);
                          //context.read<ServiceRequestCubit>().getServiceRequest(widget.userId);
                          Navigator.of(context).pop();
                          // if(state.createServiceState is BaseSuccessState){
                          //   _serviceRequestCubit.getServiceRequest(widget.userId);
                          // }
                          // context.read<ServiceRequestCubit>().getServiceRequest(widget.userId);
                        }
                      },
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: ColorManager.primary),
                          onPressed: () {
                            if (!_keyform.currentState!.validate()) {
                              return;
                            }
                            final myservice = MyServiceRequest(
                              id: widget.serviceRequestEntity?.id,
                              desCription: _serviceRequestCubit
                                  .descriptionController.text,
                              dayDuration: int.parse(
                                  _serviceRequestCubit.durationController.text),
                              price: double.parse(
                                  _serviceRequestCubit.priceController.text),
                              title: _serviceRequestCubit.titleController.text,
                            );
                            if (widget.serviceRequestEntity != null) {
                              _serviceRequestCubit.updateRequest(
                                  widget.serviceRequestEntity!.id!, myservice);
                              return;
                            } else {
                              print('we are in create item now ');
                              _serviceRequestCubit.createRequest(myservice);
                            }
                          },
                          child: Text(widget.serviceRequestEntity != null
                              ? localization.saveEdit
                              : localization.addRequest)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
