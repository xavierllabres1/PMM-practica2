import 'package:flutter/material.dart';
import 'package:practica2/src/routes/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: [
        Locale('en', ''),
        Locale('es', ''),
        Locale('ca', ''),
      ],
      debugShowCheckedModeBanner: false, // Desactiva ribbon Debug
      initialRoute: '/',
      routes: getRoutes(),
    );
  }
}
