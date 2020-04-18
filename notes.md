# Flutter hobby project

###### 

[toc]





## Basic Dart

### Resources

- spelen met Dart in browser: https://dartpad.dev/

- zeer goede dart tour/reference voor meeste dingen: https://dart.dev/guides/language/language-tour

### Basic Syntax/concepts

- In Dart, alles is een Object. Er zijn geen primitieve value types. Alles dat gedeclareert wordt maar niet geinitialiseerd is null, (de default value).
- dart heeft top level functions en functions gekoppeld aan een class of object.
- Dart heeft top level variabelen en variabelen gekoppeld aan een class of object. 
- geen accessibility keywords (public, protected) enkel _name voor private op library niveau
- de keywords: https://dart.dev/guides/language/language-tour#keywords
- final en const.
  - const is een compiletime constante, en imutable
  - final is immutable wanneer hij gezet wordt. Een final variable

```dart
var foo = const[];

foo = [1, 2, 3]; // was const[]
```

Bovenstaande is een geldige operatie want de value was cosnt, niet de variabele

## Basic Flutter

```dart
void main() => runApp(MyApp()); // takes object as arg and calls build method
//the runApp only accepts Widgets, so The Widget, MyApp also needs to return a Widget
```

Widgets are normal Dart classes / objects. But they're only usable as Widgets if you extend StatelessWidget or StatefulWidget and add a build() method.



### Different types of Widgets

there are 2 main types of widgets, The Visible Widgets, related to input and output. and Invisible Widgets, related to structuring Widgets.

#### Visible Widgets (Output & Input)

- raisedButton(), Text(), Card(), ...
- are drawn onto the screen: "What the user sees"

#### Invisible Widgets

- Row(), Column(), ListView(), ...
- gives your app structure and control how visible widgets are drawn onto  the screen (indirectly visible)



##### Column

Accepts in its constructor an argument children of type "List of Widgets"

```dart
     body: Column(
          children: <Widget>[],
        )
```

if we populate a Column with data, we might do it like so

```dart
        body: Column(
          children: <Widget>[
            Text('The question!'),
            RaisedButton(
              child: Text('Answer 1'),
              onPressed: null,
            ),
```

Here we add to Widgets to the Column's children i.e. a List of Widgets, A Text Widget and a RaisedButton Widget, seperated by ",".   Our app now looks like this.

<img src="C:\src\flutterprojects\flutter_app\notes.assets\image-20200418115849436.png" alt="image-20200418115849436" style="zoom:100%;" />

The RaisedButton is a good opportunity to introduce passing functions in different ways.

### Basic functioning

Zoom in on the RaisedButton. Now it takes a null for named parameter onPressed. If we hover over OnPressed in our IDE we get the type of the argument  `{void Function() onPressed}`. Here the argument accepts a function which returns null, and has no arguments. If we add this to our class.

```dart
    void answerQuestion(){
      print('Answer chosen');
    }
```

we might expect that what onPressed takes the following:

```dart
onPressed: answerQuestion(),
```

However, this is mistaken. The syntax after the colon is not passing a function, but **calling** a function.  by calling the function, the function will be executed and will return. This is not what we want. But How should we **pass** the function then? By **pointing** to the name of the function in OnPressed:

```dart
onPressed: answerQuestion,
```

alternatively you can write,

```dart
onPressed: () => answerQuestion(),
```



Now passing a function that only has one line that prints "Answer chosen" is a bit silly.  Should we really have a method for this? Enter

##### anonymous functions

we can replace our previous function pointer with an anonymous method like so. 

```dart
onPressed: () => print('Answer chosen'),
```

or with curly braces

```dart
onPressed: () {
	//do some stuff...
	print("Answer Chosen");
}),
```

note that this is still an function definition. To execute it immediately after defining it, you can add parentheses behind the function definition. Of course this will not work in the OnPressed of the RaisedButton Widget.

```dart
onPressed: () {
	//do some stuff...
	print("Answer Chosen");
}() ),
```



