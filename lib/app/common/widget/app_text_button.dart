import 'package:flutter/material.dart';
import 'package:vall/app/common/theme/app_colors.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    super.key,
    required VoidCallback? onPressed,
    required String label,
  })  : _onPressed = onPressed,
        _label = label;

  final VoidCallback? _onPressed;
  final String _label;

  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: _onPressed,
        style: const ButtonStyle(overlayColor: WidgetStatePropertyAll(AppColors.primary100)),
        child: Text(
          _label,
          style: const TextStyle(color: AppColors.primary500),
        ),
      );
}
