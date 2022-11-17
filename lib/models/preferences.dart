import 'package:flutter/material.dart';

// Classe on ses guardarn les preferencies
class Preferences {
  Color? primari;
  Color? secundari;
  Color? botons;
  bool? textEntrada;
  double? tamanyText;

  Preferences({
    this.primari = Colors.black,
    this.secundari = Colors.grey,
    this.botons = Colors.blue,
    this.textEntrada = false,
    this.tamanyText = 16.0,
  });

  Preferences.buit();
}
