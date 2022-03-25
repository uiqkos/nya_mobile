import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

const _keyboardLayout = [
  '1234567890-=',
  'qwertyuiop[]',
  'asdfghjkl;',
  'zxcvbnm',
];

String _chooseCharAround(String char) {
  int rowIndex = _keyboardLayout.indexWhere((row) => row.contains(char));
  int colIndex = _keyboardLayout[rowIndex].indexOf(char);

  var random = Random();
  if (random.nextBool()) {
    rowIndex += random.nextBool() ? 1 : -1;
  } else if (random.nextBool()) {
    colIndex += random.nextBool() ? 1 : -1;
  }
  return _keyboardLayout[rowIndex][colIndex];
}

class NyaMissTypeWidget extends StatefulWidget {
  final String text;
  final Duration typeInterval;
  final TextStyle textStyle;
  
  const NyaMissTypeWidget({
    Key? key,
    required this.text,
    required this.textStyle,
    required this.typeInterval,
  }) : super(key: key);

  @override
  _NyaMissTypeWidgetState createState() => _NyaMissTypeWidgetState();
}

class _NyaMissTypeWidgetState extends State<NyaMissTypeWidget> {
  String typedText = "";
  bool lastInvalid = false;
  bool canMistake = false;

  @override
  void initState() {
    super.initState();
    Timer.periodic(widget.typeInterval, typeNextChar);
  }

  void typeNextChar(Timer timer) async {
    if (typedText.length >= widget.text.length && !lastInvalid) {
      timer.cancel();
      return;
    }

    setState(() {
      if (lastInvalid && !canMistake) {
        typedText = typedText.substring(0, typedText.length - 1);
        lastInvalid = false;
      } else  {
        String nextChar = widget.text[typedText.length];
        if (Random().nextBool() && canMistake) {
          nextChar = _chooseCharAround(nextChar);
          lastInvalid = true;
          canMistake = false;
        } else {
          canMistake = true;
        }
        typedText += nextChar;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      typedText.toString(),
      textAlign: TextAlign.center,
      style: widget.textStyle,
    );
  }
}
