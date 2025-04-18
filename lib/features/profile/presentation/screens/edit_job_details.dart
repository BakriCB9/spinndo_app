import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/resources/values_manager.dart';
import 'package:app/core/utils/ui_utils.dart';
import 'package:app/core/widgets/loading_indicator.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:app/features/profile/data/models/provider_update/update_provider_request.dart';
import 'package:app/features/profile/presentation/screens/update_map_screen.dart';
import 'package:app/features/service/domain/entities/child_category.dart';
import 'package:app/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:app/features/profile/presentation/cubit/profile_states.dart';
import 'package:app/features/service/domain/entities/categories.dart';
import 'package:app/features/service/presentation/cubit/service_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditJobDetails extends StatelessWidget {
  final String categoryName;
  final String serviceName;
  final String locationName;
  final String description;
  final String lat;
  final String lng;

  const EditJobDetails(
      {required this.categoryName,
      required this.description,
      required this.locationName,
      required this.serviceName,
      super.key,
      required this.lat,
      required this.lng});

//final _profileCubit=serviceLocator.get<ProfileCubit>();
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    final _profileCubit = serviceLocator.get<ProfileCubit>();
    final _serviceCubit = serviceLocator.get<ServiceCubit>();
    final _drawerCubit = serviceLocator.get<DrawerCubit>();
    _profileCubit.descriptionController.text = description;
    _profileCubit.serviceNameController.text = serviceName;
    Categories? parent;
    ChildCategory? child;
    //    if(_profileCubit.providerProfile!.details!.category!.parent==null){
    //      final parentName=_profileCubit.providerProfile?.details?.category?.name;
    //      print('the name is of parent is ############################## $parentName');
    // parent=_profileCubit.categoriesList?.firstWhere((element) {
    //        return  element.name==parentName;
    //      },);
    // print('the categoriiiiiiesssssssssssssssssssss $parent');
    //      _profileCubit.selectedCategory=parent;
    //      print('the value is  88888888888888888888888888888888888888888888 ${_profileCubit.selectedCategory}');
    //    }
    //    else {
    //      final parentName = _profileCubit.providerProfile?.details?.category
    //          ?.parent?.name;
    //      final childName = _profileCubit.providerProfile?.details?.category?.name;
    //
    //      Categories? parent=_profileCubit.categoriesList?.firstWhere((element) {
    //       return  element.name==parentName;
    //      },);
    //
    //        child=parent?.children.firstWhere((element){
    //          return  element.name==  childName;
    //      });
    //       _profileCubit.selectedCategory=parent;
    //       _profileCubit.selectedSubCategory=child;
    //    }
    //print(parentName);

    //print("dsaaaaaaaaaaaaaa");
