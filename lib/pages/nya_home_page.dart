import 'package:flutter/material.dart';

class NyaHomePage extends StatefulWidget {
  const NyaHomePage({Key? key}) : super(key: key);

  @override
  _NyaHomePageState createState() => _NyaHomePageState();
}

class _NyaHomePageState extends State<NyaHomePage> {
  var _socialNetwork = _SocialNetwork.auto;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Align(
            alignment: Alignment.center,
            child: Image(
              image: AssetImage('assets/images/logo.png'),
            ),
          ),
          const Text('Социальная сеть'),
          DropdownButton(
            value: _socialNetwork,
            items: const [
              DropdownMenuItem(
                value: _SocialNetwork.auto,
                child: Text('Определить автоматически'),
              ),
              DropdownMenuItem(
                value: _SocialNetwork.youtube,
                child: Text('Youtube'),
              ),
            ],
            onChanged: (_SocialNetwork? value) => setState(() {
              _socialNetwork = value!;
            }),
          ),
          const Text('URL'),
          const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'URL',
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              child: const Text('Провести анализ'),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

enum _SocialNetwork { auto, youtube }
