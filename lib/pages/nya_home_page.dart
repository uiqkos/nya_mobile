import 'package:flutter/material.dart';
import 'package:nya_mobile/widgets/settings/nya_selection_setting.dart';
import 'package:nya_mobile/widgets/settings/nya_string_setting.dart';
import 'package:nya_mobile/data/nya_predict_request.dart';
import 'package:nya_mobile/data/nya_request_model.dart';
import 'package:provider/provider.dart';
import 'package:nya_mobile/main.dart';
import 'package:nya_mobile/widgets/nya_misstype_widget.dart';

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
            const Padding(
              padding: EdgeInsets.all(32),
              child: SizedBox(
                height: 100,
                child: NyaMissTypeWidget(
                  text: 'Nyaural Nyatworks',
                  textStyle: TextStyle(
                    fontFamily: 'ElectroHarmonix',
                    fontSize: 40,
                  ),
                  typeInterval: Duration(milliseconds: 300),
                ),
              ),
            ),
            const NyaSelectionSetting(
              name: 'social_network',
              displayName: 'Социальная сеть',
              options: ['Определить автоматически', 'Youtube'],
              defaultValue: 'Определить автоматически',
            ),
            FutureBuilder<String?>(
              future: getSharedLink(),
              builder: (ctx, snapshot) {
                return NyaStringSetting(
                  key: Key(snapshot.hasData.toString()),
                  overrideValue: snapshot.data,
                  name: 'url',
                  displayName: 'URL',
                  hintText: 'URL',
                );
              },
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
