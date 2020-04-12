library g2x_week_calendar;
import 'package:flutter/material.dart';

import 'Util.dart';

typedef void DateCallback(DateTime val);

class G2xSimpleWeekCalendar extends StatefulWidget {
  G2xSimpleWeekCalendar(
    this.bodyHeight,
    this.currentDate,
    {
      this.strWeekDays = const ["Sun","Mon","Tues","Wed","Thurs","Fri","Sat"],
      this.format = "yyyy/MM/dd",this.dateCallback,
      this.defaultTextStyle =  const TextStyle(),
      this.selectedTextStyle = const TextStyle(color: Colors.red),
      this.selectedBackgroundDecoration = const BoxDecoration(),
      this.backgroundDecoration = const BoxDecoration(),
      this.typeCollapse = false,
    }
  );
  final DateTime currentDate;
  final List<String> strWeekDays;
  final String format;
  final DateCallback dateCallback;
  //style
  final TextStyle defaultTextStyle;
  final TextStyle selectedTextStyle;
  final BoxDecoration selectedBackgroundDecoration;
  final BoxDecoration backgroundDecoration;
  final bool typeCollapse;
  final double bodyHeight;
  @override
  _G2xSimpleWeekCalendarState createState() => _G2xSimpleWeekCalendarState();
}

class _G2xSimpleWeekCalendarState extends State<G2xSimpleWeekCalendar> with TickerProviderStateMixin{
  DateTime currentDate;
  var weekDays = <int>[];
  var selectedIndex = 0;
  var _close = false;

  //Collapse
  AnimationController _collapseController;
  Animation<double> _collpseAnimation;
  var _heightCollapse = 0.0;

  _setSelectedDate(int index){
    setState(() {
      selectedIndex = index;
      currentDate = MyDateTime.getFirstDateOfWeek(currentDate).add(new Duration(days: index));
      if(widget.dateCallback != null)
        widget.dateCallback(currentDate);
    });
  }

  _altertWeek(int days){
    setState(() {
      currentDate = currentDate.add(new Duration(days: days));
      if(widget.dateCallback != null)
        widget.dateCallback(currentDate);
    });
  }

  _collapse(){
    if(!widget.typeCollapse) return;
    if(_collapseController.status == AnimationStatus.completed && _close){
      _collapseController.reverse();
      _close = false;
    }
    else if(_collapseController.status == AnimationStatus.dismissed){
      _collapseController.forward();
      _close = true;
    }
  }

  @override
    void initState() {
      super.initState();
      currentDate = widget.currentDate;
      // if(widget.dateCallback != null)
      //   widget.dateCallback(currentDate);
      selectedIndex = currentDate.weekday == 7 ? 0 : currentDate.weekday;

      //Collapse
      _heightCollapse = widget.bodyHeight;
      _collapseController = new AnimationController(vsync: this, duration: new Duration(milliseconds: 500));
      _collpseAnimation = new Tween<double>(begin: widget.bodyHeight, end: 0).animate(_collapseController);
      _collapseController.addListener((){
        setState(() {
          _heightCollapse = _collpseAnimation.value;
        });
        if(_collapseController.status == AnimationStatus.completed && !_close){
          _collapseController.reset();
          _close = false;
        }
      });
    }

  @override
  Widget build(BuildContext context) {
    weekDays = MyDateTime.getDaysOfWeek(currentDate);
    var size = MediaQuery.of(context).size;
    var sizePart = size.width/4-10;
    var rowWeeks = new Column(
      children: <Widget>[
        new Container(
          decoration: widget.backgroundDecoration,
          padding: new EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new InkWell(
                onTap: ()=> _collapse(),
                child: new Container(
                  width: sizePart,
                  child: new Text(""),
                )
              ),
              new Container(
                width: sizePart * 2,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new InkWell(
                      onTap: ()=> _altertWeek(-7),
                      child: new Icon(Icons.arrow_left, color: widget.defaultTextStyle.color),
                    ),
                    new Text(MyDateTime.formatDate(currentDate,format: widget.format),
                      style: widget.defaultTextStyle),
                    new InkWell(
                      onTap: ()=> _altertWeek(7),
                      child: new Icon(Icons.arrow_right, color: widget.defaultTextStyle.color),
                    )
                  ],
                )
              ),
              new InkWell(
                onTap: ()=> _collapse(),
                child: new Container(
                  alignment: Alignment.centerRight,
                  width: sizePart,
                  child: widget.typeCollapse ? new Icon(_close ? Icons.arrow_drop_up : Icons.arrow_drop_down) : null,
                ),
              )
            ]
          )
        ),
        new Container(
          height: _heightCollapse,
          decoration: widget.backgroundDecoration,
          padding: new EdgeInsets.only(bottom: 5, left: 5, right: 5),
          child: new Row(
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
        )
      ],
    );
    return rowWeeks;
  }
}