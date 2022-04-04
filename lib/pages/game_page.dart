import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:word_game/controllers/game_controller.dart';
import 'package:word_game/game_data.dart';
import 'package:word_game/widgets/custom_outline_button.dart';
import 'package:word_game/widgets/random_word_widget.dart';
import 'package:word_game/widgets/selected_word_widget.dart';

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GameController gameController = Get.put(GameController());

    Size size = MediaQuery.of(context).size;
    double screenWidth = size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Word Game"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx(
          () => Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, right: 20),
                  child: Obx(
                    (() => Text(
                          "Score: ${gameController.score}",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.pink,
                          ),
                        )),
                  ),
                ),
                const SizedBox(height: 20),
                Image.asset(
                  words[gameController.currentIndex.value].image,
                  width: screenWidth * 0.5,
                ),
                const SizedBox(height: 20),
                const SelectedWordWidget(),
                const SizedBox(height: 20),
                const RandomWordWidget(),
                const SizedBox(height: 20),
                CustomOutlineButton(
                  "CHECK",
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    bool result = gameController.check();

                    Alert(
                      context: context,
                      type: result ? AlertType.success : AlertType.error,
                      title: "Result",
                      desc: result ? "CORRECT" : "WRONG",
                      buttons: [
                        DialogButton(
                          child: const Text(
                            "OK",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () => Navigator.pop(context),
                          color: Theme.of(context).primaryColor,
                        ),
                        DialogButton(
                          child: const Text(
                            "NEXT",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            gameController.next();

                            if (result) {
                              gameController.increaseScore();
                            }
                          },
                          color: Colors.red,
                        )
                      ],
                    ).show();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
