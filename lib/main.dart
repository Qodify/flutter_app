import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp()); //calls build method in Widget
// }
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  //every Widget needs to extend StatelessWidget or StatefullWidget
  @override //decorator provided by dart, deliberately overriding build method from StatelessWidget
  Widget build(BuildContext context) {
    //flutters job to provide context for you
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First App'),
        ),
        body: Text('This is my default text'),
      ),
    ); //does base setup
  }
}
