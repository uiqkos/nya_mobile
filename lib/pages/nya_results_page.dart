import 'package:flutter/material.dart';

class NyaResultsPage extends StatelessWidget {
  const NyaResultsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 150, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Результатов пока нет', style: Theme.of(context).textTheme.headline4),
          Image(image: AssetImage('assets/images/idk.png')),
        ],
      ),
    );
  }
}
