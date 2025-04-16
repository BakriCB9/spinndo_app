import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/core/widgets/loading_indicator.dart';

class CashImage extends StatelessWidget {
  final String path;
  const CashImage({required this.path, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350.w,
      width: 350.w,
      child: CachedNetworkImage(
        imageUrl: path,
        fit: BoxFit.cover,
        placeholder: (context, _) {
          return LoadingIndicator(Theme.of(context).primaryColor);
        },
        errorWidget: (context, url, error) {
          return const Icon(Icons.error);
        },
      ),
    );
  }
}
