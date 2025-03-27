import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: App(),
      title: 'home',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
    );
  }
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String _userName = '';

  void _onTextChanged(String text) {
    setState(() {
      _userName = text;
    });
  }

  void _onTap() {
    print('Text field tapped');
  }

  // Method to generate the pages based on the selected index
  List<Widget> _getPages() {
    return [
      SingleChildScrollView(   // Wrap the Column with SingleChildScrollView
        child: Column(
          children: <Widget>[
            const Text(
              'Home Page',
              style: TextStyle(color: Colors.greenAccent, fontSize: 50),
            ),
            SizedBox(height: 100),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.lightBlue[50],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('LOGIN'),
                  SizedBox(height: 20),
                  TextField(
                    keyboardType: TextInputType.text,
                    controller: userNameController,
                    decoration: const InputDecoration(
                      labelText: 'UserName',
                      hintText: 'Enter User Name',
                      fillColor: Colors.red,
                      filled: true,
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(color: Colors.blue, fontSize: 20.0),
                    onChanged: _onTextChanged,
                    cursorColor: Colors.amberAccent,
                    onTap: _onTap,
                  ),
                  SizedBox(height: 20),

                  TextField(
                    keyboardType: TextInputType.number,
                    controller: numberController,
                    decoration: const InputDecoration(
                      labelText: 'UserName',
                      hintText: 'Enter number',
                      fillColor: Colors.white10,
                      filled: true,
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(color: Colors.blue, fontSize: 20.0),
                    onChanged: _onTextChanged,
                    cursorColor: Colors.amberAccent,
                    onTap: _onTap,
                  ),
                  SizedBox(height: 20),

                  TextField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: 'UserName',
                      hintText: 'Enter password',
                      fillColor: Colors.red,
                      filled: true,
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(color: Colors.blue, fontSize: 20.0),
                    onChanged: _onTextChanged,
                    cursorColor: Colors.amberAccent,
                    onTap: _onTap,
                  ),

                  SizedBox(height: 20),

                  ElevatedButton(
                      onPressed: (){},
                      child: Text('summit')
                  ),
                  SizedBox(height: 20),

                  const Row(
                    children: <Widget>[
                      Icon(Icons.facebook),
                      SizedBox(width: 10),
                      Icon(Icons.wechat),
                      SizedBox(width: 10),
                      Icon(Icons.gite),
                      SizedBox(width: 10),
                      Icon(Icons.accessible),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Text('Search Page', style: TextStyle(color: Colors.greenAccent, fontSize: 50)),
      Text('Profile Page', style: TextStyle(color: Colors.greenAccent, fontSize: 50)),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        shadowColor: Colors.yellowAccent,
        backgroundColor: Colors.white54,
        elevation: 10.0,
      ),
      body: _getPages()[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.teal),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        elevation: 10,
        backgroundColor: Colors.white,
        iconSize: 24.0,
        selectedItemColor: Colors.tealAccent,
        unselectedItemColor: Colors.pink,
        selectedFontSize: 14.0,
        unselectedFontSize: 12.0,
      ),
      backgroundColor: Colors.deepOrangeAccent,
    );
  }
}
