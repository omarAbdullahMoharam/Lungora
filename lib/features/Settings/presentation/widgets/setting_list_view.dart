import 'package:flutter/material.dart';

import 'item_setting_list_view.dart';
import 'setting_data.dart';

class SettingListView extends StatelessWidget {
  const SettingListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: SettingData.settingsItem.length,
      itemBuilder: (context, index) {
        final item = SettingData.settingsItem[index];
        return ItemSettingListView(
          title: item.title,
          icon: item.icon,
          screen: item.screen,
          hasSwitch: item.hasSwitch,
          path: item.path,
        );
      },
    );
  }
}
