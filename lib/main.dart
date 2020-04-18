import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp()); //calls build method in Widget
// }
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var questionIndex = 0;

    void answerQuestion() {
      setState(() {
        questionIndex = questionIndex + 1;
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
            Text(questions[questionIndex]),
            RaisedButton(
              child: Text('Answer 1'),
              onPressed: answerQuestion,
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
