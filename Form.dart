import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/main.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'SELF DECLARATION FORM',
      theme: ThemeData(),
      home:  MyForm(),
    );
  }
}
class MyForm extends StatefulWidget{
  @override

  _MyFormState createState() => _MyFormState();

}

class _MyFormState extends State<MyForm>{
  final TextEditingController First_name = TextEditingController();
  final TextEditingController Last_name = TextEditingController();
  final TextEditingController Mail = TextEditingController();
  final TextEditingController Number = TextEditingController();
  bool GRADUATED=false;
  String? College;
  String? School_Board;
  double Marks=0.0;




  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
            title: Text ('SELF-DECLEAR-FORM'),
            backgroundColor: Colors.pinkAccent,

        ),

    body:// Column(
        ListView(
      children: [
        SizedBox(height:20),
        Text('ENTER FIRST NAME'),
        TextField(
          controller: First_name,
          decoration: InputDecoration(
                        labelText: 'first name',
                        border: OutlineInputBorder(),
                      ),
          keyboardType: TextInputType.text,
        ),

        SizedBox(height:10),

        Text('Enter Last Name'),
        TextField(
          controller: Last_name,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
                        labelText:'last name',
                        border: UnderlineInputBorder(),
                      ),
        ),

        SizedBox(height: 10),

        Text('ENTER YOUR MAIL-ID'),
        TextField(
          controller: Mail,
          keyboardType:TextInputType.emailAddress,
          decoration: InputDecoration(
                        label:Text('mail'),
                        border: InputBorder.none,
                      ),
        ),

        SizedBox(height: 10),

        Text('ENTER MOBILE NUMBER'),
        TextField(
          controller: Number,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
                        labelText: 'number',
                        border: OutlineInputBorder(),
                      ),
        ),

        SizedBox(height: 10),

        Text('ARE YOU GRADUATED'),
        Row(
          children: [
            Checkbox(
                value: GRADUATED,
                onChanged: (value){
                  setState(() {
                    GRADUATED = value!;
                  });
                }
            ),
            Text('GRADUATED'),

          ],
        ),


        SizedBox(height: 10),

        Text('SELECT YOUR SCHOOL BOARD'),
        Column (
          children: [

            Radio(
                value: 'CBSE',
                groupValue: School_Board,
                onChanged:(value){
                  setState( ()  {
                    School_Board = value as String?;
                  } );  },
            ),
            Text('CBSE'),

            Radio(
                value: 'ICSE',
                groupValue: School_Board,
                onChanged: (value){
                  setState( ()  {
                    School_Board = value as String?;
                  } );  },
            ),
            Text('ICSE'),

            Radio(
              value: 'UBSE',
              groupValue: School_Board,
              onChanged: (value){
                setState( ()  {
                  School_Board = value as String?;
                } );  },
            ),
            Text('UBSE'),

            Radio(
              value: 'UPBSE',
              groupValue: School_Board,
              onChanged: (value){
                setState(() {
                  School_Board = value as String?;
                } ); },
            ),
            Text('UPBSE'),

          ],
        ),

        SizedBox(height: 10),

        Text('SLIDE YOUR CGPA OR SGPA VALUE : $Marks'),
        Slider(
          value: Marks,
          //divisions:10,
          min:0.0 ,
          max:10.0 ,
          label: Marks.toStringAsFixed(2),
          onChanged: (value){
            setState(() {
              Marks=value ;
            } );
            } ,
        ),

        SizedBox(height:10),

        Text('PICK YOUR COLLAGE: $College'),
        DropdownButton<String>(
            items: <String>['Graphic Collegey','DBS College',
              'ITM College','MIT College'] .map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                      }
                    ).toList(),
            hint: Text('SELECT COLLAGE') ,
            onChanged: (String? newValue) {
                setState(() {
                  College=newValue;
                });
          }
                    // onTap: ,
        )

      ],

    ),
    );
  }
}
