import 'package:fluent_ui/fluent_ui.dart';
import 'package:nya_mobile/prefs/nya_prefs.dart';
import 'package:nya_mobile/widgets/settings/nya_setting_widget.dart';

class NyaStringSetting extends NyaSettingWidget {
  final String name;
  final String displayName;
  final String defaultValue;

  const NyaStringSetting({
    Key? key,
    required this.name,
    required this.displayName,
    this.defaultValue = "",
  }) : super(key: key);

  @override
  State<NyaStringSetting> createState() => _NyaStringSettingState();
}

class _NyaStringSettingState extends State<NyaStringSetting> {
  final controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller.text = NyaPrefs.instance.getString(widget.name) ?? widget.defaultValue;
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
          onEditingComplete: () => NyaPrefs.instance.setString(widget.name, controller.text),
        ),
      ),
    );
  }
}