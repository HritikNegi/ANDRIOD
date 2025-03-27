import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rock Paper Scissors Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // var list =[1,2,3];
  final Map<int, String> choices = {1: "Rock", 2: "Paper", 3: "Scissors"};
  String result = '';


  String Winner(String user_Choice, String cmp_Choice) {
    if (user_Choice == cmp_Choice) return "It's a tie!";

    // if ((user_Choice == 1 && cmp_Choice == 3) ||
    //     (user_Choice == 3 && cmp_Choice == 1) ||
    //     (user_Choice == 3 && cmp_Choice == 2)) {
    //   return "You win!";
    // }

    if ((user_Choice == "Rock" && cmp_Choice == "Scissors") ||
        (user_Choice == "Paper" && cmp_Choice == "Rock") ||
        (user_Choice == "Scissors" && cmp_Choice == "Paper")) {
      return "You win!";
    }

    else {
      return "Computer wins!";
    }
  }


  void playGame(int user_Choice) {
    int cmp_Choice = Random().nextInt(3) + 1;

    String user_Selection = choices[user_Choice]!;
    String cmp_Selection = choices[cmp_Choice]!;

    String winner = Winner(user_Selection, cmp_Selection);

    //String winner = Winner(user_Choice, cmp_Choice);


    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Result'),
          // content: Text('You chose: $user_Choice\nComputer chose: $cmp_Choice\n$winner'),
          content: Text('You chose: $user_Selection\nComputer chose: $cmp_Selection\n $winner'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('CLOSE'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rock Paper Scissors'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:   Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           // body: Center(child: Column(children: <Widget>[
            Text(
              'Choose your option:',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   body: Center(child: Column(children: <Widget>[
             children: [
                ElevatedButton(
                  onPressed: () => playGame(1),
                  child: Text('Rock'),
                ),
                OutlinedButton(
                  onPressed: () => playGame(2),
                  child: Text('Paper'),
                ),
                FilledButton(
                  onPressed: () => playGame(3),
                  child: Text('Scissors'),
                ),
              ],
          //],
            ),
          ],
        ),
      ),
    );
  }
}
