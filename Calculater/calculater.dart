
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CALCULATOR',
      theme: ThemeData(
        //inputDecorationTheme: Colors : color.black,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
      ),
      home: MyHome(),
    );
  }
}
class MyHome extends StatefulWidget{
  @override
  State<MyHome>createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome>{

  final TextEditingController num1 = TextEditingController();
  final TextEditingController num2 = TextEditingController();

double ans=0;

  void calculate(String opr) {
    final double? a = double.tryParse(num1.text);
    final double? b = double.tryParse(num2.text);

    // Check if either input is null
    if (a == null || b == null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Input'),
            content: Text('Please enter valid numerical values.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
      return;
    }

    if (opr == '+') {
      ans = (a + b);
    }
    else if (opr == '/') {
      if (b == 0) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Cannot divide by zero.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ],
            );
          },
        );
        return;
      }
      ans = (a / b);
    }
    else if (opr == '*') {
      ans = a * b;
    }
    else if (opr == '-') {
      ans = a - b;
    }
    else if (opr == '=') {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('RESULT'),
            content: Text('Result is = $ans'),
            backgroundColor: Colors.amber,
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
      //ans = 0; // Reset ans after showing the result
    }
    else {
      // Handle invalid operation
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Input'),
            content: Text('Invalid Operation!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CALCULATOR') ),
      body:Padding  (
        padding: EdgeInsets.all(20.0) ,
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Enter Your Number',
                style: TextStyle(fontSize: 30.0),
              ),
              SizedBox(height: 70.0,),
              
              Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  TextField(
                    controller: num1,
                    decoration: InputDecoration(
                      labelText: 'Input Number A',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  SizedBox(height: 70.0,),

                  TextField(
                    controller: num2,
                    decoration: InputDecoration(
                      labelText: 'Input Number B',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 30.0,),
                  FloatingActionButton(onPressed: ()=> calculate('=')),
                ]
                ),
              SizedBox(height: 70.0,),
              Row(
                children: [
                  ElevatedButton(onPressed: ()=> calculate('+'),
                                child: Text('ADD')),
                  OutlinedButton(onPressed: ()=> calculate('-'),
                                child: Text('SUB')),
                  FilledButton(onPressed: () => calculate('*'),
                      child: Text('MUL')),
                  IconButton(onPressed: () =>calculate('/'),
                                icon: Text('DIV')),
                ],
              )
          ],

          )
      ),
    );
  }


}

