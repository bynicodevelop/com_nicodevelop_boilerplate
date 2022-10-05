import "package:flutter/material.dart";
import "package:validators/validators.dart";

class EmailInputComponent extends StatefulWidget {
  final String label;
  final String errorText;
  final TextEditingController controller;

  const EmailInputComponent({
    super.key,
    required this.controller,
    this.label = "E-mail",
    this.errorText = "Invalid e-mail",
  });

  @override
  State<EmailInputComponent> createState() => _EmailInputComponentState();
}

class _EmailInputComponentState extends State<EmailInputComponent> {
  final FocusNode _focusNode = FocusNode();
  bool _hasError = false;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() => _hasError = !isEmail(widget.controller.text));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key("email"),
      focusNode: _focusNode,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.label,
        errorText: _hasError ? widget.errorText : null,
      ),
    );
  }
}
