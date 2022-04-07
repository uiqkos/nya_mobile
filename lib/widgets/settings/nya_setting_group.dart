import 'package:flutter/material.dart';
import 'package:nya_mobile/data/nya_caching.dart';
import 'package:nya_mobile/widgets/settings/nya_setting_widget.dart';

import '../../prefs/nya_prefs.dart';

class NyaSettingsGroup extends NyaSettingWidget {
  final String displayName;
  final List<Widget> children;
  final Widget? icon;

  const NyaSettingsGroup({
    Key? key,
    required this.displayName,
    required this.children,
    this.icon,
  }) : super(key: key);

  @override
  State<NyaSettingsGroup> createState() => _NyaSettingGroupState();
}

class _NyaSettingGroupState extends State<NyaSettingsGroup> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: NyaPrefs
              .getInstance()
              .getBool(widget.displayName) ?? false,
          onExpansionChanged: (bool isExpand) {
            NyaPrefs
              .getInstance()
              .setBool(widget.displayName, isExpand);
          },
          leading: widget.icon,
          title:  Text(widget.displayName),
          textColor: Theme.of(context).textTheme.headline4?.color,
          iconColor: Theme.of(context).iconTheme.color,
          children: widget.children,
        ),
      ),
    );
  }
}