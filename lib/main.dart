import 'package:flutter/material.dart';
import 'package:flutter_guide/todo_list/use_todo.dart';

import 'first_demo_by_redux/redux_app.dart';

void main() {
  runApp(ReduxPage(
    store: store,
  ));

//    runApp(TodoPage());
}