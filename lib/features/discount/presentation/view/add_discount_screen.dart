import 'package:app/core/constant.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/resources/font_manager.dart';
import 'package:app/core/utils/ui_utils.dart';
import 'package:app/core/widgets/custom_text_form_field.dart';
import 'package:app/features/discount/data/model/discount_request/add_discount_request.dart';
import 'package:app/features/discount/presentation/view_model/cubit/discount_view_model_cubit.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () => Navigator.of(context).pop(),
                            child:
                            SvgPicture.asset(
                              'asset/icons/back.svg',
                              width: 20,
                              height: 20,
                              colorFilter: ColorFilter.mode(
                                ColorManager.grey,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20.w),
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Directionality.of(context) == TextDirection.rtl
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Text(
                              localization.disco,
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: FontSize.s22,fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 100.h,),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.numberWithOptions(),
                        controller: discountController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return localization.discountRequired;
                          } else if (int.tryParse(value) != null && int.parse(value) > 100) {
                            return "It must be less than 100";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.percent, color: ColorManager.primary),
                          labelText: localization.discountLabel,
                          labelStyle: TextStyle(color: Colors.grey[700]),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: discountCodeController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return localization.codeRequired;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.confirmation_num, color: ColorManager.primary),
                          labelText: localization.codeLabel,
                          labelStyle: TextStyle(color: Colors.grey[700]),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
                        ),
                      ),
                    ),

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
                        child:
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              discountCubit.addDiscount(AddDiscountRequest(
                                  discount: int.parse(discountController.text),
                                  discountCode: discountCodeController.text,
                                  userId: myId!));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(36),
                            ),
                          ),

                            child: Text(
                              localization.addDiscount,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                            )
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
