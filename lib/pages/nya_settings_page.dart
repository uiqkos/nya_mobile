import 'package:fluent_ui/fluent_ui.dart';
import 'package:nya_mobile/widgets/settings/nya_parser_setting.dart';
import 'package:nya_mobile/widgets/settings/nya_selection_setting.dart';

class NyaSettingsPage extends StatelessWidget {
  const NyaSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const NyaSelectionSetting(
                  name: "theme",
                  displayName: "Тема",
                  options: ["Светлая", "Тёмная", "Системная"],
                  defaultValue: "Светлая",
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InfoLabel(
                    label: "Настройки парсеров",
                    child: Column(
                      children: const [
                        NyaParserSetting(
                          name: "vk",
                          displayName: "ВКонтакте",
                        ),
                        NyaParserSetting(
                          name: "youtube",
                          displayName: "YouTube",
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
