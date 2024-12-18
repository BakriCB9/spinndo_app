import 'package:app/core/resources/values_manager.dart';
import 'package:app/core/widgets/loading_indicator.dart';
import 'package:app/features/auth/presentation/screens/map_screen.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:app/features/profile/data/models/provider_update/update_provider_request.dart';
import 'package:app/features/profile/presentation/screens/update_map_screen.dart';
import 'package:app/features/service/domain/entities/child_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/widgets/custom_text_form_field_bakri.dart';
import 'package:app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:app/features/profile/presentation/cubit/profile_states.dart';
import 'package:app/features/service/domain/entities/categories.dart';
import 'package:app/features/service/presentation/cubit/service_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
      super.key, required this.lat, required this.lng});

//final _profileCubit=serviceLocator.get<ProfileCubit>();
  @override
  Widget build(BuildContext context) {
    final _profileCubit = serviceLocator.get<ProfileCubit>();
    final _serviceCubit = serviceLocator.get<ServiceCubit>();
    final _drawerCubit = serviceLocator.get<DrawerCubit>();
    _profileCubit.descriptionController.text = description;
    _profileCubit.serviceNameController.text = serviceName;
    final localization = AppLocalizations.of(context)!;

    final indexOfMyCurrentCategory = _serviceCubit.categoriesList?.indexWhere(
      (element) {
        return element.name == categoryName;
      },
    );
    print('ther index is ${indexOfMyCurrentCategory}');
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Edit job details',
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: BlocBuilder<ProfileCubit, ProfileStates>(buildWhen: (pre, cur) {
          if (cur is GetCategoryLoading ||
              cur is GetCategoryError ||
              cur is GetCategorySuccess) {
            return true;
          }
          return false;
        }, builder: (context, state) {
          if (state is GetCategoryLoading) {
            return LoadingIndicator(Colors.yellow);
          } else if (state is GetCategoryError) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is GetCategorySuccess) {
            return SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 100.h),

                  SizedBox(
                    height: 30.h,
                  ),
                  // DropdownButtonFormField(
                  //     menuMaxHeight: 200,
                  //     hint: Text(
                  //       categoryName,
                  //       style: TextStyle(fontSize: 25.sp),
                  //     ),
                  //     //style: TextStyle(fontSize: 30.sp,color: Colors.red),
                  //     items: _serviceCubit.categoriesList?.map((e) {
                  //       return DropdownMenuItem(
                  //         value: e.id,
                  //         child: Text(e.name),
                  //       );
                  //     }).toList(),
                  //     onChanged: (value) {}),

                  BlocBuilder<ProfileCubit, ProfileStates>(
                    bloc: _profileCubit,
                    builder: (context, state) {
                      return Column(
                        children: [
                          DropdownButtonFormField<Categories>(
                            dropdownColor: Theme.of(context).primaryColorDark,
                            menuMaxHeight: 200,
                            isExpanded: false,
                            validator: (value) {
                              if (value == null) {
                                return "please select category";
                              }
                              return null;
                            },
                            hint: Padding(
                              padding: EdgeInsets.only(left: 12.w),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.category,
                                  ),
                                  SizedBox(
                                    width: 24.w,
                                  ),
                                  Text("select category",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium),
                                ],
                              ),
                            ),
                            decoration: const InputDecoration(
                                errorBorder: InputBorder.none),
                            items: _profileCubit.categoriesList!
                                .map((e) => DropdownMenuItem<Categories>(
                                      value: e,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.0.w),
                                        child: Text(
                                          e.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value: _profileCubit.selectedCategory,
                            onChanged: (value) {
                              // _authCubit.catChildren=value?.children ?? [];
                              _profileCubit.selectedCategoryEvent(value);
                              // int val = int.parse(_authCubit.selectedCategoryId!);
                              // indexChildCategory =
                              //     _authCubit.categoriesList!.indexWhere(
                              //   (element) => element.id == val,
                              // );
                              //   _authCubit.selectedCategoryId=_authCubit.categoriesList![indexChildCategory!].children[0].id.toString();
                            },
                          ),
                          _profileCubit.selectedCategory != null
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                    DropdownButtonFormField<ChildCategory>(
                                      dropdownColor:
                                          Theme.of(context).primaryColorDark,
                                      menuMaxHeight: 200,
                                      isExpanded: false,
                                      validator: (value) {
                                        if (value == null) {
                                          return "please select category";
                                        }
                                        return null;
                                      },
                                      // value:  _authCubit.selectedCategoryId!=null?_authCubit.categoriesList![indexChildCategory!].children[0]:null,
                                      hint: Padding(
                                        padding: EdgeInsets.only(left: 12.w),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.category,
                                            ),
                                            SizedBox(
                                              width: 24.w,
                                            ),
                                            Text("choose category",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium),
                                          ],
                                        ),
                                      ),
                                      decoration: const InputDecoration(
                                          errorBorder: InputBorder.none),
                                      items:
                                          //indexChildCategory != null
                                          //? _authCubit
                                          //.categoriesList![indexChildCategory!].children
                                          _profileCubit.catChildren
                                              ?.map((e) => DropdownMenuItem<
                                                      ChildCategory>(
                                                    value: e,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  16.0.w),
                                                      child: Text(
                                                        e.name!,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .displayMedium,
                                                      ),
                                                    ),
                                                  ))
                                              .toList(),
                                      value: _profileCubit.selectedSubCategory,
                                      onChanged: (value) {
                                        _profileCubit
                                            .selectedSubCategoryEvent(value!);
                                      },
                                    )
                                  ],
                                )
                              : SizedBox(),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 50.h),

                  TextFormField(
                    controller: _profileCubit.serviceNameController,
                    style: TextStyle(color: Colors.black, fontSize: 25.sp),
                    onChanged: (value) {
                      _profileCubit.updateJobDetails(
                          curServiceName: serviceName,
                          newServiceName:
                              _profileCubit.serviceNameController.text,
                          curDescription: description,
                          newDescription:
                              _profileCubit.descriptionController.text);
                    },
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        labelText: 'Title Service',
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 20.sp)),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),

                  TextFormField(
                    controller: _profileCubit.descriptionController,
                    style: TextStyle(color: Colors.black, fontSize: 25.sp),
                    onChanged: (value) {
                      _profileCubit.updateJobDetails(
                          curServiceName: serviceName,
                          newServiceName:
                              _profileCubit.serviceNameController.text,
                          curDescription: description,
                          newDescription:
                              _profileCubit.descriptionController.text);
                    },
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        labelText: "Description",
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 20.sp)),
                  ),
                  SizedBox(height: 50.h),

                  SizedBox(
                    height: 50.h,
                  ),
                  SizedBox(height: 30.h),
                  BlocBuilder<ProfileCubit,ProfileStates>(
                    bloc: _profileCubit,
                    builder: (context, state) {
                      return InkWell(
                        onTap: () {
                          _profileCubit.getCurrentLocation();
                          _profileCubit.loadMapStyle(
                              _drawerCubit.themeMode == ThemeMode.dark
                                  ? true
                                  : false);
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return    UpdateMapScreen(

//                            location:LatLng( double.parse(lat),double.parse(lng))
                        );
                          },));
                        },
                        child: Container(
                          padding:
                          EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorDark,
                            borderRadius: BorderRadius.all(
                              Radius.circular(AppSize.s28.r),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                              ),
                              SizedBox(
                                width: 24.w,
                              ),
                              BlocBuilder<ProfileCubit,ProfileStates>(
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
                                  } else if (state is GetLocationCountryErrorr) {
                                    return Text(state.message);
                                  } else if (state is GetLocationCountrySuccess) {
                                    return Expanded(
                                      child: Text(
                                          maxLines: 4,
                                          "${_profileCubit.country?.address ?? "please try again"}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium),
                                    );
                                  } else {
                                    return Text(localization.chooseLocation,
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
                  BlocBuilder<ProfileCubit, ProfileStates>(
                      buildWhen: (pre, cur) {
                    if (cur is IsUpdated || cur is IsNotUpdated) return true;
                    return false;
                  }, builder: (context, state) {
                    print('the State is ${state}');

                    if (state is IsUpdated)
                      return ElevatedButton(
                          onPressed: () {
                            _profileCubit.updateProviderProfile(
                                UpdateProviderRequest(
                                  latitudeService: _profileCubit.isCurrent
                                      ? _profileCubit.currentLocation?.latitude.toString()
                                      : _profileCubit.selectedLocation?.latitude
                                      .toString(),
                                  longitudeService:  _profileCubit.isCurrent
                                      ? _profileCubit.currentLocation!.longitude.toString()
                                      : _profileCubit.selectedLocation!.longitude
                                      .toString(),
                                  nameService:
                                      _profileCubit.serviceNameController.text,
                                  descriptionService:
                                      _profileCubit.descriptionController.text,
                                  ////////////////////////////////////////////// resssssssssst
                                ),
                                2);
                          },
                          child: Text('Save'));
                    else {
                      return const SizedBox();
                    }
                  })
                ],
              ),
            ));
          } else {
            return SizedBox();
          }
        }));
  }
}
