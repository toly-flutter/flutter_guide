import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';


enum ShowType { all, todo, done }

enum Acts {
  add, //添加到todo
  selectAll, //筛选所有
  selectTodo, //筛选待完成
  selectDone, //筛选已完成
}

class TodoState {
  List<Todo> todos; //列表数据
  String text; //当前输入文字
  ShowType showType;//显示类型
  TodoState({this.todos, this.text, this.showType}); //显示类型
}

TodoState todoReducer(TodoState input, dynamic action) {
  switch (action) {
    case Acts.add:
      if (input.text != null && input.text != "") {
        input.todos.add(Todo(sth: input.text, done: false));
        input.text = "";
      }
      break;
    case Acts.selectAll:
      input.showType=ShowType.all;
      break;
    case Acts.selectTodo:
      input.showType=ShowType.todo;
      break;
    case Acts.selectDone:
      input.showType=ShowType.done;
      break;
  }
  return input;
}


class Todo {
  String sth; //待做事项
  bool done;
  Todo({this.sth, this.done}); //是否已做完
}

class TodoList extends StatefulWidget {
  final Store<TodoState> store;

  TodoList({
    Key key,
    this.store,
  }) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {

  @override
  Widget build(BuildContext context) {
    var textField= StoreConnector<TodoState, TodoState>(
      converter: (store) =>store.state,//转换器，获取仓库，从仓库拿值
      builder: (context, state) {//构造器，构建Widget
        return TextField(
          controller: TextEditingController(text: state.text),
          keyboardType: TextInputType.text,
          textAlign: TextAlign.start,
          maxLines: 1,
          cursorColor: Colors.black,
          cursorWidth: 3,
          style: TextStyle(
              fontSize: 16, color: Colors.lightBlue, backgroundColor: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: '添加一个待办项',
            hintStyle: TextStyle(color: Colors.black26, fontSize: 14),
            contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
            ),
          ),
         onChanged: (str){
           state.text=str;
         },
        );
      },
    );

    var btn = StoreConnector<TodoState, VoidCallback>(
      converter:(store) {
      return () => store.dispatch(Acts.add);//分发动作
    },
      builder: (context, callback) {
        return RaisedButton(
          child: Icon(Icons.add),
          padding: EdgeInsets.zero,
          onPressed: (){
            callback();
            FocusScope.of(context).requestFocus(FocusNode());
          });
      },
    );

    var inputBtn = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: textField,
          width: 200,
        ),
        ClipRRect(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
          child: Container(
            child: btn,
            width: 36,
            height: 36,
          ),
        ),
      ],
    );

    var listInfo = [
      ["全部", Acts.selectAll],
      ["已完成", Acts.selectDone],
      ["未完成", Acts.selectTodo],
    ];

    var op = Row(//操作按钮
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: listInfo.map((e) {
        return StoreConnector<TodoState, VoidCallback>(
          converter: (store) {
            return () => store.dispatch(e[1]);
          },
          builder: (context, callback) {
            return RaisedButton(
              onPressed: callback,
              child: Text(e[0]),
              color: Colors.blue,
            );
          },
        );
      }).toList(),
    );

    var listView = StoreConnector<TodoState, TodoState>(
        converter: (store) => store.state, //转换器，获取仓库，从仓库拿值
        builder: (context, state) {
          var result;
          //构造器，构建Widget
          switch(state.showType){
            case ShowType.all:
              result= formList(state.todos);
              break;
            case ShowType.todo:
              result= formList(List.of( state.todos.where((e)=>!e.done)));
              break;
            case ShowType.done:
              result= formList(List.of( state.todos.where((e)=>e.done)));
              break;
          }
         return result;
        });

    return StoreProvider<TodoState>(
      store: widget.store,
      child: Column(
        children: <Widget>[inputBtn, op, Expanded(child: listView)],
      ),
    );
  }

  Widget formList(List<Todo> todos) {
    return ListView.builder(
      itemCount: todos.length,
      padding: EdgeInsets.all(8.0),
      itemExtent: 50.0,
      itemBuilder: (BuildContext context, int index) {
        var key = todos[index].sth;
        var value = todos[index].done;
        var text = Align(
          child: Text(
            key,
            style: TextStyle(
                decorationThickness: 3,
                decoration:
                    value ? TextDecoration.lineThrough : TextDecoration.none,
                decorationColor: Colors.blue),
          ),
          alignment: Alignment.centerLeft,
        );

        return Card(
          child: Row(
            children: <Widget>[
              Checkbox(
                onChanged: (b) {
                  todos[index].done = b;
                  setState(() {});
                },
                value: todos[index].done,
              ),
              text
            ],
          ),
        );
      },
    );
  }
}
