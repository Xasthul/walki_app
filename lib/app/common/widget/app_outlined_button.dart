import 'package:flutter/material.dart';
import 'package:vall/app/common/theme/app_colors.dart';

class AppOutlinedButton extends StatelessWidget {
  const AppOutlinedButton({
    super.key,
    required VoidCallback? onPressed,
    required String label,
  })  : _onPressed = onPressed,
        _label = label;

  final VoidCallback? _onPressed;
  final String _label;

  @override
  Widget build(BuildContext context) => OutlinedButton(
        onPressed: _onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(AppColors.white),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(color: AppColors.primary200),
            ),
          ),
        ),
        child: Text(
          _label,
          style: const TextStyle(color: AppColors.black),
        ),
      );
}
