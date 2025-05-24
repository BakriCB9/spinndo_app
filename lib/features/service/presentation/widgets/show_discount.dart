import 'dart:async';

import 'package:app/core/constant.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/utils/ui_utils.dart';
import 'package:app/core/widgets/cash_network.dart';
import 'package:app/features/discount/domain/entity/all_discount_entity.dart';
import 'package:app/features/discount/presentation/view_model/cubit/discount_view_model_cubit.dart';
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
  final PageController _pageController = PageController(viewportFraction: 0.9);
  Timer? _autoScrollTimer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 7), (_) {
      if (!_pageController.hasClients) return;
      final nextPage = _pageController.page!.round() + 1;
      final totalPages = serviceCubit.state.getAllDiscountState
      is BaseSuccessState<List<AllDiscountEntity>>
          ? (serviceCubit.state.getAllDiscountState
      as BaseSuccessState<List<AllDiscountEntity>>)
          .data
          ?.length ??
          0
          : 0;

      if (nextPage < totalPages) {
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        _pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return BlocBuilder<ServiceSettingCubit, ServiceSettingState>(
      buildWhen: (cur, pre) => pre.getAllDiscountState != cur.getAllDiscountState,
      bloc: serviceCubit,
      builder: (context, state) {
        if (state.getAllDiscountState is BaseLoadingState) {
          return const Center(
              child: CircularProgressIndicator(color: ColorManager.primary));
        } else if (state.getAllDiscountState is BaseErrorState) {
          return const SizedBox();
        } else if (state.getAllDiscountState is BaseSuccessState) {
          final listAllDiscount =
              (state.getAllDiscountState as BaseSuccessState<List<AllDiscountEntity>>)
                  .data;
          return listAllDiscount!.isEmpty
              ? const SizedBox()
              : SizedBox(
            height: 300.h,
            child: PageView.builder(
              controller: _pageController,
              itemCount: listAllDiscount.length,
              itemBuilder: (context, index) {
                final discount = listAllDiscount[index];
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: GestureDetector(
                    onTap: () {
                      if (sharedPref.getString(CacheConstant.tokenKey) == null) {
                        UIUtils.showMessage("You have to Sign in first");
                        return;
                      }
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ShowDetails(id: discount.providerId!),
                        ),
                      );
                    },
                    child: Card(
                      color: ColorManager.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      elevation: 6,
                      shadowColor: Colors.black12,
                      child: Padding(
                        padding: EdgeInsets.all(16.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                discount.image != null
                                    ? CircleAvatar(
                                  radius: 40.r,
                                  backgroundColor: Colors.grey.shade200,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(40.r),
                                    child: CashImage(path: discount.image!),
                                  ),
                                )
                                    : CircleAvatar(
                                  radius: 40.r,
                                  backgroundColor: Colors.white,
                                  child: Icon(Icons.person, size: 40.r, color: ColorManager.primary),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        discount.providerName ?? '',
                                        style: theme.titleLarge?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 4.h),
                                      Text(
                                        'Code: ${discount.discountCode ?? ''}',
                                        style: theme.labelMedium?.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 2.h),
                                      Text(
                                        '${discount.discount}% OFF',
                                        style: theme.labelMedium?.copyWith(
                                          color: Colors.yellow.shade100,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
