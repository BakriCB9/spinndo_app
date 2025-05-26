import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/features/favorite/presentation/view_model/cubit/favorite_cubit_cubit.dart';
import 'package:flutter/material.dart';

class FavoriteWidget extends StatefulWidget {
  final String userId;
  const FavoriteWidget({super.key, required this.userId});

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  final favViewModel = serviceLocator.get<FavoriteCubit>();
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
        if (isSelected) {
          favViewModel.addFav(widget.userId);
        } else {
          favViewModel.removeFromFav(widget.userId);
        }
      },
      child: isSelected
          ? const Icon(
              Icons.favorite,
              color: ColorManager.red,
            )
          : const Icon(Icons.favorite_border_outlined),
    );
  }
}
