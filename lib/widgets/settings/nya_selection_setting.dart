import 'package:flutter/material.dart';
import 'package:nya_mobile/prefs/nya_prefs.dart';
import 'package:nya_mobile/widgets/nya_info_label.dart';
import 'package:nya_mobile/widgets/settings/nya_setting_widget.dart';

class NyaSelectionSetting extends NyaSettingWidget {
  final String name;
  final String displayName;
  final String defaultValue;
  final Map<String, String> optionByKey;
  final Map<String, String> keyByOption;

  NyaSelectionSetting({
    Key? key,
    required this.name,
    required this.displayName,
    required this.defaultValue,
    required this.optionByKey,
  }) : keyByOption = optionByKey.map((key, value) => MapEntry(value, key)), super(key: key) {
    NyaPrefs.getInstance().setString(name, optionByKey[defaultValue]!);
  }

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
          items: widget.optionByKey.entries.map((entry) => DropdownMenuItem(
            value: entry.key,
            child: Text(entry.key),
          )).toList(growable: false),
          value: widget.keyByOption[NyaPrefs.getInstance().getString(widget.name)],
          onChanged: (value) => setState(() {
            if (value != null) {
              NyaPrefs.getInstance().setString(
                  widget.name, widget.optionByKey[value as String]!);
            }
          }),
        ),
      ),
    );
  }
}