import 'package:app/core/constant.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/widgets/cash_network.dart';
import 'package:app/core/widgets/custom_appbar.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:app/features/favorite/presentation/view/favorite.dart';
import 'package:app/features/favorite/presentation/view_model/cubit/favorite_cubit_cubit.dart';
import 'package:app/features/service/presentation/screens/show_details.dart';
import 'package:app/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});
  static const String routeName = 'favorite';
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final ans = sharedPref.getString(CacheConstant.tokenKey);
  final favCubit = serviceLocator.get<FavoriteCubit>();
  late Size size;
  @override
  void initState() {
    if (ans != null) {
      favCubit.getAllFav();
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final drawerCubit = serviceLocator.get<DrawerCubit>();
    final theme = Theme.of(context);

    return Container(
     decoration: drawerCubit.themeMode == ThemeMode.dark
          ? const BoxDecoration(
        color: ColorManager.darkBg,)
          : null,
      child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                CustomAppbar(appBarText: localization.fav),

                Expanded(
                  child: BlocBuilder<FavoriteCubit, FavoriteCubitState>(
                    bloc: favCubit,
                    builder: (context, state) {
                      if (state is FavoriteCubitLoading ||
                          state is FavoriteCubitInitial) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is FavoriteCubitSuccess) {
                        return state.listOfFavorite.isEmpty
                            ? Center(
                                child: Column(
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
                                      localization.noItemsYet,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(fontSize: 30.sp),
                                    ),
                                    const Spacer(
                                      flex: 2,
                                    ),
                                  ],
                                ),
                              )
                            : AnimationLimiter(
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics()),
                                  padding: EdgeInsets.all(16.w),
                                  itemCount: state.listOfFavorite.length,
                                  itemBuilder: (context, index) {
                                    final service = state.listOfFavorite[index];

                                    return AnimationConfiguration.staggeredList(
                                      position: index,
                                      delay: const Duration(milliseconds: 200),
                                      child: SlideAnimation(
                                        duration: const Duration(milliseconds: 2500),
                                        curve: Curves.fastLinearToSlowEaseIn,
                                        child: FadeInAnimation(
                                          curve: Curves.fastLinearToSlowEaseIn,
                                          duration: const Duration(milliseconds: 3000),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) => ShowDetails(
                                                      id: service.providerId!),
                                                ),
                                              );
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.all(16.w),
                                              child: Card(
                                                elevation: 10,
                                                shadowColor: Colors.black38,
                                                child: Padding(
                                                  padding: EdgeInsets.all(32.w),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      service!.providerImage != null
                                                          ?   CircleAvatar(
                                                    radius: 50.r,
                                                    child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(60.r),
                                                        child: CashImage(path: service.providerImage)),
                                                  )
                                                      : CircleAvatar(
                                                  radius: 50.r,
                                                  backgroundColor: ColorManager.primary,
                                                  child: Icon(Icons.person,
                                                      size: 60.r, color: ColorManager.white),
                                                ),
                                                      SizedBox(width: 20.w),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment.start,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Expanded(
                                                                  flex: 2,
                                                                  child: Text(
                                                                    service.name ??
                                                                        "Service Name",
                                                                    style: theme.textTheme.labelMedium!
                                                                        .copyWith(color: theme.primaryColorLight),
                                                                    maxLines: 1,
                                                                    overflow: TextOverflow
                                                                        .ellipsis,
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                    child: FittedBox(
                                                                  fit: BoxFit.scaleDown,
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      CircleAvatar(
                                                                        radius: 12.r,
                                                                        backgroundColor:
                                                                            ColorManager
                                                                                .primary,
                                                                      ),
                                                                      SizedBox(
                                                                        width: 10.w,
                                                                      ),
                                                                      Text(
                                                                        service.distance != null
                                                                            ? '${service.distance!.toStringAsFixed(2)} ${localization.km}'
                                                                            : '',
                                                                        style: theme.textTheme.labelSmall!
                                                                            .copyWith(
                                                                            color: theme.primaryColorLight),
                                                                        textAlign: TextAlign.end,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ))
                                                              ],
                                                            ),
                                                            SizedBox(height: 20.h),
                                                            Text(
                                                              "${localization.provider}: ${service.providerName ?? "Unknown"}",
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .labelMedium!
                                                                  .copyWith(
                                                                      fontSize: 26.sp),
                                                            ),
                                                            SizedBox(height: 20.h),
                                                            Text(
                                                              "${localization.description} : ${service.description}" ??
                                                                  "No description available",
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .labelMedium!
                                                                  .copyWith(
                                                                      fontSize: 26.sp),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow.ellipsis,
                                                            ),
                                                            SizedBox(height: 20.h),
                                                            Row(
                                                              children: [
                                                                Icon(Icons.category,
                                                                    size: 34.r,
                                                                    color: ColorManager
                                                                        .primary),
                                                                SizedBox(width: 10.w),
                                                                Expanded(
                                                                  child: Text(
                                                                    service.categoryName ??
                                                                        "Category",
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .labelMedium!
                                                                        .copyWith(
                                                                            fontSize:
                                                                            26.sp,
                                                                            overflow:
                                                                                TextOverflow
                                                                                    .ellipsis),
                                                                  ),
                                                                ),
                                                                FavoriteWidget(
                                                                  userId: service
                                                                      .providerId
                                                                      .toString(), isFavorite: service.isFavorite,
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                      }
                      return Center(
                          child: RichText(
                              text: TextSpan(
                                  children: [
                            TextSpan(
                                text: localization.tryAgain,
                                style: TextStyle(
                                    color: ColorManager.amber, fontSize: 28.sp),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    favCubit.getAllFav();
                                  })
                          ],
                                  text: localization.failedData,
                                  style: TextStyle(
                                      color: ColorManager.black, fontSize: 30.sp)))
                          //  Column(
                          //   // mainAxisAlignment: MainAxisAlignment.center,
                          //   // crossAxisAlignment: CrossAxisAlignment.center,
                          //   children: [
                          //     Text('Hello bakri'),

                          //   ],
                          // ),
                          );
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
