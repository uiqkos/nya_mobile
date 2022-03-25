import 'package:flutter/material.dart';
import 'package:nya_mobile/prefs/nya_prefs.dart';
import 'package:nya_mobile/widgets/nya_info_label.dart';
import 'package:nya_mobile/widgets/settings/nya_setting_widget.dart';

class NyaSelectionSetting extends NyaSettingWidget {
  final String name;
  final String displayName;
  final String defaultValue;
  final List<String> options;

  const NyaSelectionSetting({
    Key? key,
    required this.name,
    required this.displayName,
    required this.defaultValue,
    required this.options,
  }) : super(key: key);

  @override
  State<NyaSelectionSetting> createState() => _NyaSelectionSettingState();
}

class _NyaSelectionSettingState extends State<NyaSelectionSetting> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: NyaInfoLabel(
        name: widget.displayName,
        child: DropdownButtonFormField(
          items: widget.options.map((elem) => DropdownMenuItem(
            value: elem,
            child: Text(elem),
          )).toList(growable: false),
          value: NyaPrefs.instance.getString(widget.name) ?? widget.defaultValue,
          onChanged: (value) => setState(() {
            if (value != null) {
              NyaPrefs.instance.setString(widget.name, value as String);
            }
          }),
        ),
      ),
    );
  }
}