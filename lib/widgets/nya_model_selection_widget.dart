import 'package:flutter/material.dart';
import 'package:nya_mobile/data/nya_caching.dart';
import 'package:nya_mobile/data/nya_request_model.dart';
import 'package:nya_mobile/widgets/nya_info_label.dart';
import 'package:nya_mobile/widgets/settings/nya_setting_group.dart';
import 'package:provider/provider.dart';

import '../data/nya_api.dart';
import '../prefs/nya_prefs.dart';

class NyaModelSelection extends StatefulWidget {
  final String name;
  final String displayName;
  final List<NyaModel> models;

  const NyaModelSelection({
    required this .name,
    required this .displayName,
    this .models = const [],
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NyaModelSelectionState();
}

class _NyaModelSelectionState extends State<NyaModelSelection> {

  @override
  Widget build(BuildContext context) {
    var requestModel = context.watch<NyaPredictRequestModel>();

    return NyaSettingsGroup(
      displayName: widget.displayName,
      children: widget
        .models
        .map<Widget>((model) =>
          ListTile(
            title: Text(model.displayName),
            contentPadding: const EdgeInsets.all(0),
            horizontalTitleGap: 0,
            leading: Radio<String>(
              activeColor: Theme.of(context).iconTheme.color,
              toggleable: true,
              value: model.name,
              groupValue: NyaPrefs.instance.getString(model.target),
              onChanged: (String? value) => setState(() {
                NyaPrefs.instance.setString(model.target, model.name);
              })
            ),
          )
        )
        .toList()
    );
  }
}
