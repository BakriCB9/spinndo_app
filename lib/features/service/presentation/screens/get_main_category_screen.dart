import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:app/features/service/data/models/get_services_request.dart';
import 'package:app/features/service/presentation/cubit/service_cubit.dart';
import 'package:app/features/service/presentation/cubit/service_states.dart';
import 'package:app/features/service/presentation/screens/filter_result_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetMainCategoryScreen extends StatefulWidget {
  const GetMainCategoryScreen({super.key});

  @override
  State<GetMainCategoryScreen> createState() => _GetMainCategoryScreenState();
}

class _GetMainCategoryScreenState extends State<GetMainCategoryScreen> {
  late ServiceCubit _serviceCubit;
  late DrawerCubit _drawerCubit;
  @override
  void initState() {
    _serviceCubit = serviceLocator.get<ServiceCubit>();
    _drawerCubit = serviceLocator.get<DrawerCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Container(
      decoration:  _drawerCubit.themeMode == ThemeMode.dark
          ? const BoxDecoration(
          color: ColorManager.darkBg
      ): null,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 15,
                );
              },
              itemCount: _serviceCubit.listOfAllMainCategory.length,
              itemBuilder: (context, index) {
                return BlocListener<ServiceCubit, ServiceStates>(
                  bloc: _serviceCubit,
                  listenWhen: (pre, cur) {
                    print('the state from getmain category is $cur');
                    if (cur is ServiceError ||
                        cur is ServiceLoading ||
                        cur is ServiceLoading) {
                      return true;
                    }
                    return false;
                  },
                  listener: (context, state) {
                    print('the state bakkkkkar is now $state');
                    if (state is ServiceLoading) {
                      // UIUtils.showLoading(context);
                    } else if (state is ServiceError) {
                      // UIUtils.hideLoading(context);
                      //UIUtils.showMessage(state.message);
                    } else if (state is ServiceSuccess) {
                      print(
                          'we jump in get main screen now &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&77');
                      // UIUtils.hideLoading(context);
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return FilterResultScreen(
                            services: state.services,
                          );
                        },
                      ));
                    }
                  },
                  child: InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      _serviceCubit.getServiceAndDiscount(GetServicesRequest(
                          categoryId:
                          _serviceCubit.listOfAllMainCategory[index].id,
                          //  _serviceCubit.selectedCategory?.id == -1
                          //     ? null
                          //     : _serviceCubit.selectedCategory?.id,
                          cityId: _serviceCubit.selectedCityId == -1
                              ? null
                              : _serviceCubit.selectedCityId,
                          countryId: _serviceCubit.selectedCountryId == -1
                              ? null
                              : _serviceCubit.selectedCountryId,
                          latitude: _serviceCubit.getCurrentLocation?.latitude,
                          longitude:
                          _serviceCubit.getCurrentLocation?.longitude,
                          radius: _serviceCubit.isCurrent == true
                              ? _serviceCubit.selectedDistance?.toInt()
                              : null,
                          search: _serviceCubit.searchController.text.isEmpty
                              ? null
                              : _serviceCubit.searchController.text));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListTile(
                          leading: _serviceCubit
                              .listOfAllMainCategory[index].iconPath ==
                              null
                              ? SizedBox(
                              height: 50,
                              width: 50,
                              child: Image.asset('asset/images/aaaa.png'))
                              : Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle),
                            child: CachedNetworkImage(
                                imageUrl: _serviceCubit
                                    .listOfAllMainCategory[index]
                                    .iconPath!),
                          ),
                          title: Text(
                            '${_serviceCubit.listOfAllMainCategory[index].name}' ??
                                '',
                            style: theme.bodyMedium,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
