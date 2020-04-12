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
      home: MyHomePage(title: 'Week day'),
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
  //data returned from the component
  DateTime dateCallback;

  _dateCallback(DateTime date){
    dateCallback = date;
    print(dateCallback);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      /*


        simple example of use: G2xSimpleWeekCalendar


       */
      body: G2xSimpleWeekCalendar(50.0, DateTime.now(), dateCallback: (date) => _dateCallback(date), typeCollapse: true,
      backgroundDecoration: new BoxDecoration(color: Colors.blue),)
    );
  }
}
