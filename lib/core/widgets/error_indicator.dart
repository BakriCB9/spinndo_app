import 'package:flutter/material.dart';

class ErrorIndicator extends StatelessWidget {
  final String message;

  const ErrorIndicator([this.message = 'Something went wrong!']);

  @override
  Widget build(BuildContext context) {
    // final localization = AppLocalizations.of(context)!;

    return Center(
      child: Text(message, style: Theme.of(context).textTheme.bodySmall),
    );
  }
}
