import 'package:flutter/material.dart';
import 'package:nya_mobile/widgets/settings/nya_selection_setting.dart';
import 'package:nya_mobile/widgets/settings/nya_string_setting.dart';
import 'package:nya_mobile/data/nya_predict_request.dart';
import 'package:nya_mobile/data/nya_request_model.dart';
import 'package:nya_mobile/main.dart';
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
            ],
            onChanged: (_InputMethod? value) => setState(() {
              _inputMethod = value!;
            }),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 0, 10),
            child: Text('URL', style: Theme.of(context).textTheme.headline6),
          ),
          FutureBuilder<String?>(
            future: getSharedLink(),
            builder: (ctx, snapshot) {
              String value;
              if (snapshot.connectionState == ConnectionState.waiting) {
                  value = _text;
              } else {
                  value = snapshot.data ?? _text;
              }

              return TextFormField(
                key: Key(value),
                initialValue: value,
                decoration: const InputDecoration(
                  labelText: 'URL',
                ),
                onChanged: (text) => _text = text,
              );
            },
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: TextButton(
              child: const Text('Провести анализ', style: TextStyle(
                fontSize: 18,
              ),),
              onPressed: () {
                requestModel.request = NyaPredictRequest(
                    text: _text,
                    inputMethod: _inputMethod.name
                );
                requestModel.notifyListeners();
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