//print(childName);
    //  print("dsaaaaaaaaaaaaaa");
    // Categories? parent=_profileCubit.categoriesList?.firstWhere((element) {
    //  return  element.name==parentName;
    // },);
    //
    //  ChildCategory? child=parent?.children.firstWhere((element){
    //     return  element.name==  childName;
    // });
    //  _profileCubit.selectedCategory=parent;
    //  _profileCubit.selectedSubCategory=child;
    // final indexOfMyCurrentCategory = _serviceCubit.categoriesList?.indexWhere(
    //   (element) {
    //     return element.name == categoryName;
    //   },
    // );
    //print('ther index is ${indexOfMyCurrentCategory}');
    return Container(
      decoration: _drawerCubit.themeMode == ThemeMode.dark
          ? BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("asset/images/bg.png"), fit: BoxFit.fill))
          : null,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              localization.editJobDetails,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: BlocBuilder<ProfileCubit, ProfileStates>(buildWhen: (pre, cur) {
            if (cur is GetCategoryLoading ||
                cur is GetCategoryError ||
                cur is SelectedCategoryState ||
                cur is GetCategorySuccess) {
              return true;
            }
            return false;
          }, builder: (context, state) {
            if (state is GetCategoryLoading) {
              return const LoadingIndicator(Colors.yellow);
            } else if (state is GetCategoryError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return SingleChildScrollView(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 100.h),
                    SizedBox(height: 30.h),
                    TextFormField(
                      controller: _profileCubit.serviceNameController,
                      onChanged: (value) {
                        _profileCubit.updateJobDetails(
                            curServiceName: serviceName,
                            newServiceName:
                                _profileCubit.serviceNameController.text,
                            curDescription: description,
                            newDescription:
                                _profileCubit.descriptionController.text);
                      },
                      style: TextStyle(
                          color: _drawerCubit.themeMode == ThemeMode.light
                              ? Colors.black
                              : Colors.white,
                          fontSize: 25.sp),
                      cursorColor: ColorManager.primary,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textInputAction: TextInputAction.done,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(200),
                      ],
                      decoration: InputDecoration(
                        label: Text(
                          localization.titleService,
                        ),
                        prefixIcon: Icon(
                          Icons.person,
                          size: 45.sp,
                        ),
                        // counter: SizedBox()
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    TextFormField(
                      controller: _profileCubit.descriptionController,
                      onChanged: (value) {
                        _profileCubit.updateJobDetails(
                            curServiceName: serviceName,
                            newServiceName:
                                _profileCubit.serviceNameController.text,
                            curDescription: description,
                            newDescription:
                                _profileCubit.descriptionController.text);
                      },
                      style: TextStyle(
                          color: _drawerCubit.themeMode == ThemeMode.light
                              ? Colors.black
                              : Colors.white,
                          fontSize: 25.sp),
                      cursorColor: ColorManager.primary,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textInputAction: TextInputAction.done,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(200),
                      ],
                      decoration: InputDecoration(
                        label: Text(
                          localization.description,
                        ),
                        prefixIcon: Icon(
                          Icons.person,
                          size: 45.sp,
                        ),
                        // counter: SizedBox()
                      ),
                    ),
                    SizedBox(height: 50.h),
                    BlocBuilder<ProfileCubit, ProfileStates>(
                      bloc: _profileCubit,
                      builder: (context, state) {
                        return CascadingDropdowns(
                          categories: _profileCubit.categoriesList,
                          isProfile: true,
                        );
                      },
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    BlocBuilder<ProfileCubit, ProfileStates>(
                      bloc: _profileCubit,
                      builder: (context, state) {
                        return InkWell(
                          onTap: () {
                            _profileCubit.getCurrentLocation();
                            _profileCubit.loadMapStyle(
                                _drawerCubit.themeMode == ThemeMode.dark
                                    ? true
                                    : false);
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return const UpdateMapScreen(

                                    //                            location:LatLng( double.parse(lat),double.parse(lng))
                                    );
                              },
                            ));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24.w, vertical: 28.h),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorDark,
                              borderRadius: BorderRadius.all(
                                Radius.circular(AppSize.s28.r),
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                ),
                                SizedBox(
                                  width: 24.w,
                                ),
                                BlocBuilder<ProfileCubit, ProfileStates>(
                                  bloc: _profileCubit,
                                  buildWhen: (previous, current) {
                                    if (current is GetLocationCountryLoading ||
                                        current is GetLocationCountryErrorr ||
                                        current is GetLocationCountrySuccess)
                                      return true;
                                    return false;
                                  },
                                  builder: (context, state) {
                                    if (state is GetLocationCountryLoading) {
                                      return LoadingIndicator(
                                          Theme.of(context).primaryColor);
                                    } else if (state
                                        is GetLocationCountryErrorr) {
                                      return Text(state.message);
                                    } else if (state
                                        is GetLocationCountrySuccess) {
                                      return Expanded(
                                        child: Text(
                                            maxLines: 4,
                                            "${_profileCubit.country?.address ?? "please try again"}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium),
                                      );
                                    } else {
                                      return Text(
                                          _profileCubit.city?.name ??
                                              localization.chooseLocation,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium);
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 40.h),
                    BlocBuilder<ProfileCubit, ProfileStates>(
                        buildWhen: (pre, cur) {
                      if (cur is IsUpdated || cur is IsNotUpdated) return true;
                      return false;
                    }, builder: (context, state) {
                      print('the State is $state');

                      if (state is IsUpdated) {
                        return BlocListener(
                          bloc: _profileCubit,
                          listener: (context, state) {
                            if (state is UpdateLoading) {
                              UIUtils.showLoading(context);
                            } else if (state is UpdateError) {
                              UIUtils.hideLoading(context);
                              UIUtils.showMessage(state.message);
                            } else if (state is UpdateSuccess) {
                              UIUtils.hideLoading(context);
                              _profileCubit.getUserRole();
                              Navigator.of(context).pop();
                            }
                          },
                          child: ElevatedButton(
                              onPressed: () {
                                _profileCubit.updateProviderProfile(
                                    UpdateProviderRequest(
                                      latitudeService: _profileCubit
                                          .myLocation?.latitude
                                          .toString(),
                                      longitudeService: _profileCubit
                                          .myLocation?.longitude
                                          .toString(),
                                      //cityNameService: _profileCubit.cityName,
                                      categoryIdService: _profileCubit
                                          .selectedCategory?.id
                                          .toString(),
                                      nameService: _profileCubit
                                          .serviceNameController.text,
                                      descriptionService: _profileCubit
                                          .descriptionController.text,

                                      ////////////////////////////////////////////// resssssssssst
                                    ),
                                    2);
                              },
                              child: Text(localization.save)),
                        );
                      } else if (state is IsNotUpdated) {
                        return const SizedBox();
                      } else {
                        return SizedBox();
                      }
                    })
                  ],
                ),
              ));
            }
          })),
    );
  }
}
