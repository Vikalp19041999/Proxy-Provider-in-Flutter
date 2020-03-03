import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyModel with ChangeNotifier {
  String someValue = 'Shubham';

  void doSomething(String value) {
    someValue = value;
    print(someValue);
    notifyListeners();
  }
}

class AnotherModel {
  MyModel _myModel;
  AnotherModel(this._myModel);
  void doSomethingElse() {
    _myModel.doSomething('Vikalp');
    print('See you again');
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MyModel>(create: (context) => MyModel()),
        ProxyProvider<MyModel, AnotherModel>(
          update: (context, myModel, anotherModel) => AnotherModel(myModel),
        )
      ],
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
              title: Text('Proxy Provider in Flutter'),
              centerTitle: true,
              backgroundColor: Colors.lightBlueAccent),
          body: Column(children: <Widget>[
            Padding(padding: EdgeInsets.all(120)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.all(20),
                    color: Colors.green[400],
                    child:
                        Consumer<MyModel>(builder: (context, myModel, child) {
                      return RaisedButton(
                        child: Text('Do Something'),
                        onPressed: () {
                          myModel.doSomething('Shubham');
                        },
                      );
                    })),
                Padding(padding: EdgeInsets.all(10)),
                Container(
                    padding: EdgeInsets.all(35),
                    color: Colors.blue[300],
                    child:
                        Consumer<MyModel>(builder: (context, myModel, child) {
                      return Text(myModel.someValue);
                    })),
              ],
            ),
            Container(
                padding: EdgeInsets.all(35),
                color: Colors.redAccent,
                child: Consumer<AnotherModel>(
                    builder: (context, anotherModel, child) {
                  return RaisedButton(
                    child: Text('Do Something Else'),
                    onPressed: () {
                      anotherModel.doSomethingElse();
                    },
                  );
                }))
          ]),
        ),
      ),
    );
  }
}
