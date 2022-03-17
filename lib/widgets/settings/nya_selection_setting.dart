import 'package:fluent_ui/fluent_ui.dart';
import 'package:nya_mobile/prefs/nya_prefs.dart';
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
      child: InfoLabel(
        label: widget.displayName,
        child: SizedBox(
          width: 200,
          child: Combobox<String>(
            items: widget.options.map((elem) => ComboboxItem(
              value: elem,
              child: Text(elem),
            )).toList(growable: false),
            value: NyaPrefs.instance.getString(widget.name) ?? widget.defaultValue,
            onChanged: (value) => setState(() {
              if (value != null) {
                NyaPrefs.instance.setString(widget.name, value);
              }
            }),
          ),
        ),
      ),
    );
  }
}