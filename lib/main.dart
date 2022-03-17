import 'package:fluent_ui/fluent_ui.dart';
import 'package:nya_mobile/pages/nya_settings_page.dart';
import 'package:nya_mobile/prefs/nya_prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NyaPrefs.init();

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
      initialRoute: '/settings',
      routes: {
        '/settings': (context) => const NyaSettingsPage(),
      }
    );
  }
}

