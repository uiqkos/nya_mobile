import 'package:fluent_ui/fluent_ui.dart';
import 'package:nya_mobile/widgets/settings/nya_setting_group.dart';
import 'package:nya_mobile/widgets/settings/nya_setting_widget.dart';
import 'package:nya_mobile/widgets/settings/nya_string_setting.dart';

class NyaParserSetting extends NyaSettingWidget {
  final String name;
  final String displayName;

  const NyaParserSetting({
    Key? key,
    required this.name,
    required this.displayName,
  }) : super(key: key);

  @override
  State<NyaParserSetting> createState() => _ParserSettingState();
}

class _ParserSettingState extends State<NyaParserSetting> {
  @override
  Widget build(BuildContext context) {
    return NyaSettingsGroup(
      displayName: widget.displayName,
      children: [
        NyaStringSetting(
          name: "${widget.name}/token",
          displayName: "Токен",
        ),
        NyaStringSetting(
          name: "${widget.name}/api_v",
          displayName: "Версия API",
        )
      ],
    );
  }
}

