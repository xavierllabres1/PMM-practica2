import 'package:flutter/material.dart';
import 'package:practica2/src/pages/home_page.dart';
import 'package:practica2/src/pages/personal_page.dart';
import 'package:practica2/src/pages/widget_page.dart';

Map<String, WidgetBuilder> getRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => HomePage(),
    'personal': (BuildContext context) => PersonalPage(),
    'widget': (BuildContext context) => WidgetPage(),
  };
}
