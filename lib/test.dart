import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/features/auth/presentation/cubit/cubit/register_cubit.dart';
import 'package:app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:app/features/service/data/models/get_all_category_response/data.dart';
import 'package:app/features/service/domain/entities/categories.dart';
import 'package:app/features/service/presentation/cubit/service_cubit.dart';
import 'package:app/features/service/presentation/cubit/service_setting_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CascadingDropdowns extends StatefulWidget {
  final List<Categories>? categories;
  final bool isService;
  final bool isProfile;
  RegisterCubit? authCubit;
  CascadingDropdowns(
      {required this.categories,
      this.isService = false,
      this.isProfile = false,
      this.authCubit});

  @override
  _CascadingDropdownsState createState() => _CascadingDropdownsState();
}

class _CascadingDropdownsState extends State<CascadingDropdowns> {
  final _serviceCubit = serviceLocator.get<ServiceSettingCubit>();
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
      // final currentSelection = selectedCategories[level];

      // If the new selection is different, update it and reset deeper levels

      selectedCategories[level] = selected;
      selectedCategories = selectedCategories.sublist(0, level + 1);
      // // Remove any deeper selections
      
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
                : widget.authCubit!.selectedCategory =
                    selectedCategories[level - 1];
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
              : widget.authCubit!.selectedCategory =
                  selectedCategories[level - 1];
    }
    // Ensure no dropdowns are shown for empty children
    while (selected != null &&
        (selected.children.isEmpty || selected.children == null) &&
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
      setState(() {});
      // _serviceCubit.selectedServiceCat();
    } else {
      //
      setState(() {});
    }
    if (widget.isProfile) {
      _profileCubit.slesctedProfileCat();
    } else if (widget.isService) {
      setState(() {});
      // _serviceCubit.selectedServiceCat();
    } else {
      // widget.authCubit!.selectedAuthCat();
      setState(() {});
    }
  }

  List<Widget> buildDropdowns(BuildContext context) {
    List<Widget> dropdowns = [];
    List<Categories>? currentList = widget.categories;
    final localization = AppLocalizations.of(context)!;

    for (int i = 0; i <= selectedCategories.length; i++) {
      // Skip this level if there are no children to select
      if (currentList == null || currentList.isEmpty) break;

      DataCategory addAllCategory = DataCategory(
        name: localization.allSubCategory,
        id: -1,
        children: [],
      );

      if (_serviceCubit.isReset == true) {
        selectedCategories.clear();
      }

      dropdowns.add(Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: DropdownButtonFormField<Categories>(
                    icon: SvgPicture.asset(
                      'asset/icons/drop_down.svg',
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        (i < selectedCategories.length && selectedCategories[i] != null)
                            ? ColorManager.primary
                            :Colors.black,
                        BlendMode.srcIn,
                      ),
                    ),
                    dropdownColor: Theme.of(context).primaryColorDark,
                    hint: Padding(
                      padding: EdgeInsets.only(left: 12), // نفس الـ padding تقريبًا
                      child: Row(
                        children: [
                          Icon(
                            Icons.category,
                            color: (i < selectedCategories.length && selectedCategories[i] != null)
                                ?ColorManager.primary
                                : Colors.black,
                          ),
                          SizedBox(width: 24),
                          Text(
                            i == 0 ? localization.category : localization.subCategory,
                            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    menuMaxHeight: 200,
                    isExpanded: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    value: i < selectedCategories.length ? selectedCategories[i] : null,
                    items: currentList.map((category) {
                      final isSelected = i < selectedCategories.length && selectedCategories[i] == category;
                      return DropdownMenuItem<Categories>(
                        value: category,
                        child: Text(
                          category.name,
                          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            color:Colors.black ,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      _serviceCubit.isReset = false;
                      updateSelectedCategory(i, value);
                    },
                  ),
                ),
              ),
            ],
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
