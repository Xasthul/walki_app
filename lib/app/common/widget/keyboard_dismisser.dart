import 'package:flutter/material.dart';

class KeyboardDismisser extends StatelessWidget {
  const KeyboardDismisser({
    super.key,
    required Widget child,
  }) : _child = child;

  final Widget _child;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: _hideKeyboard,
        child: _child,
      );

  void _hideKeyboard() => FocusManager.instance.primaryFocus?.unfocus();
}
