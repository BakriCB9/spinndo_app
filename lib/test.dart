import 'package:app/features/service/domain/entities/categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CascadingDropdowns extends StatefulWidget {
  final List<Categories>? categories;

  CascadingDropdowns({required this.categories});

  @override
  _CascadingDropdownsState createState() => _CascadingDropdownsState();
}

class _CascadingDropdownsState extends State<CascadingDropdowns> {
  List<Categories?> selectedCategories = [];

  void updateSelectedCategory(int level, Categories? selected) {
    setState(() {
      // Update the selected category at the current level
      if (selectedCategories.length > level) {
        selectedCategories[level] = selected;

        // Remove any deeper selections
        selectedCategories = selectedCategories.sublist(0, level + 1);
      } else {
        selectedCategories.add(selected);
      }

      // Ensure no dropdowns are shown for empty children
      while (selected != null &&
          (selected!.children.isEmpty || selected?.children == null) &&
          level + 1 >= selectedCategories.length) {
        selected = null;
        break;
      }
    });
  }

  List<Widget> buildDropdowns(BuildContext context) {
    List<Widget> dropdowns = [];
    List<Categories>? currentList = widget.categories;
    final localization = AppLocalizations.of(context)!;

    for (int i = 0; i <= selectedCategories.length; i++) {
      // Skip this level if there are no children to select
      if (currentList!.isEmpty) break;

      // Build a dropdown for the current level
      dropdowns.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: DropdownButtonFormField<Categories>(
          dropdownColor: Theme.of(context).primaryColorDark,
          menuMaxHeight: 200,
          isExpanded: false,
          validator: (value) {
            if (value == null) {
              return localization.pleaseChooseCategory;
            }
            return null;
          },
          value: i < selectedCategories.length ? selectedCategories[i] : null,
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
                Text('Select ${i == 0 ? "${localization.category}" : "${localization.subCategory}"}',
                    style:
                    Theme.of(context).textTheme.displayMedium),
              ],
            ),
          ),
          decoration:
          const InputDecoration(errorBorder: InputBorder.none),
          items: currentList
              .map((category) => DropdownMenuItem(
            value: category,
            child: Padding(
              padding:
              EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Text(
                category.name,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium,
              ),
            ),
          ))
              .toList(),
          onChanged: (value) => updateSelectedCategory(i, value),
        ),
      ));

      // If a category is selected at this level, update the current list
      if (i < selectedCategories.length && selectedCategories[i] != null) {
        //bbb
        // currentList = selectedCategories[i]!.children;
      } else {
        break;
      }
    }

    return dropdowns;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: buildDropdowns(context),
      ),
    );
  }
}