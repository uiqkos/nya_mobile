import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nya_mobile/widgets/settings/nya_parser_setting.dart';

class NyaSettingsPage extends StatelessWidget {
  const NyaSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 150,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Настройки',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                ),
                NyaParserSetting(
                  icon: SvgPicture.asset(
                    'assets/icons/vk.svg',
                    color: Theme.of(context).textTheme.headline4?.color,
                  ),
                  name: 'vk',
                  displayName: 'ВКонтакте',
                ),
                NyaParserSetting(
                  icon: SvgPicture.asset(
                    'assets/icons/youtube.svg',
                    color: Theme.of(context).textTheme.headline4?.color,
                  ),
                  name: 'youtube',
                  displayName: 'YouTube',
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      const SizedBox(height: 50,),
                      Text(
                        'О приложении',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      const SizedBox(height: 25,),
                      const Image(
                        image: AssetImage('assets/images/logo.png'),
                        width: 200,
                      ),
                      Text(
                        'Nyaural Nyatworks Mobile',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const Text('Версия 0.0.1-alpha.8.6.4.2'),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
