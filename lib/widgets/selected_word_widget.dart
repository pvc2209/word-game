import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:word_game/controllers/game_controller.dart';

import 'character_widget.dart';

class SelectedWordWidget extends StatelessWidget {
  const SelectedWordWidget({
    Key? key,
  }) : super(key: key);

  List<Widget> _buildWord(GameController gameController) {
    List<String> guessedWordList = gameController.guessedWordList;
    int guessingCharacterIndex = gameController.guessingCharacterIndex.value;

    List<Widget> wordWidget = [];

    for (int i = 0; i < guessedWordList.length; ++i) {
      wordWidget.add(
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: guessingCharacterIndex == i ? Colors.blue : Colors.grey,
                blurRadius: 2.0,
                spreadRadius: 1.0,
              )
            ],
          ),
          child: CharacterWidget(
            char: guessedWordList[i],
            onTap: () {
              gameController.onRemoveFromGeussedWord(i);
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
      () {
        return Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: _buildWord(gameController),
        );
      },
    );
  }
}
