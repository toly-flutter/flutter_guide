import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class SecondPage extends StatelessWidget {
  SecondPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var text = StoreConnector<int, String>(//直接从状态取值
      converter: (store) => store.state.toString(),
      builder: (context, count) {
        return Text(
          count.toString(),
          style: Theme.of(context).textTheme.display1,
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("SecondPage"),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: text,
      ),
    );
  }
}
