library g2x_week_calendar;
import 'package:flutter/material.dart';
import 'package:g2x_week_calendar/Util.dart';

typedef void DateCallback(DateTime val);

class G2xSimpleWeekCalendar extends StatefulWidget {
  G2xSimpleWeekCalendar(
    this.currentDate,
    {
      this.strWeekDays = const ["Dom","Seg","Ter","Qua","Qui","Sex","Sab"],
      this.format = "dd/MM/yyyy",this.dateCallback,
      this.defaultTextStyle =  const TextStyle(),
      this.selectedTextStyle = const TextStyle(color: Colors.red),
      this.selectedBackgroundDecoration = const BoxDecoration(),
      this.backgroundDecoration = const BoxDecoration()
    }
  );
  DateTime currentDate;
  final List<String> strWeekDays;
  final String format;
  final DateCallback dateCallback;
  //style
  final TextStyle defaultTextStyle;
  final TextStyle selectedTextStyle;
  final BoxDecoration selectedBackgroundDecoration;
  final BoxDecoration backgroundDecoration;
  @override
  _G2xSimpleWeekCalendarState createState() => _G2xSimpleWeekCalendarState();
}

class _G2xSimpleWeekCalendarState extends State<G2xSimpleWeekCalendar> {
  var weekDays = <int>[];
  var selectedIndex = 0;

  _setSelectedDate(int index){
    setState(() {
      selectedIndex = index;
      widget.currentDate = MyDateTime.getFirstDateOfWeek(widget.currentDate).add(new Duration(days: index));
      if(widget.dateCallback != null)
        widget.dateCallback(widget.currentDate);
    });
  }

  _altertWeek(int days){
    setState(() {
      widget.currentDate = widget.currentDate.add(new Duration(days: days));
      if(widget.dateCallback != null)
        widget.dateCallback(widget.currentDate);
    });
  }

  @override
    void initState() {
      super.initState();
      selectedIndex = widget.currentDate.weekday == 7 ? 0 : widget.currentDate.weekday;
    }

  @override
  Widget build(BuildContext context) {
    weekDays = MyDateTime.getDaysOfWeek(widget.currentDate);
    var rowWeeks = new Column(
      children: <Widget>[
        new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new InkWell(
              onTap: ()=> _altertWeek(-7),
              child: new Icon(Icons.arrow_left, color: widget.defaultTextStyle.color),
            ),
            new Text(MyDateTime.formatDate(widget.currentDate,format: widget.format),
              style: widget.defaultTextStyle),
            new InkWell(
              onTap: ()=> _altertWeek(7),
              child: new Icon(Icons.arrow_right, color: widget.defaultTextStyle.color),
            ),
          ],
        ),
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: widget.strWeekDays.map((i){
            return new InkWell(
              
              onTap: ()=> _setSelectedDate(widget.strWeekDays.indexOf(i)),
              child: new Container(
                padding: new EdgeInsets.all(5),
                decoration: selectedIndex == widget.strWeekDays.indexOf(i) ?
                  widget.selectedBackgroundDecoration : new BoxDecoration(),
                child: new Column(
                  children: <Widget>[
                    new Text(i,
                      style: selectedIndex == widget.strWeekDays.indexOf(i) ?
                        widget.selectedTextStyle : widget.defaultTextStyle),
                    new Text(weekDays[widget.strWeekDays.indexOf(i)].toString(),
                      style: selectedIndex == widget.strWeekDays.indexOf(i) ?
                        widget.selectedTextStyle : widget.defaultTextStyle)
                  ],
                ),
              )
            );
          }).toList()
        )
      ],
    );
    return new Container(
      padding: new EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
      decoration: widget.backgroundDecoration,
      child: rowWeeks,
    );
  }
}