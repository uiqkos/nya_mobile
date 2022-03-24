import 'package:flutter/material.dart';
import 'package:nya_mobile/data/nya_predict_request.dart';
import 'package:nya_mobile/data/nya_request_model.dart';
import 'package:provider/provider.dart';

class NyaHomePage extends StatefulWidget {
  const NyaHomePage({Key? key}) : super(key: key);

  @override
  _NyaHomePageState createState() => _NyaHomePageState();
}

class _NyaHomePageState extends State<NyaHomePage> {
  var _inputMethod = _InputMethod.auto;
  String _text = 'https://vk.com/feed?w=wall-185300191_102035';

  @override
  Widget build(BuildContext context) {
    var requestModel = context.watch<NyaPredictRequestModel>();

    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Align(
            alignment: Alignment.center,
            child: Image(
              image: AssetImage('assets/images/logo.png'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 0, 10),
            child: Text('Социальная сеть', style: Theme.of(context).textTheme.headline6),
          ),
          DropdownButtonFormField(
            isExpanded: true,
            value: _inputMethod,
            items: const [
              DropdownMenuItem(
                value: _InputMethod.auto,
                child: Text('Определить автоматически'),
              ),
              DropdownMenuItem(
                value: _InputMethod.youtube,
                child: Text('Youtube'),
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
          TextFormField(
            initialValue: _text,
            decoration: const InputDecoration(
              labelText: 'URL',
            ),
            onChanged: (text) => _text = text,
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
          ),
        ],
      ),
    );
  }
}

enum _InputMethod { auto, youtube }
