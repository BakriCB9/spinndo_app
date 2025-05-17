import 'package:app/core/di/service_locator.dart';
import 'package:app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:app/features/profile/presentation/cubit/profile_states.dart';
import 'package:app/features/service/data/models/get_all_category_response/data.dart';
import 'package:app/features/service/domain/entities/categories.dart';
import 'package:app/features/service/presentation/cubit/service_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'core/resources/color_manager.dart';

class CascadingDropdowns extends StatefulWidget {
  final List<Categories>? categories;
  final bool isService;
  final bool isProfile;
  AuthCubit? authCubit;
  CascadingDropdowns(
      {required this.categories,
      this.isService = false,
      this.isProfile = false,
      this.authCubit
      });

  @override
  _CascadingDropdownsState createState() => _CascadingDropdownsState();
}

class _CascadingDropdownsState extends State<CascadingDropdowns> {
  //final widget.authCubit! = serviceLocator.get<AuthCubit>();
  final _serviceCubit = serviceLocator.get<ServiceCubit>();
  final _profileCubit = serviceLocator.get<ProfileCubit>();
  List<Categories?> selectedCategories = [];
  @override
  void initState() {
    super.initState();

    // Initialize `selectedCategories` with values from `_profileCubit`
    if (widget.isProfile) {
      selectedCategories = _profileCubit.chosenCategories;
    }
  }

  void updateSelectedCategory(int level, Categories? selected) {
    // Update the selected category at the current level
    if (selectedCategories.length > level) {
      final currentSelection = selectedCategories[level];

      // If the new selection is different, update it and reset deeper levels

      selectedCategories[level] = selected;
      selectedCategories = selectedCategories.sublist(0, level + 1);

      //
      // selectedCategories[level] = selected;
      //
      // // Remove any deeper selections
      // selectedCategories = selectedCategories.sublist(0, level + 1);
    } else {
      selectedCategories.add(selected);
    }
    if (selected != null) {
      if (selected.id == -1 && level > 0) {
        // "All Sub Categories" is selected, save the parent category's ID
        widget.isProfile
            ? _profileCubit.selectedCategory = selectedCategories[level - 1]
            : widget.isService
                ? _serviceCubit.selectedCategory = selectedCategories[level - 1]
                : widget.authCubit!.selectedCategory = selectedCategories[level - 1];
      } else {
        // Save the current category's ID
        widget.isProfile
            ? _profileCubit.selectedCategory = selected
            : widget.isService
                ? _serviceCubit.selectedCategory = selected
                : widget.authCubit!.selectedCategory = selected;
      }
    } else if (level > 0) {
      // No selection, fallback to the parent category
      widget.isProfile
          ? _profileCubit.selectedCategory = selectedCategories[level - 1]
          : widget.isService
              ? _serviceCubit.selectedCategory = selectedCategories[level - 1]
              : widget.authCubit!.selectedCategory = selectedCategories[level - 1];
    }
    // Ensure no dropdowns are shown for empty children
    while (selected != null &&
        (selected!.children.isEmpty || selected.children == null) &&
        level + 1 >= selectedCategories.length) {
      selected = null;
      break;
    }
    // Stop showing children if the selected category's id is -1
    if (selected != null && selected.id == -1) {
      selectedCategories = selectedCategories.sublist(0, level + 1);
    }
    if (widget.isProfile) {
      _profileCubit.slesctedProfileCat();
    } else if (widget.isService) {
      _serviceCubit.selectedServiceCat();
    } else {
      widget.authCubit!.selectedAuthCat();
    }
    if (widget.isProfile) {
      _profileCubit.slesctedProfileCat();
    } else if (widget.isService) {
      _serviceCubit.selectedServiceCat();
    } else {
      widget.authCubit!.selectedAuthCat();
    }
  }

  List<Widget> buildDropdowns(BuildContext context) {
    List<Widget> dropdowns = [];
    List<Categories>? currentList = widget.categories;
    final localization = AppLocalizations.of(context)!;

    for (int i = 0; i <= selectedCategories.length; i++) {
      // Skip this level if there are no children to select
      if (currentList == null || currentList.isEmpty) break;
      // Add the "Select All Categories" option
      // final selectAllOption = Categories(
      //   name: i == 0
      //       ? "All Categories"
      //       : "All Sub Categories",
      //   id: -1,
      //   children: [],
      // );
      DataCategory addAllCategory = DataCategory(
        name: "All Sub Categories",
        id: -1,
        children: [],
      );
      // if(currentList.contains(addAllCategory)==false) {currentList.add(addAllCategory);
      // print("xxxxxxxxxxxxxxxxxxxx");
      //   print(!currentList.contains(addAllCategory));
      // };
      if (_serviceCubit.isReset == true) {
        selectedCategories.clear();
      }

      dropdowns.add(Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButtonFormField<Categories>(
                dropdownColor: Colors.white,
                icon: SvgPicture.asset(
                  'asset/icons/drop_down.svg',
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    ColorManager.primary,
                    BlendMode.srcIn,
                  ),
                ),
                value: i < selectedCategories.length ? selectedCategories[i] : null,
                hint: Row(
                  children: [
                    Icon(
                      Icons.category,
                      color: (i < selectedCategories.length && selectedCategories[i] != null)
                          ? Colors.amber
                          : Colors.grey,
                    ),
                    SizedBox(width: 12),
                    Text(
                      i == 0 ? localization.category : localization.subCategory,
                      style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                menuMaxHeight: 200,
                isExpanded: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.transparent,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: currentList
                    .map((category) => DropdownMenuItem<Categories>(
                  value: category,
                  child: Text(
                    category.name,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ))
                    .toList(),
                onChanged: (value) {
                  _serviceCubit.isReset = false;
                  updateSelectedCategory(i, value);
                },
              ),
            ),
          ),


          SizedBox(height: 30.h),
        ],
      ));

      // If a category is selected at this level, update the current list
      if (i < selectedCategories.length &&
          selectedCategories[i] != null &&
          selectedCategories[i]?.id != -1) {
        currentList = [];

        currentList = selectedCategories[i]!.children;
        if (selectedCategories[i]?.children.isNotEmpty == true &&
            widget.isService &&
            !currentList.any((category) => category.id == addAllCategory.id)) {
          currentList.add(addAllCategory);
        }
      } else {
        break;
      }
    }

    return dropdowns;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: buildDropdowns(context),
    );
  }
}
