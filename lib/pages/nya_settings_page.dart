import 'package:fluent_ui/fluent_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

late final SharedPreferences _sharedPrefs;

void initSharedPrefs(SharedPreferences sharedPrefs) {
  _sharedPrefs = sharedPrefs;
}

class NyaSettingsPage extends StatelessWidget {
  const NyaSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SettingsGroup(
                  displayName: "Группа 1",
                  children: [
                    StringSetting(
                      name: "text",
                      displayName: "Текст",
                    ),
                  ],
                ),
                SettingsGroup(
                  displayName: "Группа 2",
                  children: [
                    SelectionSetting(
                      name: "selection",
                      displayName: "Выбор",
                      options: ["Один", "Два", "Три"],
                      defaultValue: "Один",
                    ),
                    ToggleSetting(
                      name: "toggle",
                      displayName: "Опция",
                      defaultValue: true,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

abstract class SettingWidget extends StatefulWidget {
  const SettingWidget();
}

class StringSetting extends SettingWidget {
  final String name;
  final String displayName;
  final String defaultValue;

  const StringSetting({
    required this.name,
    required this.displayName,
    this.defaultValue = "",
  });

  @override
  State<StringSetting> createState() => _StringSettingState();
}

class _StringSettingState extends State<StringSetting> {
  final controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller.text = _sharedPrefs.getString(widget.name) ?? widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 200,
        child: TextBox(
          controller: controller,
          header: widget.displayName,
          onEditingComplete: () => _sharedPrefs.setString(widget.name, controller.text),
        ),
      ),
    );
  }
}

class SelectionSetting extends SettingWidget {
  final String name;
  final String displayName;
  final String defaultValue;
  final List<String> options;

  const SelectionSetting({
    required this.name,
    required this.displayName,
    required this.defaultValue,
    required this.options,
  });

  @override
  State<SelectionSetting> createState() => _SelectionSettingState();
}

class _SelectionSettingState extends State<SelectionSetting> {
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
            value: _sharedPrefs.getString(widget.name) ?? widget.defaultValue,
            onChanged: (value) => setState(() {
              if (value != null) {
                _sharedPrefs.setString(widget.name, value);
              }
            }),
          ),
        ),
      ),
    );
  }
}

class ToggleSetting extends SettingWidget {
  final String name;
  final String displayName;
  final bool defaultValue;

  const ToggleSetting({
    required this.name,
    required this.displayName,
    required this.defaultValue,
  });

  @override
  State<ToggleSetting> createState() => _ToggleSettingState();
}

class _ToggleSettingState extends State<ToggleSetting> {
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
            _sharedPrefs.setBool(widget.name, value);
          }),
        ),
      ),
    );
  }

  bool _isChecked() => _sharedPrefs.getBool(widget.name) ?? widget.defaultValue;
}

class SettingsGroup extends StatelessWidget {
  final String displayName;
  final List<SettingWidget> children;

  const SettingsGroup({
    required this.displayName,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Expander(
        header: Text(displayName),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }
}

