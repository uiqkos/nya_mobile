import 'dart:developer';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:nya_mobile/analysis_setup.dart';

void main() {
  runApp(const NyaApp());
}

class NyaApp extends StatelessWidget {
  const NyaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: "Nyaural nyatworks",
      theme: ThemeData(

      ),
      home: const _MainPage(),
    );
  }
}

class _MainPage extends StatelessWidget {
  const _MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: AnalysisSetup(
            config: _analysisConfig,
            onDone: (config) {
              log(config.params.toString());
            },
          ),
        ),
      ),
    );
  }
}


const _analysisConfig = ConfigGroup(
  displayName: "",
  isRoot: true,
  children: [
    ConfigGroup(
      displayName: "Токсичность",
      children: [
        ConfigSelection(
          displayName: "Модель",
          name: "toxic_model",
          options: [
            "Random constant",
            "RuBert by sismetanin",
            "Russian toxicity classifier by SkolkovoInstitute",
          ],
        ),
      ],
    ),
    ConfigGroup(
      displayName: "Эмоциональность",
      children: [
        ConfigSelection(
          displayName: "Модель",
          name: "emotions_model",
          options: [
            "Random constant",
            "RuBert by blanchefort",
          ],
        ),
      ],
    ),
    ConfigGroup(
      displayName: "Саркастичность",
      children: [],
    ),
    ConfigGroup(
      displayName: "Дополнительные параметры",
      children: [],
    ),
  ],
);

