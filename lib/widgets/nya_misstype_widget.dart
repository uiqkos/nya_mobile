import 'dart:async';
import 'dart:io';
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
    var random = Random();
    
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
        if (random.nextDouble() < 0.2 && canMistake) {
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
      typedText,
      textAlign: TextAlign.center,
      style: widget.textStyle,
    );
  }
}
