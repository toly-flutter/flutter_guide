
import 'package:flutter/material.dart';
import 'package:flutter_guide/first_demo_by_redux/second_page.dart';
import 'package:flutter_guide/todo_list/todo_list.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

final todoListStore = Store<TodoState>(todoReducer,
      initialState:
      TodoState(todos: <Todo>[], text: "", showType: ShowType.all));


class TodoPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var app = MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Flutter Redux Demo"),
        ),
        body: TodoList(store: todoListStore,),
      ),
    );
    return app;
  }
}
