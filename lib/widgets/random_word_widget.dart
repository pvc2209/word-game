import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/game_controller.dart';
import 'character_widget.dart';

class RandomWordWidget extends StatelessWidget {
  const RandomWordWidget({Key? key}) : super(key: key);

  List<Widget> _buildWord(GameController gameController) {
    var randomList = gameController.randomWordList;

    List<Widget> wordWidget = [];

    for (int i = 0; i < randomList.length; ++i) {
      wordWidget.add(
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                blurRadius: 2.0,
                color: Colors.red,
              )
            ],
          ),
          child: CharacterWidget(
            char: randomList[i],
            onTap: () {
              gameController.onSelectFromRandomWord(i);
            },
          ),
        ),
      );
    }

    return wordWidget;
  }

  @override
  Widget build(BuildContext context) {
    var gameController = Get.find<GameController>();

    return Obx(
      () => Wrap(
        // mainAxisAlignment: MainAxisAlignment.center,
        spacing: 8.0,
        runSpacing: 8.0,
        children: _buildWord(gameController),
      ),
    );
  }
}
