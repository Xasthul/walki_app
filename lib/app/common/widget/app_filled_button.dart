import 'package:flutter/material.dart';
import 'package:vall/app/common/theme/app_colors.dart';

class AppFilledButton extends StatelessWidget {
  const AppFilledButton({
    super.key,
    required VoidCallback? onPressed,
    required String label,
  })  : _onPressed = onPressed,
        _label = label;

  final VoidCallback? _onPressed;
  final String _label;

  @override
  Widget build(BuildContext context) => FilledButton(
        onPressed: _onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((state) {
            if (state.contains(WidgetState.disabled)) {
              return Colors.grey[300];
            }
            return AppColors.primary200;
          }),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        child: Text(
          _label,
          style: const TextStyle(color: AppColors.black),
        ),
      );
}
