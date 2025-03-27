import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Buttons Example',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Button Types'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TextButton
            TextButton(
              onPressed: () {
                showSnackbar(context, 'Text Button Pressed');
              },
              child: Text('Text Button'),
            ),
            SizedBox(height: 10),

            // ElevatedButton
            ElevatedButton(
              onPressed: () {
                showSnackbar(context, 'Elevated Button Pressed');
              },
              child: Text('Elevated Button'),
            ),
            SizedBox(height: 10),

            // OutlinedButton
            OutlinedButton(
              onPressed: () {
                showSnackbar(context, 'Outlined Button Pressed');
              },
              child: Text('Outlined Button'),
            ),
            SizedBox(height: 10),

            // IconButton
            IconButton(
              onPressed: () {
                showSnackbar(context, 'Icon Button Pressed');
              },
              icon: Icon(Icons.star),
            ),
            SizedBox(height: 10),

            // FloatingActionButton
            FloatingActionButton(
              onPressed: () {
                showSnackbar(context, 'Floating Action Button Pressed');
              },
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
