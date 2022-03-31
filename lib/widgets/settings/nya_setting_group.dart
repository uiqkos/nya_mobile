import 'package:flutter/material.dart';
import 'package:nya_mobile/widgets/settings/nya_setting_widget.dart';

class NyaSettingsGroup extends NyaSettingWidget {
  final String displayName;
  final List<NyaSettingWidget> children;
  final Widget icon;

  const NyaSettingsGroup({
    Key? key,
    required this.displayName,
    required this.children,
    required this.icon,
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