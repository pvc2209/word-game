import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:settings_ui/settings_ui.dart';

import '../controllers/settings_controller.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SettingsController controller = Get.put(SettingsController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: Obx(
        () => Container(
          color: Theme.of(context).primaryColor,
          child: SettingsList(
            sections: [
              SettingsSection(
                title: Text(
                  'General',
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                tiles: <SettingsTile>[
                  SettingsTile.navigation(
                    leading: const Icon(Icons.language),
                    title: const Text(
                      'Language',
                    ),
                    value: const Text('English'),
                  ),
                  SettingsTile.switchTile(
                    activeSwitchColor: Theme.of(context).primaryColor,
                    onToggle: (value) {
                      controller.changeTheme();
                    },
                    initialValue: controller.isDark.value,
                    leading: const Icon(Icons.dark_mode),
                    title: const Text('Dark theme'),
                  ),
                  SettingsTile.navigation(
                    leading: const Icon(Icons.update),
                    title: const Text(
                      'Check for update',
                    ),
                  ),
                  SettingsTile.navigation(
                    leading: const Icon(Icons.help),
                    title: const Text(
                      'Help & Feedback',
                    ),
                  ),
                ],
              ),
              SettingsSection(
                title: Text(
                  'Game play',
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                tiles: <SettingsTile>[
                  SettingsTile.switchTile(
                    activeSwitchColor: Theme.of(context).primaryColor,
                    onToggle: (value) {
                      controller.changeAutoScan();
                    },
                    initialValue: controller.autoScan.value,
                    leading: const Icon(Icons.loop),
                    title: const Text('Reset card when done'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
