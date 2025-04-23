import 'package:flutter/material.dart';

IconData getIconForPlan(String? planName) {
  switch (planName?.toLowerCase()) {
    case 'basic':
      return Icons.star_border;
    case 'premium':
      return Icons.star_half;
    case 'gold':
      return Icons.star;
    default:
      return Icons.local_offer;
  }
}

Color getColorForPlan(String? planName) {
  switch (planName?.toLowerCase()) {
    case 'basic':
      return Colors.blue;
    case 'premium':
      return Colors.purple;
    case 'gold':
      return Colors.amber;
    default:
      return Colors.grey;
  }
}
