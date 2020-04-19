import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int _resultScore;
  final Function _resetHandler;

  Result(this._resultScore, this._resetHandler);

  String get resultPhrase {
    var resultText = 'You did it!';
    if (_resultScore <= 8) {
      resultText = 'You are awesome and innocent!';
    } else if (_resultScore <= 12) {
      resultText = 'Pretty likeable!';
    } else if (_resultScore <= 16) {
      resultText = 'You are ... strange?!';
    } else {
      resultText = 'You are so bad!';
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            resultPhrase,
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          FlatButton(
            textColor: Colors.blue,
            child: Text('Restart Quiz!'),
            onPressed: _resetHandler,
          )
        ],
      ),
    );
  }
}
