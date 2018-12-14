# g2x_week_calendar

A new Flutter package project.

## Getting Started

This project is a starting point for a Dart
[package](https://flutter.io/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our 
[online documentation](https://flutter.io/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.

## Example

import 'package:g2x_week_calendar/g2x_simple_week_calendar.dart';

DateTime date;
G2xSimpleWeekCalendar(
    DateTime.now(),
    format: "dd/MM/yyyy",
    strWeekDays: ["Dom","Seg","Ter","Qua","Qui","Sex","Sab"],
    backgroundDecoration: new BoxDecoration(color: Colors.black),
    defaultTextStyle: new TextStyle(color: Colors.white),
    selectedTextStyle: new TextStyle(color: Colors.black, fontSize: 16),
    selectedBackgroundDecoration: new BoxDecoration(color: Colors.white,
    borderRadius: new BorderRadius.circular(5)),
    dateCallback: (val) => date = val
)