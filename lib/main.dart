import 'package:fluent_ui/fluent_ui.dart';
import 'package:nya_mobile/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initSharedPrefs(await SharedPreferences.getInstance());

  runApp(const NyaApp());
}

class NyaApp extends StatelessWidget {
  const NyaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: "Nyaural nyatworks",
      theme: ThemeData(

      ),
      home: const _MainPage(),
    );
  }
}

class _MainPage extends StatelessWidget {
  const _MainPage({Key? key}) : super(key: key);

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

