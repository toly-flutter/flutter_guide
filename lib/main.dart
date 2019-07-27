import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

enum Actions {
  Increment
}


int counterReducer(int state, dynamic action) {
  if (action == Actions.Increment) {
    return state + 1;
  }
  return state;
}

void main() {
  final store =  Store<int>(counterReducer, initialState: 0);

  runApp( FlutterReduxApp(
    title: 'Flutter Redux Demo',
    store: store,
  ));
}

class FlutterReduxApp extends StatelessWidget {
  final Store<int> store;
  final String title;

  FlutterReduxApp({Key key, this.store, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  StoreProvider<int>(

      store: store,
      child:  MaterialApp(
        theme:ThemeData(
          primarySwatch: Colors.blue,
        ),
        title: title,
        home:  Scaffold(
          appBar:  AppBar(
            title:  Text(title),
          ),
          body:  Center(
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Text(
                  'You have pushed the button this many times:',
                ),

                 StoreConnector<int, String>(
                  converter: (store) => store.state.toString(),
                  builder: (context, count) {
                    return  Text(
                      count,
                      style: Theme
                          .of(context)
                          .textTheme
                          .display1,
                    );
                  },
                )
              ],
            ),
          ),
          floatingActionButton:  StoreConnector<int, VoidCallback>(
            converter: (store) {
              return () => store.dispatch(Actions.Increment);
            },
            builder: (context, callback) {
              return  FloatingActionButton(
                onPressed: callback,
                tooltip: 'Increment',
                child:  Icon(Icons.add),
              );
            },
          ),
        ),
      ),
    );
  }
}