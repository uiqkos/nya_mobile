import 'package:fluent_ui/fluent_ui.dart';
import 'package:nya_mobile/widgets/settings/nya_setting_widget.dart';

class NyaSettingsGroup extends NyaSettingWidget {
  final String displayName;
  final List<NyaSettingWidget> children;

  const NyaSettingsGroup({
    Key? key,
    required this.displayName,
    required this.children,
  }) : super(key: key);

  @override
  State<NyaSettingsGroup> createState() => _NyaSettingGroupState();
}

class _NyaSettingGroupState extends State<NyaSettingsGroup> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Expander(
        header: Text(widget.displayName),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.children,
        ),
      ),
    );
  }
}