import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required TextEditingController controller,
    required String hint,
    String? errorText,
    Function(String)? onChanged,
  })  : _controller = controller,
        _hint = hint,
        _errorText = errorText,
        _onChanged = onChanged;

  final TextEditingController _controller;
  final String _hint;
  final String? _errorText;
  final Function(String)? _onChanged;

  @override
  Widget build(BuildContext context) => TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: _hint,
          border: _buildBorder(Colors.grey),
          focusedBorder: _buildBorder(Colors.grey),
          errorText: _errorText,
          // errorStyle: AppTextTheme.of(context).captionRegular,
        ),
        // style: AppTextTheme.of(context).body1Regular,
        autocorrect: false,
        onChanged: _onChanged,
      );

  InputBorder _buildBorder(Color color) => OutlineInputBorder(
        borderSide: BorderSide(color: color),
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      );
}
