import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

enum ShowType { all, todo, done }

class _TodoListState extends State<TodoList> {
  var todo = <String, bool>{};//列表数据
  var text;//当前输入文字
  var showType = ShowType.all;//显示类型

  @override
  Widget build(BuildContext context) {
    var textField = TextField(
      controller: new TextEditingController(text: this.text),
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
      onChanged: (str) {
        text = str;
      },
    );

    var btn = RaisedButton(
      child: Icon(Icons.add),
      padding: EdgeInsets.zero,
      onPressed: () {
        FocusScope.of(context).requestFocus(FocusNode()); //收起键盘
        if (text != null && text != "") {
          todo[text] = false;
          text = "";
          setState(() {});
        }
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

    var op = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        RaisedButton(
          color: Colors.blue,
          textTheme: ButtonTextTheme.primary,
          onPressed: () {
            showType = ShowType.all;
            setState(() {});
          },
          child: Text("全部"),
        ),
        RaisedButton(
          onPressed: () {
            showType = ShowType.done;
            setState(() {});
          },
          child: Text("已完成"),
        ),
        RaisedButton(
          onPressed: () {
            showType = ShowType.todo;
            setState(() {});
          },
          child: Text("未完成"),
        ),
      ],
    );

    return Column(
      children: <Widget>[inputBtn, op, Expanded(child: showList(showType))],
    );
  }

  showList(ShowType showType) {
    switch (showType) {
      case ShowType.all:
        return formList(todo);
        break;
      case ShowType.todo:
        return formList(Map.fromEntries(todo.entries.where((e) => !e.value)));
        break;
      case ShowType.done:
        return formList(Map.fromEntries(todo.entries.where((e) => e.value)));
        break;
    }
  }

  Widget formList(Map<String, bool> todo) {
    return ListView.builder(
      itemCount: todo.length,
      padding: EdgeInsets.all(8.0),
      itemExtent: 50.0,
      itemBuilder: (BuildContext context, int index) {
        var key = todo.keys.toList()[index];
        var value = todo.values.toList()[index];
        var text = Align(
          child: Text(
            todo.keys.toList()[index],
            style: TextStyle(
                decorationThickness: 3,
                decoration: value
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                decorationColor: Colors.blue),
          ),
          alignment: Alignment.centerLeft,
        );

        return Card(
          child: Row(
            children: <Widget>[
              Checkbox(
                onChanged: (b) {
                  todo[key] = b;
                  setState(() {});
                },
                value: todo.values.toList()[index],
              ),
              text
            ],
          ),
        );
      },
    );
  }
}
