import 'package:flutter/material.dart';

import 'quiz.dart';
import 'result.dart';

//void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _questions = const [
    {
      'questionText': "What's your favorite color?",
      'answers': [
        {'text': 'Black', 'score': 10},
        {'text': 'Red', 'score': 5},
        {'text': 'Green', 'score': 3},
        {'text': 'White', 'score': 1},
      ],
    },
    {
      'questionText': "What's your favorite animal?",
      'answers': [
        {'text': 'Rabbit', 'score': 3},
        {'text': 'Snake', 'score': 10},
        {'text': 'Elephant', 'score': 5},
        {'text': 'Lion', 'score': 1},
      ],
    },
    {
      'questionText': "Who's yout favorite instructor",
      'answers': [
        {'text': 'Max', 'score': 1},
        {'text': 'Max', 'score': 3},
        {'text': 'Max', 'score': 5},
        {'text': 'Max', 'score': 10},
      ],
    },
  ];
  var _questionIndex = 0; //properties
  var _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score) {
    _totalScore += score;

    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    if (_questionIndex < _questions.length) {
      print('we have more questions');
    }
  }

  @override //decorator provided by dart, deliberately overriding build method from StatelessWidget
  Widget build(BuildContext context) {
    //flutters job to provide context for you

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First App'),
        ),
        body: _questionIndex < _questions.length
            ? Quiz(
                answerQuestion: _answerQuestion,
                questions: _questions,
                questionIndex: _questionIndex,
              )
            : Result(_totalScore, _resetQuiz),
      ),
    ); //does base setup
  }
}
