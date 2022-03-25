import 'package:flutter/material.dart';
import 'package:nya_mobile/widgets/settings/nya_selection_setting.dart';
import 'package:nya_mobile/widgets/settings/nya_string_setting.dart';
import 'package:nya_mobile/data/nya_predict_request.dart';
import 'package:nya_mobile/data/nya_request_model.dart';
import 'package:provider/provider.dart';

class NyaHomePage extends StatefulWidget {
  const NyaHomePage({Key? key}) : super(key: key);

  @override
  _NyaHomePageState createState() => _NyaHomePageState();
}

class _NyaHomePageState extends State<NyaHomePage> {

  @override
  Widget build(BuildContext context) {
    var requestModel = context.watch<NyaPredictRequestModel>();

    return Padding(
      padding: const EdgeInsets.all(40),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.center,
              child: Image(
                image: AssetImage('assets/images/logo.png'),
              ),
            ),
            const NyaSelectionSetting(
              name: 'social_network',
              displayName: 'Социальная сеть',
              options: ['Определить автоматически', 'Youtube'],
              defaultValue: 'Определить автоматически',
            ),
            const NyaStringSetting(
                name: 'url',
                displayName: 'URL',
                hintText: 'URL',
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: TextButton(
                child: const Text(
                  'Провести анализ',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
