import 'package:fluent_ui/fluent_ui.dart';

class AnalysisConfig {
  String url = "";
  Map<String, dynamic> params = {};
}

abstract class ConfigParam {
  final String? name;
  final String displayName;

  const ConfigParam(this.name, this.displayName);

  Widget build(AnalysisConfig config);
}

class ConfigGroup extends ConfigParam {
  final List<ConfigParam> children;
  final bool isRoot;

  const ConfigGroup({
    displayName,
    this.isRoot = false,
    required this.children,
  }) : super(null, displayName);

  @override
  Widget build(AnalysisConfig config) {
    var column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children.map((param) {
        return param.build(config);
      }).toList(growable: false),
    );

    var expander = Expander(
      header: Text(displayName),
      initiallyExpanded: true,
      content: column,
    );

    return isRoot ? column : expander;
  }
}

class ConfigSelection extends ConfigParam {
  final List<String> options;

  const ConfigSelection({
    required name,
    required displayName,
    required this.options,
  }) : super(name, displayName);

  @override
  Widget build(AnalysisConfig config) {
    config.params[name!] = options[0];
    return _ConfigSelectionWidget(this, config);
  }
}

class _ConfigSelectionWidget extends StatefulWidget {
  final ConfigSelection _selection;
  final AnalysisConfig _config;

  const _ConfigSelectionWidget(this._selection, this._config, {Key? key})
      : super(key: key);

  @override
  _ConfigSelectionWidgetState createState() => _ConfigSelectionWidgetState();
}

class _ConfigSelectionWidgetState extends State<_ConfigSelectionWidget> {
  int _curIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(widget._selection.displayName),
      ] + List.generate(widget._selection.options.length, (i) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: RadioButton(
            checked: _curIndex == i,
            content: Text(widget._selection.options[i]),
            onChanged: (value) {
              setState(() {
                _curIndex = i;
              });

              widget._config.params[widget._selection.name!] = widget._selection.options[i];
            },
          ),
        );
      }),
    );
  }
}

class AnalysisSetup extends StatefulWidget {
  final ConfigGroup config;
  final Function(AnalysisConfig) onDone;

  const AnalysisSetup({
    required this.config,
    required this.onDone,
    Key? key,
  }) : super(key: key);

  @override
  _AnalysisSetupState createState() => _AnalysisSetupState();
}

class _AnalysisSetupState extends State<AnalysisSetup> {
  final _config = AnalysisConfig();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextBox(
          placeholder: "Введите URL",
          onSubmitted: (url) => setState(() {
            _config.url = url;
          }),
        ),
        widget.config.build(_config),
        const SizedBox(height: 10),
        Button(
          child: const Text("Провести анализ"),
          onPressed: () => widget.onDone(_config),
        ),
      ],
    );
  }
}
