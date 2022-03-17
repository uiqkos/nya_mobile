import 'package:flutter/material.dart';
import 'package:nya_mobile/pages/nya_home_page.dart';
import 'package:nya_mobile/pages/nya_settings_page.dart';
import 'package:nya_mobile/prefs/nya_prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NyaPrefs.init();

  runApp(const _NyaApp());
}

class _NyaApp extends StatelessWidget {
  const _NyaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nyaural nyatworks',
      home: const _NyaMainWidget(),
      theme: ThemeData(
        iconTheme: const IconThemeData(
          color: Colors.red,
        ),
      ),
    );
  }
}

class _NyaMainWidget extends StatefulWidget {
  const _NyaMainWidget({Key? key}) : super(key: key);

  @override
  State<_NyaMainWidget> createState() => _NyaMainWidgetState();
}

class _NyaMainWidgetState extends State<_NyaMainWidget> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Navigator(
          key: _navigatorKey,
          initialRoute: '/',
          onGenerateRoute: (settings) {
            WidgetBuilder builder;
            switch (settings.name) {
              case '/':
                builder = (ctx) => const NyaHomePage();
                break;
              case 'settings':
                builder = (ctx) => const NyaSettingsPage();
                break;
              default:
                throw Exception('No such route ${settings.name}');
            }
            return MaterialPageRoute(
              builder: builder,
              settings: settings,
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_mark),
            label: 'Результаты',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'Отчеты',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Настройки',
          ),
        ],
      ),
    );
  }
}




