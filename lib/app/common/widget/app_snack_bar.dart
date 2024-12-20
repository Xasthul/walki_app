import 'package:flutter/material.dart';

extension AppSnackBar on ScaffoldMessengerState {
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showInfoSnackBar({required String text}) => showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(text),
        ),
      );

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showErrorSnackBar({required String text}) => showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(text),
        ),
      );
}
