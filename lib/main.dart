import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nya_mobile/data/nya_request_model.dart';
import 'package:nya_mobile/data/nya_shared_link_provider.dart';
import 'package:nya_mobile/pages/nya_home_page.dart';
import 'package:nya_mobile/pages/nya_reports_page.dart';
import 'package:nya_mobile/pages/nya_results_page.dart';
import 'package:nya_mobile/pages/nya_settings_page.dart';
import 'package:nya_mobile/prefs/nya_prefs.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NyaPrefs.init({'api_url': 'http://192.168.1.147:8000/'});
  NyaPredictRequestModel.init(NyaPrefs.instance.getString('api_url')!);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => NyaPredictRequestModel()),
      ChangeNotifierProvider(create: (context) => NyaSharedLinkProvider()),
    ],
    child: const _NyaApp(),
  ));
}

class SharedLink {
  final String? value;

  SharedLink(this.value);
}

class _NyaApp extends StatelessWidget {
  const _NyaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var primaryColor = const Color(0xffdd2d4a);

    return MaterialApp(
      title: 'Nyaural nyatworks',
      home: const _NyaMainWidget(),
      theme: ThemeData(
        primaryColor: primaryColor,
        unselectedWidgetColor: const Color(0xffa3a3a3),
        iconTheme: IconThemeData(
          color: primaryColor,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.all(15),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        textTheme: const TextTheme(
          headline4: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 30,
            color: Color(0xff2e0c19),
          ),
          headline6: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Color(0xff2e0c19),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(primaryColor),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
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
  final _pageController = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var selectColor = Theme.of(context).primaryColor;
    var unselectColor = Theme.of(context).unselectedWidgetColor;

    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          children: [
            const NyaHomePage(),
            NyaResultsPage(),
            const NyaReportsPage(),
            const NyaSettingsPage(),
          ],
          onPageChanged: (index) => setState(() {
            _currentIndex = index;
          }),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Theme.of(context).unselectedWidgetColor,
        // showUnselectedLabels: true,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/ic_home.svg',
              color: _currentIndex == 0
                ? selectColor
                : unselectColor,
            ),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/ic_results.svg',
              color: _currentIndex == 1
                ? selectColor
                : unselectColor,
            ),
            label: 'Результаты',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/ic_reports.svg',
              color: _currentIndex == 2
                ? selectColor
                : unselectColor,
            ),
            label: 'Отчеты',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/ic_setting.svg',
              color: _currentIndex == 3
                ? selectColor
                : unselectColor,
            ),
            label: 'Настройки',
          ),
        ],
        onTap: switchScreen,
      ),
    );
  }

  void switchScreen(int index) {
    if (index == _currentIndex) {
      return;
    }

    _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
    );

    setState(() {
      _currentIndex = index;
    });
  }
}