### State

consider following code. 

```dart
...
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  var questionIndex = 0;
  var questions = [
    "What's your favorite color?",
    "What's your favorite animal?"
  ];

  @override 
  Widget build(BuildContext context) {

    void answerQuestion() {
      questionIndex = questionIndex + 1;
      print(questionIndex);
    }

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
          ], //<Widget>[]
        ), //Column
      ), //Scaffold
    ); //MaterialApp
  }
}
```

The App looks like this.

![image-20200418130915670](C:\src\flutterprojects\flutter_app\notes.assets\image-20200418130915670.png)



Now, if we press the button the button, questionIndex (defined on top in class) will increment by one and will be print. The questionIndex is now 1 instead of 0, as we see in the debug console. Lets look back at our app.

![image-20200418131152582](C:\src\flutterprojects\flutter_app\notes.assets\image-20200418131152582.png)

hm, strange. It appears that while our questionindex is 1, Our Text Widget isn't updated. you would expect that `Text(questions[questionIndex]),` with questionIndex=1 the Text Widget would display:   "What's your favorite animal?" Because Text(questions[1]) is Text( "What's your favorite animal?").
But it doesn't do this. This is a problem of state.

#### Understanding state



State is, in general, Data or information used by your app.
App State: Authenticated Users, Loaded Jobs,

Widget State: Current User input on which a Widget should change/appear/disappear. This is the case for a loading spinner, or our example of our questionindex.

Stateless widgets, like Text or Column, will not change their state. At the moment of construction of the Text Widget. It will hold it's data with no way to change it.

![image-20200418132655678](C:\src\flutterprojects\flutter_app\notes.assets\image-20200418132655678.png)

The big difference between a Stateless and a State-full Widget is the Internal State in State-full Widgets. Whenever The external input changes **or** it's internal state changes, the UI will update itself, re-render itself.

So you can add (and also change) properties in a StatelessWidget, there's no way of telling Flutter that it should re-run build() upon such changes.

All widgets (i.e. both Stateless and Stateful) can receive data via their constructors. But only StatefulWidgets can have class properties where they can update values + re-run build().

So, we need a StatefulWidget as our class so that every change in the Widget tree will update the UI.

1. first extend the top class from StatefulWidget
2. add a second class, named MyAppSate and extend State.

```dart
class MyApp extends StatefulWidget {

}

class MyAppState extends State{
  var questionIndex = 0;
...
```

Why use two classes? Because state is persistent, but UI is not. We do not want to refresh the state when inputdata changes. For it will reset our state, losing the  "progress" or state we are keeping in it. The Statefulwidget should rebuilt and rerender itself when MyAppState changes and therefore the State changes.

But for the Statfulwidget to update based on the State we must connect the two classes. This is done by:

1. extending myAppState with State\<MyApp>  
2. in the StatefulWidget, override the CreateState() method and return The Stateclass.

```dart
class MyApp extends StatefulWidget {
@override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp>{ ... }
```

If we now try to run our new code, hmm. It will still not work. That is because we should let the State now it's being updated. If Flutter permitted the UI to be rerendered with every touch on every part of the screen, we would have horrible performance. So we must be specific.

```dart
class MyApp extends StatefulWidget {
@override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp>{
  var questionIndex = 0;    
  
  void answerQuestion() {
    setState(() {
      questionIndex = questionIndex + 1;
    });
      print(questionIndex);
      ...
```

! if it doesn't work, try to hard restart the app. 

add in setState() a function with the variabele that changes. setState() is a "trigger" that informs Flutter that it needs to re-run build() of the Widget.

Flutter is pretty smart and efficient. It will rebuild only that Widget for which the data has been updated. 

### private properties

add a leading underscore on the classname to make it private. Now its only usable in this file. you can do the same for variables and methods.

### The Container

![image-20200418152640882](C:\src\flutterprojects\flutter_app\notes.assets\image-20200418152640882.png)

### passing callback functions around

