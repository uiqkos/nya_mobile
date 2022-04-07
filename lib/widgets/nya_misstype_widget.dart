import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const _keyboardLayout = [
  '1234567890-=',
  'qwertyuiop[]',
  'asdfghjkl;',
  'zxcvbnm',
];

String _chooseCharAround(String char) {
  int rowIndex = _keyboardLayout.indexWhere((row) => row.contains(char));
  if (rowIndex == -1) {
    return char;
  }

  int colIndex = _keyboardLayout[rowIndex].indexOf(char);

  var random = Random();
  var vertical = 0;
  var horizontal = 0;

  if (random.nextBool()) {
    vertical = random.nextBool() ? 1 : -1;
  }
  if (random.nextBool()) {
    horizontal = random.nextBool() ? 1 : -1;
  }

  rowIndex = min(rowIndex + vertical, _keyboardLayout.length);
  rowIndex = max(0, rowIndex);

  colIndex = min(colIndex + horizontal, _keyboardLayout[rowIndex].length);
  colIndex = max(0, colIndex);

  return _keyboardLayout[rowIndex][colIndex];
}

class NyaMissTypeWidget extends StatefulWidget {
  final String text;
  final Duration typeInterval;
  final TextStyle initialTextStyle;
  
  const NyaMissTypeWidget({
    Key? key,
    required this.text,
    required this.initialTextStyle,
    required this.typeInterval,
  }) : super(key: key);

  @override
  _NyaMissTypeWidgetState createState() => _NyaMissTypeWidgetState();
}

class _NyaMissTypeWidgetState extends State<NyaMissTypeWidget> {
  late Timer typeTimer;
  String typedText = "";
  bool lastInvalid = false;
  bool canMistake = false;
  TextStyle? textStyle;

  @override
  void initState() {
    super.initState();
    typeTimer = Timer.periodic(widget.typeInterval, typeNextChar);
  }


  @override
  void dispose() {
    super.dispose();
    typeTimer.cancel();
  }

  void typeNextChar(Timer timer) async {
    var random = Random();
    
    if (typedText.length >= widget.text.length && !lastInvalid) {
      timer.cancel();
      setState(() {
        textStyle = widget.initialTextStyle.copyWith(
          decoration: TextDecoration.underline,
          decorationStyle: TextDecorationStyle.wavy,
          decorationColor: Theme.of(context).primaryColor,
          decorationThickness: 4
        );
      });
      return;
    }

    setState(() {
      if (lastInvalid) {
        typedText = typedText.substring(0, typedText.length - 1);
        lastInvalid = false;
      } else  {
        String nextChar = widget.text[typedText.length];
        if (random.nextDouble() < 0.2) {
          var char = nextChar;
          while (char == nextChar) {
            char = _chooseCharAround(nextChar);
          }
          lastInvalid = true;
          nextChar = char;
        }
        typedText += nextChar;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      typedText,
      textAlign: TextAlign.center,
      style: textStyle ?? widget.initialTextStyle,
    );
  }
}
