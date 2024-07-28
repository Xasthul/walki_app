import 'package:flutter/material.dart';

class AppDependencies extends StatelessWidget {
  const AppDependencies({
    super.key,
    required Widget child,
  }) : _child = child;

  final Widget _child;

  // TODO(naz): add app dependencies
  @override
  Widget build(BuildContext context) => _child;
}
