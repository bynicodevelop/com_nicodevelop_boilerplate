import "package:flutter/material.dart";

class TextInputComponent extends StatefulWidget {
  final String label;
  final String errorText;
  final bool isRequire;
  final TextEditingController controller;

  const TextInputComponent({
    Key? key,
    required this.controller,
    this.label = "Text field",
    this.errorText = "Required field",
    this.isRequire = false,
  }) : super(key: key);

  @override
  State<TextInputComponent> createState() => _TextInputComponentState();
}

class _TextInputComponentState extends State<TextInputComponent> {
  final FocusNode _focusNode = FocusNode();
  bool _isError = false;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() =>
            _isError = widget.isRequire && widget.controller.text.isEmpty);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: _focusNode,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.label,
        errorText: _isError ? widget.errorText : null,
      ),
    );
  }
}
