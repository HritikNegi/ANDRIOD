import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Input Types',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InputDemoPage(),
    );
  }
}

class InputDemoPage extends StatefulWidget {
  @override
  _InputDemoPageState createState() => _InputDemoPageState();
}

class _InputDemoPageState extends State<InputDemoPage> {
  // Controllers for text fields
  final TextEditingController textController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  bool _checkboxValue = false;
  String? _selectedRadioValue;
  double _sliderValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Types Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Text Field
            TextField(
              controller: textController,
              decoration: InputDecoration(
                labelText: 'Text Input',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            // Number Input
            TextField(
              controller: numberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Number Input',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            // Checkbox
            Row(
              children: [
                Checkbox(
                  value: _checkboxValue,
                  onChanged: (value) {
                    setState(() {
                      _checkboxValue = value!;
                    });
                  },
                ),
                Text("Check Me"),
              ],
            ),
            SizedBox(height: 16),

            // Radio Buttons
            Text("Select One:"),
            Row(
              children: [
                Radio(
                  value: 'Option 1',
                  groupValue: _selectedRadioValue,
                  onChanged: (value) {
                    setState(() {
                      _selectedRadioValue = value as String?;
                    });
                  },
                ),
                Text("Option 1"),
                Radio(
                  value: 'Option 2',
                  groupValue: _selectedRadioValue,
                  onChanged: (value) {
                    setState(() {
                      _selectedRadioValue = value as String?;
                    });
                  },
                ),
                Text("Option 2"),
              ],
            ),
            SizedBox(height: 16),

            // Slider
            Text("Adjust value: ${_sliderValue.toStringAsFixed(2)}"),
            Slider(
              value: _sliderValue,
              min: 0,
              max: 100,
              divisions: 100,
              label: _sliderValue.round().toString(),
              onChanged: (value) {
                setState(() {
                  _sliderValue = value;
                });
              },
            ),
            SizedBox(height: 16),

            // Dropdown
            DropdownButton<String>(
              hint: Text("Select an option"),
              items: <String>['Option 1', 'Option 2', 'Option 3']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                // Your action
              },
            ),
          ],
        ),
      ),
    );
  }
}
