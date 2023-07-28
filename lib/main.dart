import 'package:flutter/material.dart';
import 'package:hangman/constants.dart/question_answer.dart';
import 'package:hangman/ui/main_wid.dart';
import 'package:hangman/ui/words.dart';
import 'package:hangman/utils/game.dart';

import 'constants.dart/color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainUiPage(),
    );
  }
}

class MainUiPage extends StatefulWidget {
  const MainUiPage({super.key});

  @override
  State<MainUiPage> createState() => _MainUiPageState();
}

class _MainUiPageState extends State<MainUiPage> {
  int index = 0;
  bool isWon = true;
  handleResult() {
    setState(() {
      for (int i = 0; i < myAnswer[index].length; i++) {
        String char = myAnswer[index][i];

        if (!Game.rightChar.contains(char)) {
          isWon = false;

          break;
        }
        if (Game.rightChar.contains(char)) {
          isWon = true;
        }
      }
      if (isWon) {
        Game.selectedChar = [];
        Game.rightChar = [];
        Game.tries = 0;
        index = (index + 1) % myQuestion.length;
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Game Over"),
                content: const Text("You Won"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Play Again"))
                ],
              );
            });
      }
      if (Game.tries == 6) {
        Game.selectedChar = [];
        Game.tries = 0;
        Game.rightChar = [];
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Game Over"),
                content: const Text("You Lost"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Play Again"))
                ],
              );
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        title: const Text(
          "Hangman",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Stack(
              children: [
                figureImage(Game.tries >= 0, "assets/hang.png"),
                figureImage(Game.tries >= 1, "assets/head.png"),
                figureImage(Game.tries >= 2, "assets/body.png"),
                figureImage(Game.tries >= 3, "assets/ra.png"),
                figureImage(Game.tries >= 4, "assets/la.png"),
                figureImage(Game.tries >= 5, "assets/rl.png"),
                figureImage(Game.tries >= 6, "assets/ll.png"),
              ],
            ),
          ),
          Text(
            myQuestion[index],
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: myAnswer[index]
                  .split('')
                  .map((e) => letter(e.toUpperCase(),
                      !Game.selectedChar.contains(e.toUpperCase())))
                  .toList(),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 250.0,
            child: GridView.count(
              crossAxisCount: 7,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              padding: const EdgeInsets.all(8.0),
              children: alphabets.map((e) {
                return RawMaterialButton(
                  onPressed: Game.selectedChar.contains(e)
                      ? null
                      : () {
                          Game.selectedChar.add(e);
                          if (myAnswer[index].contains(e)) {
                            Game.rightChar.add(e);
                          } else {
                            Game.tries++;
                          }
                          handleResult();
                        },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  fillColor: Game.selectedChar.contains(e)
                      ? Colors.black87
                      : Colors.blue,
                  child: Text(
                    e,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
