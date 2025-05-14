import 'package:app/core/constant.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/utils/ui_utils.dart';
import 'package:app/core/widgets/cash_network.dart';
import 'package:app/features/discount/domain/entity/all_discount_entity.dart';
import 'package:app/features/discount/presentation/view_model/cubit/discount_view_model_cubit.dart';
import 'package:app/features/service/presentation/cubit/service_cubit.dart';
import 'package:app/features/service/presentation/cubit/service_setting_cubit.dart';
import 'package:app/features/service/presentation/cubit/service_states.dart';
import 'package:app/features/service/presentation/screens/show_details.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowDiscount extends StatefulWidget {
  @override
  _ShowDiscountState createState() => _ShowDiscountState();
}

class _ShowDiscountState extends State<ShowDiscount> {
  final serviceCubit = serviceLocator.get<ServiceSettingCubit>();
  @override
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return BlocBuilder<ServiceSettingCubit, ServiceSettingState>(
      buildWhen: (cur, pre) {
        if (pre.getAllDiscountState != cur.getAllDiscountState) {
          return true;
        }
        return false;
      },
      bloc: serviceCubit,
      builder: (context, state) {
        if (state.getAllDiscountState is BaseLoadingState) {
          return const Center(
              child: CircularProgressIndicator(color: ColorManager.primary));
        } else if (state.getAllDiscountState is BaseErrorState) {
          return const SizedBox();
          //return Center(child: Text(state.message, style: GoogleFonts.poppins(color: Colors.red)));
        } else if (state.getAllDiscountState is BaseSuccessState) {
          final listAllDiscount = (state.getAllDiscountState
                  as BaseSuccessState<List<AllDiscountEntity>>)
              .data;
          return listAllDiscount!.isEmpty
              ? const SizedBox()
              : SizedBox(
                  height: 300.h,
                  child: PageView.builder(
                      itemCount: listAllDiscount.length,
                      controller: PageController(viewportFraction: 0.8),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: GestureDetector(
                            onTap: () {
                              if (sharedPref
                                      .getString(CacheConstant.tokenKey) ==
                                  null) {
                                UIUtils.showMessage(
                                    "You have to Sign in first");
                                return;
                              }
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ShowDetails(
                                      id: listAllDiscount[index].providerId!),
                                ),
                              );
                            },
                            child: Card(
                              color: ColorManager.primary,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 10.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        listAllDiscount[index].image != null
                                            ? CircleAvatar(
                                                radius: 60.r,
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            60.r),
                                                    child: CashImage(
                                                        path: listAllDiscount[
                                                                index]
                                                            .image!)),
                                              )
                                            : CircleAvatar(
                                                radius: 60.r,
                                                backgroundColor:
                                                    ColorManager.primary,
                                                child: Icon(Icons.person,
                                                    size: 60.r,
                                                    color: ColorManager.white),
                                              ),
                                        SizedBox(width: 10.h),
                                        Text(
                                          listAllDiscount[index].providerName ??
                                              '',
                                          style: theme.labelMedium,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5.h),
                                    Text(
                                      'discount code: ${listAllDiscount[index].discountCode ?? ''}',
                                      style: theme.labelMedium,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                    SizedBox(height: 5.h),
                                    Text(
                                      'discount value: ${listAllDiscount[index].discount}',
                                      style: theme.labelMedium,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
