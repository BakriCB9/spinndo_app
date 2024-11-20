import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:snipp/core/widgets/loading_indicator.dart';

class CashImage extends StatelessWidget {
  final String path;
  const CashImage({required this.path  ,super.key});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(imageUrl: path,placeholder: (context,_){
      return const  LoadingIndicator();
    },
      errorWidget: (context, url, error) {
        return const  Icon(Icons.error);
      },
    );
  }
}