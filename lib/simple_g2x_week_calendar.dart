library g2x_week_calendar;
import 'package:flutter/material.dart';

class G2xSimpleWeekCalendar extends StatefulWidget {
  G2xSimpleWeekCalendar(
    this.currentDate,
    {this.strWeekDays = const ["Dom","Seg","Ter","Qua","Qui","Sex","Sab"], this.format = "dd/MM/yyyy"}
  );
  DateTime currentDate;
  final List<String> strWeekDays;
  final String format;
  @override
  _G2xSimpleWeekCalendarState createState() => _G2xSimpleWeekCalendarState();
}

class _G2xSimpleWeekCalendarState extends State<G2xSimpleWeekCalendar> {
  var weekDays = <int>[];
  var selectedIndex = 0;

  DateTime _getFirstDateOfWeek(DateTime date){
    return date.weekday == 7 ? date : date.add(new Duration(days: -date.weekday));
  }

  List<int> _getDaysOfWeek(){
    var firstDay = _getFirstDateOfWeek(widget.currentDate);
    var days = <int>[];
    for (var i = 0; i < 7; i++) {
      days.add(firstDay.add(new Duration(days: i)).day);
    }
    return days;
  }

  _setSelectedDate(int index){
    setState(() {
       selectedIndex = index;
       widget.currentDate = _getFirstDateOfWeek(widget.currentDate).add(new Duration(days: index));
    });
  }

  _altertWeek(int days){
    setState(() {
       widget.currentDate = widget.currentDate.add(new Duration(days: days));
    });
  }

  String _formatDate(DateTime date){
    var str = widget.format.replaceAll("dd", date.day.toString());
    str = str.replaceAll("MM", date.month.toString());
    str = str.replaceAll("yyyy", date.year.toString());
    return str;
  }

  @override
    void initState() {
      super.initState();
      selectedIndex = widget.currentDate.weekday == 7 ? 0 : widget.currentDate.weekday;
    }

  @override
  Widget build(BuildContext context) {
    weekDays = _getDaysOfWeek();

    var defaultTextStyle = new TextStyle(

    );

    var selectedTextStyle = new TextStyle(
      color: Colors.red
    );

    var rowWeeks = new Column(
      children: <Widget>[
        new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new InkWell(
              onTap: ()=> _altertWeek(-7),
              child: new Icon(Icons.arrow_left),
            ),
            new Text(_formatDate(widget.currentDate)),
            new InkWell(
              onTap: ()=> _altertWeek(7),
              child: new Icon(Icons.arrow_right),
            ),
          ],
        ),
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: widget.strWeekDays.map((i){
            return new InkWell(
              onTap: ()=> _setSelectedDate(widget.strWeekDays.indexOf(i)),
              child: new Column(
                children: <Widget>[
                  new Text(i,
                    style: selectedIndex == widget.strWeekDays.indexOf(i) ? selectedTextStyle : defaultTextStyle),
                  new Text(weekDays[widget.strWeekDays.indexOf(i)].toString(),
                    style: selectedIndex == widget.strWeekDays.indexOf(i) ? selectedTextStyle : defaultTextStyle)
                ],
              ),
            );
          }).toList()
        )
      ],
    );
    return Container(
      child: rowWeeks,
    );
  }
}