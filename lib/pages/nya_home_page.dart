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
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 0, 10),
            child: Text('Социальная сеть', style: Theme.of(context).textTheme.headline6),
          ),
          DropdownButtonFormField(
            isExpanded: true,
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
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 0, 10),
            child: Text('URL', style: Theme.of(context).textTheme.headline6),
          ),
          const TextField(
            decoration: InputDecoration(
              labelText: 'URL',
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: TextButton(
              child: const Text('Провести анализ', style: TextStyle(
                fontSize: 18,
              ),),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

enum _SocialNetwork { auto, youtube }
