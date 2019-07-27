import 'package:flutter/material.dart';
import 'package:flutter_guide/second_demo/under_screen.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'count_state.dart';

class TopScreen extends StatefulWidget {
  @override
  _TopScreenState createState() => _TopScreenState();
}

class _TopScreenState extends State<TopScreen> {
  @override
  Widget build(BuildContext context) {

    var text =StoreConnector<CountState, int>(
      converter: (store) => store.state.count,
      builder: (context, count) {
        return Text(
          count.toString(),
          style: Theme.of(context).textTheme.display1,
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Top Screen'),
      ),
      body: Center(
        child: text,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return UnderScreen();
          }));
        },
        child: Icon(Icons.forward),
      ),
    );
  }
}
