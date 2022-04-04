import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:word_game/pages/settings_page.dart';

import '../widgets/custom_outline_button.dart';
import 'game_page.dart';
import 'upgrade_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                child: Text(
                  "WORD GAME",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 46,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 46),
              CustomOutlineButton(
                "PLAY",
                color: Colors.red,
                onPressed: () {
                  Get.to(
                    () => const GamePage(),
                    transition: Transition.cupertino,
                  );
                },
              ),
              const SizedBox(height: 10),
              CustomOutlineButton(
                "Upgrade",
                color: Colors.green,
                onPressed: () {
                  Get.to(
                    () => UpgradePage(),
                    transition: Transition.cupertino,
                  );
                },
              ),
              const SizedBox(height: 10),
              CustomOutlineButton(
                "Settings",
                color: Colors.orange,
                onPressed: () {
                  Get.to(
                    () => const SettingsPage(),
                    transition: Transition.cupertino,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
