import 'package:flutter/material.dart';
import 'package:nya_mobile/prefs/nya_prefs.dart';
import 'package:nya_mobile/widgets/nya_info_label.dart';
import 'package:nya_mobile/widgets/settings/nya_setting_widget.dart';

class NyaToggleSetting extends NyaSettingWidget {
  final String name;
  final String displayName;
  final bool defaultValue;

  const NyaToggleSetting({
    Key? key,
    required this.name,
    required this.displayName,
    required this.defaultValue,
  }) : super(key: key);

  @override
  State<NyaToggleSetting> createState() => _NyaToggleSettingState();
}

class _NyaToggleSettingState extends State<NyaToggleSetting> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: NyaInfoLabel(
        name: widget.displayName,
        child: Switch(
          value: _isChecked(),
          onChanged: (value) => setState(() {
            NyaPrefs.instance.setBool(widget.name, value);
          }),
        ),
      ),
    );
  }

  bool _isChecked() => NyaPrefs.instance.getBool(widget.name) ?? widget.defaultValue;
}