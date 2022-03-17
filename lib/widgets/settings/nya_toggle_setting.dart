import 'package:fluent_ui/fluent_ui.dart';
import 'package:nya_mobile/prefs/nya_prefs.dart';
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
      child: InfoLabel(
        label: widget.displayName,
        child: ToggleSwitch(
          checked: _isChecked(),
          content: Text(_isChecked() ? "Вкл." : "Выкл."),
          onChanged: (value) => setState(() {
            NyaPrefs.instance.setBool(widget.name, value);
          }),
        ),
      ),
    );
  }

  bool _isChecked() => NyaPrefs.instance.getBool(widget.name) ?? widget.defaultValue;
}