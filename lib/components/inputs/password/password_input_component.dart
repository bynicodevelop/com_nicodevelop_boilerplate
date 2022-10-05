import "package:flutter/material.dart";

class PasswordInputComponent extends StatefulWidget {
  final String label;
  final String errorText;
  final int minValidLength;
  final TextEditingController controller;

  const PasswordInputComponent({
    super.key,
    required this.controller,
    this.label = "Password",
    this.errorText = "Invalid password",
    this.minValidLength = 5,
  });

  @override
  State<PasswordInputComponent> createState() => _PasswordInputComponentState();
}

class _PasswordInputComponentState extends State<PasswordInputComponent> {
  final FocusNode _focusNode = FocusNode();
  bool _hasError = false;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() =>
            _hasError = widget.controller.text.length <= widget.minValidLength);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key("password"),
      obscureText: _obscureText,
      focusNode: _focusNode,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.label,
        errorText: _hasError ? widget.errorText : null,
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
    );
  }
}
