
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:nya_mobile/models/nya_settings_model.dart';
import 'package:provider/provider.dart';

class NyaSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var settings = context.watch<NyaSettingsModel>();

    return ScaffoldPage(
      content: SafeArea(
        child: Column(
          children: [
            ListView.builder(
            itemCount: settings.,
            itemBuilder: (context, index) {

            })),
          ]
        ),
      ),
    )
  }
}