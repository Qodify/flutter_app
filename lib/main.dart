import 'package:flutter/material.dart';

import './question.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _questionIndex = 0; //properties

    void _answerQuestion() {
      setState(() {
        _questionIndex = _questionIndex + 1;
      });
    }

  var questions = [
    "What's your favorite color?",
    "What's your favorite animal?"
  ];

  @override //decorator provided by dart, deliberately overriding build method from StatelessWidget
  Widget build(BuildContext context) {
    //flutters job to provide context for you


    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First App'),
        ),
        body: Column(
          children: <Widget>[
            Question(questions[_questionIndex]),
            // Text(questions[_questionIndex]),
            RaisedButton(
              child: Text('Answer 1'),
              onPressed: _answerQuestion,
            ),
            // RaisedButton(
            //   child: Text('Answer 2'),
            //   onPressed: () => answerQuestion(),
            // ),
            // RaisedButton(
            //     child: Text('Answer 3'),
            //     onPressed: () {
            //       //do some stuff...
            //       print("Answer 3 Chosen");
            //     }),
            // RaisedButton(
            //   child: Text('Answer 4'),
            //   onPressed: () => print("Answer 4 Chosen"),
            // ),
          ],
        ),
      ),
    ); //does base setup
  }
}
