import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(home: IMGAPP(),title: 'adding img',);
  }
}

class IMGAPP extends StatefulWidget{
  @override
  _IMGAPPState createState() => _IMGAPPState();


}

class _IMGAPPState extends State<IMGAPP>{


 // bool hover=false;
  void  _ishover( bool hover){
    if(hover){
      print('hovering on');
    }
    else{
      print('hovering off');
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title:  const Text('IMAGE UPLOAD',
          style: TextStyle(
              color:Colors.red ,
              fontSize: 30,
              // decorationColor:Colors.yellow ,
              // fontFamily: 'Hindi',
              fontStyle: FontStyle.italic) ,
          textAlign: TextAlign.center,
          selectionColor: Colors.pink,
        ),
        elevation: 10,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50.0), // Height of the bottom widget
          child: Container(
            color: Colors.yellow, // Background color of the bottom widget
            height: 50.0,
            child: const Center(
              child: Text(
                "Upload your images",
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
          ),
        ),
        shadowColor: Colors.green,
        backgroundColor: Colors.blueGrey,
      ),
      backgroundColor: Colors.pink[900],
      body: Padding(
          padding:EdgeInsets.all(0.0) ,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                for (var i = 1; i <= 50; i++)
                  Text('Item $i'),
                Container(
                  color: Colors.tealAccent,width: 100,height:100 ,
                ),
              ],
            ),
          ),

        ),

      persistentFooterButtons: [
        TextButton(
          onPressed: (){
          },
          onHover: _ishover,
          child: Text('first'),
        ),
        IconButton(onPressed: (){}, icon: Text('third'),),
        FloatingActionButton(onPressed: (){},child: Text('fourth'),),
        ElevatedButton(onPressed: (){}, child: Text('firth')),
        OutlinedButton(onPressed: (){}, child: Text('sixth')),

      ],

    );
  }


}
