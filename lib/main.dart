import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class DollarFormatter extends TextInputFormatter{
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // TODO: implement formatEditUpdate
    return newValue.copyWith(text: double.tryParse(newValue.text).toStringAsFixed(2));
  }
} 

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Tip calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  double _sliderValue = 0;
  double price = 0;
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title, style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '\$0.00',
                  //prefixText: '\$',
                ),
              keyboardType: TextInputType.number,
//              inputFormatters: [DollarFormatter(), ],
              controller: myController,
              onSubmitted: (text) {

                price = double.tryParse(myController.text.toString());
                myController.text = '\$'+ double.tryParse(myController.text).toStringAsFixed(2);
                setState(() => price);

              },

              autofocus: true,
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 80, color: Colors.black),

            ),
            Align(
              alignment: Alignment.centerRight,
              heightFactor: 1,
              child : Row(
                children: <Widget>[
                  Expanded(
                    child:  Text(
                      'Tip('+ '$_counter' +'%)',
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    flex:4
                  ),
                  Expanded(child: Text(
                    '\$'+(price*(_counter/100)).toStringAsFixed(2),
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 20, color: Colors.black),

                  ),
                  ),
                ],
              )
            ),
            Align(
                alignment: Alignment.centerRight,
                heightFactor: 5,
                child : Row(
                  children: <Widget>[
                    Expanded(
                        child:  Text(
                          'total',
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 20, color: Colors.black),

                        ),
                        flex:4
                    ),
                    Expanded(child: Text(
                      '\$'+(price + (price*(_counter/100))).toStringAsFixed(2),
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 20, color: Colors.black),

                    ),
                    ),
                  ],
                )
            ),
            Slider(
              activeColor: Colors.indigoAccent,
              min: 0,
              max: 100,
              onChanged: (newRating) {
                setState(() => _sliderValue = newRating);
                _counter = _sliderValue.toInt();
              },
              value: _sliderValue,
            ),
          ],
        ),
      ),
    );
  }
}
