import 'package:flutter/material.dart';
import 'package:flutter_guide/text_field_test.dart';


void main() {




  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: Text("Flutter之旅"),
      ),
      body: Padding(padding: EdgeInsets.all(20),child: Center(child: InputTest(),),),
    ),
  ));

//    runApp(TodoPage());
}