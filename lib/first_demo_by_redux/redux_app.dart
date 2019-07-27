
import 'package:flutter/material.dart';
import 'package:flutter_guide/first_demo_by_redux/second_page.dart';
import 'package:flutter_guide/todo_list/todo_list.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

final todoListStore = Store<TodoState>(todoReducer,
      initialState:
      TodoState(todos: <Todo>[], text: "", showType: ShowType.all));


class ReduxPage extends StatelessWidget {
  final Store<int> store;

  ReduxPage({Key key, this.store,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var countText = StoreConnector<int, String>(
      converter: (store) => store.state.toString(), //转换器，获取仓库，从仓库拿值
      builder: (context, count) { //构造器，构建Widget
        return Text(
          count,
          style: Theme
              .of(context)
              .textTheme
              .display1,
        );
      },
    );
    var fab = StoreConnector<int, VoidCallback>(
      converter: (store) {
        return () => store.dispatch(Actions.increment);
      },
      builder: (context, callback) {
        return FloatingActionButton(
          onPressed: callback,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        );
      },
    );
    var child = MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Flutter Redux Demo"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  'You have pushed the button this many time'
              ),
              _skipToSecondPage(countText)//显示数字的Text
            ],
          ),
        ),
        floatingActionButton: fab, //点击的按钮
      ),
    );
    return StoreProvider<int>(
      store: store,
      child: child,
    );
  }

  Builder _skipToSecondPage(StoreConnector<int, String> countText) {
    return Builder(
      builder: (context) =>
          InkWell(child: countText, onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return SecondPage();
            }));
          },),
    );
  }
}
enum Actions {
  increment,
  increment10
}


int counterReducer(int input, dynamic action) {
  var output;
  switch (action) {
    case Actions.increment:
      output = input + 1;
      break;
    case Actions.increment10:
      output = input + 10;
      break;
  }
  return output;
}

final store = Store<int>(counterReducer, initialState: 0);
