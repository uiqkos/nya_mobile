import 'package:flutter/material.dart';

class NyaInfoLabel extends StatelessWidget {
  final String name;
  final Widget child;

  const NyaInfoLabel({
    Key? key,
    required this.name,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 0, 10),
          child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(name, style: Theme.of(context).textTheme.headline6)
          ),
        ),
        child,
      ],
    );
  }
}