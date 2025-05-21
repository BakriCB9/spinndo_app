import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/utils/ui_utils.dart';
import 'package:app/core/widgets/custom_text_form_field.dart';
import 'package:app/features/service_requist/doamin/entity/get_service_entity.dart';
import 'package:app/features/service_requist/presentation/view-model/cubit/service_request_cubit.dart';
import 'package:app/features/service_requist/presentation/view-model/cubit/service_request_state.dart';
import 'package:app/features/service_requist/presentation/view/add_service_request_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShowServiceRequest extends StatefulWidget {
  final int? userId;
  final ServiceRequestCubit serviceCubit;
  const ShowServiceRequest(
      {this.userId, required this.serviceCubit, super.key});

  @override
  State<ShowServiceRequest> createState() => _ShowServiceRequestState();
}

class _ShowServiceRequestState extends State<ShowServiceRequest> {
  //late ServiceRequestCubit serviceCubit;
  ValueNotifier<List<ServiceRequestEntity>> listOfService = ValueNotifier([]);
  // List<ServiceRequestEntity> listHelper = [
  //   ServiceRequestEntity(
  //       dayDuration: 20,
  //       desCription: 'bakdjsjsjsb',
  //       price: 154,
  //       title: 'bakkar',
  //       id: 1,
  //       userName: 'bakri haitham'),
  //   ServiceRequestEntity(
  //       dayDuration: 20,
  //       desCription: 'play every day',
  //       price: 154,
  //       title: 'amjad',
  //       id: 1,
  //       userName: 'Amjad haitham')
  // ];
  late ThemeData theme;
  late Size size;
  @override
  void initState() {
    widget.serviceCubit.getServiceRequest(widget.userId);
    // serviceCubit = serviceLocator.get<ServiceRequestCubit>()
    //   ..getServiceRequest(widget.userId);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    theme = Theme.of(context);
    size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant ShowServiceRequest oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: BlocConsumer<ServiceRequestCubit, ServiceRequestState>(
        listener: (context, state) {
          if (state.deleteServiceState is BaseLoadingState) {
            //UIUtils.showLoading(context);
          }
          if (state.deleteServiceState is BaseSuccessState) {
            //UIUtils.hideLoading(context);
            final ans = state.deleteServiceState as BaseSuccessState;
            UIUtils.showMessage(ans.data);
          } else if (state.deleteServiceState is BaseErrorState) {
            //UIUtils.hideLoading(context);
            final ans = state.deleteServiceState as BaseErrorState;
            UIUtils.showMessage(ans.error!);
          }
        },
        bloc: widget.serviceCubit,
        buildWhen: (cur, pre) {
          //print('the state now is currently ${cur}');
          if (cur.getServiceState is BaseLoadingState ||
              cur.getServiceState is BaseSuccessState ||
              cur.getServiceState is BaseErrorState) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          if (state.getServiceState is BaseLoadingState) {
            print(
                'we are stand in loading state of get now Loaddddddddddinnnnnnnnng');
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.getServiceState is BaseSuccessState) {
            final successState = state.getServiceState
            as BaseSuccessState<List<ServiceRequestEntity>>;
            listOfService.value = successState.data!;

            return successState.data!.isEmpty
                ? Column(
              children: [
                const Spacer(),
                SizedBox(
                  height: size.height / 3.5,
                  child: Lottie.asset(
                    'asset/animation/empty.json',
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'No items add yet!',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 30.sp),
                ),
                const Spacer(
                  flex: 2,
                ),
              ],
            )
                : Column(
              children: [
                widget.userId == null
                    ? TextFormField(
                  onChanged: (value) {
                    final list = successState.data!.where((e) {
                      return e.userName!
                          .toLowerCase()
                          .contains(value.toLowerCase());
                    }).toList();
                    listOfService.value = successState.data!;
                  },
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search by name'),
                  style: theme.textTheme.bodyMedium,
                )
                    : const SizedBox(),
                const SizedBox(height: 15),
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: listOfService,
                    builder: (context, list, _) {
                      return ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            // print(
                            //     'we print the data of card now my darling %%%%%%%%%%%%%%%%%%%%%%%% ${successState.data!.length} and the state is ${state}');
                            return Card(
                              color: theme.primaryColorDark,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        list[index].userImage == null
                                            ? const CircleAvatar(
                                            backgroundColor:
                                            ColorManager.primary,
                                            radius: 40,
                                            child: Icon(Icons.person,
                                                color: Colors.white,
                                                size: 35))
                                            : CircleAvatar(
                                          radius: 40,
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius
                                                .circular(40),
                                            child: CachedNetworkImage(
                                                imageUrl: list[
                                                index]
                                                    .userImage ??
                                                    ''),
                                          ),
                                        ),

                                        // Icon(
                                        //   Icons.person,
                                        //   color: theme.primaryColor,
                                        // ),
                                        Spacer(),
                                        widget.userId != null
                                            ? Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  Navigator.of(
                                                      context)
                                                      .push(MaterialPageRoute(
                                                      builder:
                                                          (context) {
                                                        return BlocProvider
                                                            .value(
                                                          value: widget
                                                              .serviceCubit,
                                                          child:
                                                          AddServiceRequestScreen(
                                                            serviceRequestEntity:
                                                            successState
                                                                .data![index],
                                                          ),
                                                        );
                                                      }));
                                                },
                                                icon: const Icon(
                                                    Icons.edit)),
                                            IconButton(
                                                onPressed: () {
                                                  showDialog(
                                                      context:
                                                      context,
                                                      builder:
                                                          (context) {
                                                        return AlertDialog(
                                                          backgroundColor:
                                                          theme
                                                              .primaryColorDark,
                                                          content:
                                                          Text(
                                                            localization
                                                                .areYouSureToDelete,
                                                            style: theme
                                                                .textTheme
                                                                .labelMedium,
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                                onPressed:
                                                                    () {
                                                                  Navigator.of(context).pop();
                                                                },
                                                                child:
                                                                Text(localization.cancel, style: theme.textTheme.bodySmall!.copyWith(color: ColorManager.red))),
                                                            TextButton(
                                                                onPressed:
                                                                    () {
                                                                  Navigator.pop(context);
                                                                  widget.serviceCubit.deleteRequest(successState.data![index].id!);
                                                                },
                                                                child:
                                                                Text(
                                                                  localization.ok,
                                                                  style: theme.textTheme.bodySmall!.copyWith(color: ColorManager.green),
                                                                )),
                                                          ],
                                                        );
                                                      });
                                                },
                                                icon: const Icon(
                                                    Icons.delete))
                                          ],
                                        )
                                            : const SizedBox()

                                        // Text()
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(children: [
                                      Icon(
                                        Icons.person,
                                        color: theme.primaryColor,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          '${list[index].userName}',
                                          style: theme
                                              .textTheme.bodyMedium!
                                              .copyWith(fontSize: 30.sp),
                                        ),
                                      ),
                                    ]),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.info,
                                          color: theme.primaryColor,
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            '${list[index].title}',
                                            style: theme
                                                .textTheme.bodyMedium!
                                                .copyWith(
                                                fontSize: 30.sp),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.description,
                                          color: theme.primaryColor,
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            '${list[index].desCription}',
                                            style: theme
                                                .textTheme.bodyMedium!
                                                .copyWith(
                                                fontSize: 30.sp),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.timelapse,
                                          color: theme.primaryColor,
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            '${list[index].status}',
                                            style: theme
                                                .textTheme.bodyMedium!
                                                .copyWith(
                                                fontSize: 30.sp),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.attach_money_sharp,
                                          color: theme.primaryColor,
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            '${list[index].price}',
                                            style: theme
                                                .textTheme.labelSmall!
                                                .copyWith(
                                                fontSize: 25.sp),
                                            maxLines: 1,
                                            overflow:
                                            TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        const Icon(
                                            Icons.access_time_filled),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                            child: Text(
                                              '${list[index].dayDuration} day',
                                              style:
                                              theme.textTheme.labelSmall,
                                            ))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                  ),
                ),
              ],
            );
          } else {
            //print('we are stand in errorrrrrrrrrrrrrrrrrrrrrrrrrrrr state now');
            //final errorState = state.getServiceState as BaseErrorState;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //  Text(errorState.error ?? ''),
                TextButton(
                    onPressed: () {
                      widget.serviceCubit.getServiceRequest(null);
                    },
                    child: const Text('Try again'))
              ],
            );
          }
        },
      ),
    );
  }
}
