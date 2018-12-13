import 'package:flutter/material.dart';
import 'package:g2x_week_calendar/g2x_simple_week_calendar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: new Column(
        children: <Widget>[
          G2xSimpleWeekCalendar(DateTime.now(),
            backgroundDecoration: new BoxDecoration(color: Colors.black),
            defaultTextStyle: new TextStyle(color: Colors.white),
            selectedTextStyle: new TextStyle(color: Colors.black, fontSize: 16),
            selectedBackgroundDecoration: new BoxDecoration(color: Colors.white,
              borderRadius: new BorderRadius.circular(5)),
          )
        ],
      )
    );
  }
}
