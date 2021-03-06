import 'package:flutter/material.dart';
import 'package:nya_mobile/prefs/nya_prefs.dart';
import 'package:nya_mobile/widgets/nya_text_field.dart';
import 'package:nya_mobile/widgets/settings/nya_setting_widget.dart';

class NyaStringSetting extends NyaSettingWidget {
  final String name;
  final String displayName;
  final String hintText;
  final String defaultValue;
  final String? overrideValue;

  NyaStringSetting({
    Key? key,
    required this.name,
    required this.displayName,
    required this.hintText,
    this.overrideValue,
    this.defaultValue = "",
  }) : super(key: key) {
    NyaPrefs
        .getInstance()
        .setString(name, overrideValue ?? defaultValue);
  }

  @override
  State<NyaStringSetting> createState() => _NyaStringSettingState();
}

class _NyaStringSettingState extends State<NyaStringSetting> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: NyaTextField(
        displayName: widget.displayName,
        hintText: widget.hintText,
        controllerEditor: (TextEditingController controller) {
          controller.text =
              widget
                .overrideValue
              ?? NyaPrefs
                .getInstance()
                .getString(widget.name)
              ?? widget
                .defaultValue;
        },
        onEditingComplete: (TextEditingController controller) {
          NyaPrefs.getInstance().setString(widget.name, controller.text);
        },
      ),
    );
  }
}