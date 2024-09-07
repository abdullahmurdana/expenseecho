import 'package:flutter/material.dart';
import 'package:expenseecho/core/utils/theme_colors.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final double? height;
  final double? width;
  final String? Function(String?)? validator;
  final Function(bool)? onFocusChanged; // Add this line

  const PasswordField({
    super.key,
    required this.controller,
    this.hintText,
    this.labelText,
    this.helperText,
    this.validator,
    this.height,
    this.width,
    this.onFocusChanged, // Add this line
  });

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
      if (widget.onFocusChanged != null) {
        widget.onFocusChanged!(_focusNode.hasFocus); // Add this line
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: widget.height ?? 56,
          width: widget.width ?? double.maxFinite,
          child: TextFormField(
            focusNode: _focusNode,
            controller: widget.controller,
            obscureText: _obscureText,
            validator: widget.validator,
            decoration: InputDecoration(
              hintText: widget.hintText ?? '',
              hintStyle: TextStyle(color: darkThemeColor[50]!, fontSize: 16.0),
              labelText: widget.labelText ?? '',
              labelStyle: TextStyle(color: darkThemeColor[50]!, fontSize: 16.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: BorderSide(color: lightThemeColor[20]!, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: BorderSide(color: lightThemeColor[20]!, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: BorderSide(color: lightThemeColor[20]!, width: 1),
              ),
              contentPadding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: darkThemeColor[50],
                ),
                onPressed: _toggleObscureText,
              ),
            ),
            style: TextStyle(
              color: darkThemeColor[50]!,
              fontSize: 16.0,
            ),
          ),
        ),
        if (_isFocused && widget.helperText != null)
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            child: Text(
              widget.helperText!,
              style: TextStyle(color: darkThemeColor[50]!, fontSize: 12.0),
            ),
          ),
      ],
    );
  }
}
