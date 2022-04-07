import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nya_mobile/widgets/nya_info_label.dart';

class NyaTextField extends StatefulWidget {
  final String displayName;
  final String hintText;
  final void Function(TextEditingController controller)? controllerEditor;
  final void Function(TextEditingController controller)? onEditingComplete;

  const NyaTextField({
    Key? key,
    required this.displayName,
    required this.hintText,
    this.controllerEditor,
    this.onEditingComplete,
  }) : super(key: key);

  @override
  State<NyaTextField> createState() => _NyaTextFieldState();
}

class _NyaTextFieldState extends State<NyaTextField> {
  final controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    widget.controllerEditor?.call(controller);
    //controller.text = NyaPrefs.getInstance().getString(widget.name) ?? widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    return NyaInfoLabel(
      name: widget.displayName,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: widget.hintText,
        ),
        onEditingComplete: () => widget.onEditingComplete?.call(controller),
      ),
    );
  }
}