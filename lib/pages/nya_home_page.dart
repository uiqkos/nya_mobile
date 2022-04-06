import 'package:flutter/material.dart';
import 'package:nya_mobile/data/nya_caching.dart';
import 'package:nya_mobile/widgets/settings/nya_selection_setting.dart';
import 'package:nya_mobile/widgets/settings/nya_string_setting.dart';
import 'package:nya_mobile/data/nya_predict_request.dart';
import 'package:nya_mobile/data/nya_request_model.dart';
import 'package:provider/provider.dart';
import 'package:nya_mobile/main.dart';

import '../data/nya_api.dart';
import '../prefs/nya_prefs.dart';
import '../widgets/nya_misstype_widget.dart';
import '../widgets/nya_model_selection_widget.dart';

class NyaHomePage extends StatefulWidget {
  const NyaHomePage({Key? key}) : super(key: key);

  @override
  _NyaHomePageState createState() => _NyaHomePageState();
}

class _NyaHomePageState extends State<NyaHomePage> {
  static const Map<String, String> _translate = {
    'toxic': 'Токсичность',
    'sentiment': 'Эмоциональность',
    'sarcasm': 'Саркастичность',
  };

  @override
  Widget build(BuildContext context) {
    var requestModel = context.watch<NyaPredictRequestModel>();

    return Padding(
      padding: const EdgeInsets.all(20),
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
            NyaSelectionSetting(
              name: 'input_method',
              displayName: 'Социальная сеть',
              optionByKey: const {
                'Определить автоматически': 'auto',
                'Youtube': 'youtube',
                'VK': 'vk'
              },
              defaultValue: 'Определить автоматически',
            ),
            FutureBuilder<String?>(
              future: getSharedLink(),
              builder: (ctx, snapshot) {
                return NyaStringSetting(
                  key: Key(snapshot.hasData.toString()),
                  overrideValue: snapshot.data,
                  name: 'text',
                  displayName: 'Текст',
                  hintText: 'Текст',
                  defaultValue: 'https://vk.com/feed?w=wall-183293188_1025586',
                );
              },
            ),
            const SizedBox(height: 20),
            FutureBuilder(
              future: NyaCacherProvider.provide('models').getCache(
                  'models',
                  requestModel.getModels
              ),
              builder: (
                BuildContext context,
                AsyncSnapshot<List<NyaModel>> snapshot
              ) {
                switch(snapshot.connectionState){
                  case ConnectionState.none:
                    return const Text('Empty');

                  case ConnectionState.waiting:
                    return const Text('Awaiting result...');

                  default:
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());

                    } else if (snapshot.hasData) {
                      var models = snapshot.data!;

                      NyaPrefs.instance.setStringList(
                          'targets',
                          models
                              .map((e) => e.target)
                              .toSet()
                              .toList()
                      );

                      var modelsByTarget = models
                        .fold(
                          <String, List<NyaModel>>{},
                          (Map<String, List<NyaModel>> previousValue, element) {
                            if (!previousValue.containsKey(element.target)){
                              previousValue[element.target] = [];
                            }
                            previousValue[element.target]!.add(element);
                            return previousValue;
                          }
                        );

                      return Column(
                        children: modelsByTarget
                          .entries
                          .map((entry) {
                            return [
                              const Divider(
                                color: Color(0x2E0C1914),
                                thickness: 2,
                              ),
                              NyaModelSelection(
                                displayName: _translate[entry.key]!,
                                name: entry.key,
                                models: entry.value,
                              )
                            ];
                          })
                          .expand((element) => element)
                          .toList()
                          ..add(const Divider(
                            color: Color(0x2E0C1914),
                            thickness: 2,
                          ))
                      );
                    } else {
                      return Column();
                    }
                }
              },
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: TextButton(
                  child: const Text(
                    'Провести анализ',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () {
                    NyaCacherProvider
                        .provide('request')
                        .invalidateAll();

                    requestModel.clear();
                    requestModel.request = NyaPredictRequest(
                      text: NyaPrefs.instance.getString('text')!,
                      inputMethod: NyaPrefs.instance.getString('input_method')!,
                      perPage: 3,
                      page: 1
                    );

                    NyaPrefs
                      .instance
                      .getStringList('targets')
                      ?.forEach((target) {
                        var modelName = NyaPrefs.instance.getString(target);
                        if (modelName != null) {
                          requestModel.request!.models[target] = modelName;
                        }
                      });

                  },
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
