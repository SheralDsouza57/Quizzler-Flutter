import 'package:flutter/material.dart';
import 'quiz_brain.dart';

void main() => runApp(const Quizzler());

class Quizzler extends StatelessWidget {
  const Quizzler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black45,
        body: SafeArea(child: QuizPage()),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  QuizBrain quizbrain = QuizBrain();
  List<Widget> scoreKeeper = [];

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizbrain.getQuestionAnswer();
    setState(() {
      if (quizbrain.isFinished() == false) {
        showDialog(
            context: context,
            // barrierColor: Colors.blueGrey,
            builder: (ctx) => AlertDialog(
                  title: const Text('Finished'),
                  content: const Text('You\'ve reached the end of the quiz.'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          color: Colors.blue,
                          padding: const EdgeInsets.all(14),
                          child: const Text(
                            'Okay',
                            style: TextStyle(color: Colors.white),
                          ),
                        ))
                  ],
                ));
        // Alert(
        //   context: context,
        //   title: 'Finished!',
        //   desc: 'You\'ve reached the end of the quiz.',
        // ).show();

        quizbrain.reset();
        scoreKeeper = [];
      } else {
        if (userPickedAnswer == correctAnswer) {
          scoreKeeper.add(
            const Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
        } else {
          scoreKeeper.add(
            const Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        }
        quizbrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                quizbrain.getQuestionText(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(9.0),
            child: TextButton(
              onPressed: () {
                checkAnswer(true);
              },
              child: Container(
                color: Colors.green,
                child: const Center(
                  child: Text(
                    'True',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(9.0),
            child: TextButton(
              onPressed: () {
                checkAnswer(false);
              },
              child: Container(
                color: Colors.red,
                child: const Center(
                  child: Text(
                    'False',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}
