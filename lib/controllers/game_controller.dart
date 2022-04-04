import 'package:get/get.dart';

import '../game_data.dart';

class GameController extends GetxController {
  var currentIndex = 0.obs;

  var score = 0.obs;

  var guessedWordList = <String>[].obs;
  var randomWordList = <String>[].obs;

  var guessingCharacterIndex = 0.obs;

  GameController() {
    _init();
  }

  void _init() {
    // clear all previous list
    guessedWordList.clear();
    randomWordList.clear();

    guessingCharacterIndex.value = 0;

    var word = words[currentIndex.value].word;
    for (int i = 0; i < word.length; ++i) {
      guessedWordList.add("_");
    }

    var randomWord = words[currentIndex.value].randomWord;
    for (int i = 0; i < randomWord.length; ++i) {
      randomWordList.add(randomWord[i]);
    }
  }

  void onSelectFromRandomWord(int index) {
    if (guessedWordList.contains("_")) {
      guessedWordList[guessingCharacterIndex.value] = randomWordList[index];

      randomWordList.removeAt(index);

      guessingCharacterIndex.value = guessedWordList.indexOf("_");
    }
  }

  void onRemoveFromGeussedWord(int index) {
    if (guessedWordList[index] != "_") {
      randomWordList.add(guessedWordList[index]);

      guessedWordList[index] = "_";
      guessingCharacterIndex.value = index;
    } else {
      guessingCharacterIndex.value = index;
    }
  }

  bool check() {
    String word = words[currentIndex.value].word;

    for (int i = 0; i < guessedWordList.length; ++i) {
      if (guessedWordList[i] != word[i]) {
        return false;
      }
    }

    return true;
  }

  void next() {
    if (currentIndex < words.length - 1) {
      currentIndex++;
      _init();
    } else {
      currentIndex.value = 0;
      _init();
    }
  }

  void increaseScore() {
    score++;
  }
}
