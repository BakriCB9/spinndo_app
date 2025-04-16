import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/widgets/cash_network.dart';
import 'package:app/features/service/presentation/cubit/service_cubit.dart';
import 'package:app/features/service/presentation/cubit/service_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowDiscount extends StatefulWidget {
  @override
  _ShowDiscountState createState() => _ShowDiscountState();
}

class _ShowDiscountState extends State<ShowDiscount> {
  final serviceCubit = serviceLocator.get<ServiceCubit>();
  @override
  void initState() {
    super.initState();

    // context.read<DiscountCubit>().fetchDiscounts();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return

        // appBar: AppBar(
        //   title: Text("Discount Offers", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        //   centerTitle: true,
        //   backgroundColor: Colors.deepPurple.shade400,
        // ),
        BlocBuilder<ServiceCubit, ServiceStates>(
      buildWhen: (cur, pre) {
        if (cur is GetDiscountSuccessState ||
            cur is ServiceSuccess ||
            cur is GetDiscountFailState ||
            cur is GetDiscountLoadingState) {
          return true;
        }
        return false;
      },
      bloc: serviceCubit,
      builder: (context, state) {
        if (state is GetDiscountLoadingState) {
          return const Center(
              child: CircularProgressIndicator(color: ColorManager.primary));
        } else if (state is GetDiscountFailState) {
          return const SizedBox();
          //return Center(child: Text(state.message, style: GoogleFonts.poppins(color: Colors.red)));
        } else {
          return serviceCubit.listAllDiscount.isEmpty
              ? const SizedBox()
              : PageView.builder(
                  itemCount: serviceCubit.listAllDiscount.length,
                  controller: PageController(viewportFraction: 0.8),
                  itemBuilder: (context, index) {
                    return Card(
                      color: ColorManager.primary,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                serviceCubit.listAllDiscount[index].image !=
                                        null
                                    ? CircleAvatar(
                                        radius: 60.r,
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(60.r),
                                            child: CashImage(
                                                path: serviceCubit
                                                    .listAllDiscount[index]
                                                    .image!)),
                                      )
                                    : CircleAvatar(
                                        radius: 60.r,
                                        backgroundColor: ColorManager.primary,
                                        child: Icon(Icons.person,
                                            size: 60.r,
                                            color: ColorManager.white),
                                      ),
                                const SizedBox(width: 10),
                                Text(
                                  serviceCubit.listAllDiscount[index]
                                          .providerName ??
                                      '',
                                  style: theme.labelMedium,
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'discount code: ${serviceCubit.listAllDiscount[index].discountCode ?? ''}',
                              style: theme.labelMedium,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'discount value: ${serviceCubit.listAllDiscount[index].discount}',
                              style: theme.labelMedium,
                            )
                          ],
                        ),
                      ),
                    );
                  });

          ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: serviceCubit.listAllDiscount.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 300,
                  child: Card(
                    color: ColorManager.primary,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              serviceCubit.listAllDiscount[index].image != null
                                  ? CircleAvatar(
                                      radius: 60.r,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(60.r),
                                          child: CashImage(
                                              path: serviceCubit
                                                  .listAllDiscount[index]
                                                  .image!)),
                                    )
                                  : CircleAvatar(
                                      radius: 60.r,
                                      backgroundColor: ColorManager.primary,
                                      child: Icon(Icons.person,
                                          size: 60.r,
                                          color: ColorManager.white),
                                    ),
                              Text(
                                serviceCubit
                                        .listAllDiscount[index].providerName ??
                                    '',
                                style: theme.labelMedium,
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Text(
                            'discount code: ${serviceCubit.listAllDiscount[index].discountCode ?? ''}',
                            style: theme.labelMedium,
                          ),
                          SizedBox(height: 5),
                          Text(
                            '${serviceCubit.listAllDiscount[index].discount}',
                            style: theme.labelSmall,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              });
        }
      },
    );
  }

//   Widget _buildMarquee(List<Map<String, dynamic>> discounts) {
//     String marqueeText = discounts.map((discount) {
//       return "🔥 ${discount['provider_name']} - ${discount['discount']}% Off! Use Code: ${discount['discount_code']} ";
//     }).join("   |   ");

//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
//       height: 50,
//       decoration: BoxDecoration(
//         color: Colors.deepPurple.shade100,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Marquee(
//         text: marqueeText,
//         style: ,
//         // style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.deepPurple),
//         scrollAxis: Axis.horizontal,
//         blankSpace: 30.0,
//         velocity: 50.0,
//         pauseAfterRound: Duration(seconds: 1),
//         startPadding: 10.0,
//         accelerationDuration: Duration(seconds: 1),
//         accelerationCurve: Curves.linear,
//         decelerationDuration: Duration(seconds: 1),
//         decelerationCurve: Curves.easeOut,
//       ),
//     );
//   }
// }
}
