import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quizzler_quiz/Quiz_Brain.dart';

void main() {
  runApp(Quizzler());
}

QuizBrain quizBrain = QuizBrain();

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Quizpage(),
        ),
      ),
    );
  }
}

class Quizpage extends StatefulWidget {
  @override
  _QuizpageState createState() => _QuizpageState();
}

class _QuizpageState extends State<Quizpage> {
  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getCorrectAnswer();
    if (correctAnswer == userPickedAnswer) {
      score.add(
        Icon(
          Icons.check,
          color: Colors.green,
        ),
      );
    } else {
      score.add(
        Icon(
          Icons.close,
          color: Colors.red,
        ),
      );
    }
    setState(() {
      if (quizBrain.isFinished() == true) {
        quizBrain.resetQuestion();
        score = [];
      } else {
        quizBrain.nextQuestion();
      }
    });
  }

  List<Icon> score = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            // ignore: deprecated_member_use
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              onPressed: () {
                checkAnswer(true);
              },
              child: Center(
                child: Text(
                  'True',
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            // ignore: deprecated_member_use
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.red,
              onPressed: () {
                checkAnswer(false);
              },
              child: Center(
                child: Text(
                  'False',
                ),
              ),
            ),
          ),
        ),
        Row(
          children: score,
        )
      ],
    );
  }
}
