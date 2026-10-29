import 'package:flutter/material.dart';

class LoginInputField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final bool isPassword;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  const LoginInputField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.isPassword = false,
    this.keyboardType,
    this.textInputAction = TextInputAction.done,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  State<LoginInputField> createState() => _LoginInputFieldState();
}

class _LoginInputFieldState extends State<LoginInputField> {
  final FocusNode _focus = FocusNode();
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChanged);
  }

  void _onFocusChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _focus.removeListener(_onFocusChanged);
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final focused = _focus.hasFocus;
    final borderColor = focused
        ? const Color(0xFF3978F6)
        : const Color(0xFFE3E9F2);
    return TextField(
      controller: widget.controller,
      focusNode: _focus,
      obscureText: widget.isPassword && !_visible,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      onTapOutside: (_) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      style: const TextStyle(fontSize: 15, color: Color(0xFF172033)),
      cursorColor: const Color(0xFF3978F6),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(fontSize: 14, color: Color(0xFFA8B4C8)),
        filled: true,
        fillColor: const Color(0xFFF8FAFD),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 15,
        ),
        prefixIcon: Icon(
          widget.prefixIcon,
          size: 20,
          color: focused ? const Color(0xFF3978F6) : const Color(0xFFA8B4C8),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 44),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () => setState(() => _visible = !_visible),
                icon: Icon(
                  _visible
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded,
                  size: 20,
                  color: const Color(0xFFA8B4C8),
                ),
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF3978F6)),
        ),
      ),
    );
  }
}
