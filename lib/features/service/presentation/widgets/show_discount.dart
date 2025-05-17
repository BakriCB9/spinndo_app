import 'dart:async';

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
      buildWhen: (cur, pre) =>
      pre.getAllDiscountState != cur.getAllDiscountState,
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
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: _RotatingDiscountCard(discount: listAllDiscount[index]),
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

class _RotatingDiscountCard extends StatefulWidget {
  final AllDiscountEntity discount;
  const _RotatingDiscountCard({required this.discount});

  @override
  State<_RotatingDiscountCard> createState() => _RotatingDiscountCardState();
}

class _RotatingDiscountCardState extends State<_RotatingDiscountCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _rotation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 7),
    )..repeat(reverse: true);

    _rotation = Tween<double>(begin: -0.015, end: 0.015).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final discount = widget.discount;

    return GestureDetector(
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
      child: AnimatedBuilder(
        animation: _rotation,
        builder: (context, child) {
          return Transform.rotate(
            angle: _rotation.value,
            child: child,
          );
        },
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          elevation: 6,
          shadowColor: Colors.black12,
          child: Stack(
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.all(28.r),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          discount.image != null
                              ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                                            radius: 40.r,
                                                            backgroundColor: Colors.grey.shade200,
                                                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(40.r),
                                child: CashImage(path: discount.image!),
                                                            ),
                                                          ),
                              )
                              : Padding(
                            padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                                            radius: 40.r,
                                                            backgroundColor: ColorManager.primary.withOpacity(0.9),
                                                            child: Icon(Icons.person,
                                  size: 40.r, color: Colors.white),
                                                          ),
                              ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  discount.providerName ?? '',
                                  style: theme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 34.sp,
                                    color: Colors.black87,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Discount Code:',
                                      style: theme.labelMedium!.copyWith(
                                        fontSize: 26.sp,
                                        color: Colors.grey.shade800,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(width: 6.w),
                                    Flexible(
                                      child: Text(
                                        discount.discountCode ?? '',
                                        style: theme.labelMedium!.copyWith(
                                          fontSize: 32.sp,
                                          color: Colors.grey.shade800,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30.h),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 15,
                right: -25,
                child: Transform.rotate(
                  angle: 0.785,
                  child: Container(
                    width: 200.w,
                    color: ColorManager.primary,
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    alignment: Alignment.center,
                    child: Text(
                      '${discount.discount}% OFF',
                      style: theme.labelSmall!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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

