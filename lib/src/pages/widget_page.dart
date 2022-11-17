import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:practica2/models/preferences.dart';

class WidgetPage extends StatefulWidget {
  const WidgetPage({super.key});

  @override
  State<WidgetPage> createState() => _WidgetPageState();
}

class _WidgetPageState extends State<WidgetPage> {
  // Declaram les variables de funcionament
  late Color _colorPri; // color capçalera
  late Color _colorSec; // color fons
  late Color _colorBot; // color botons
  late double _tamanyText; // tamany text

  @override
  void didChangeDependencies() {
    final Preferences preferencies =
        ModalRoute.of(context)!.settings.arguments as Preferences;

    // Assignacio de valors a parametres
    _colorPri = preferencies.primari!;
    _colorSec = preferencies.secundari!;
    _colorBot = preferencies.botons!;
    _tamanyText = preferencies.tamanyText!;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _colorPri,
        title: Text("Widget"),
        // Als menu superior es posa un menú de tamany de lletra
        // es un PopupMenuButton amb tamanys prefixats
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              // Guardam el tamany directament.
              setState(() {
                _tamanyText = value;
              });
            },
            itemBuilder: (BuildContext bc) {
              return const [
                PopupMenuItem(
                  child: Text("Tamany lletra petita"),
                  value: 12.0,
                ),
                PopupMenuItem(
                  child: Text("Tamany lletra normal"),
                  value: 16.0,
                ),
                PopupMenuItem(
                  child: Text("Tamany lletra gran"),
                  value: 20.0,
                )
              ];
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20.0),
            _colorPrimari(),
            SizedBox(height: 20.0),
            _colorSecundari(),
            SizedBox(height: 20.0),
            _colorBotons(),
          ],
        ),
      ),
      backgroundColor: _colorSec,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: _colorBot,
        onPressed: () {
          //Al clicar al boto de guardar, es crea un objecte Preferences que se torna al Home
          Preferences preEnviar = new Preferences(
            primari: _colorPri,
            secundari: _colorSec,
            botons: _colorBot,
            tamanyText: _tamanyText,
          );

          Navigator.of(context)
              .pop(preEnviar); //Al fer el pop, treim la pantalla de la pila
        },
        child: Icon(Icons.save),
      ),
    );
  }

  // A traves del mètode _colorPrimari, obtindrem un menu emergent on podrem seleccionar
  // el colot de la capçalera. El un widget de tipus ListTile que ens permet posar un
  // titol i un botó. Aquest sera l'encarregat de criar a una pantalla emergent que
  // retornarà un color
  _colorPrimari() {
    return ListTile(
      title: Text(
        "Color barra superior",
        style:
            TextStyle(fontSize: _tamanyText), // El tamany del text es variable
      ),
      trailing: FloatingActionButton(
        backgroundColor: _colorBot, // El color del boto es variable
        heroTag: "colorPrincipal",
        child: Icon(Icons.colorize),
        onPressed: () {
          // Al pitjar el boto obre un dialeg per triar el color
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Seleccioni el color'),
                content: SingleChildScrollView(
                  child: BlockPicker(
                    // El BlockPicker tria colors fixes
                    pickerColor: _colorPri, //default color
                    onColorChanged: (Color color) {
                      //on color picked
                      setState(() {
                        _colorPri = color;
                        //tancar pantalla emergent
                        Navigator.of(context).pop();
                        //print(_colorSec);
                      });
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // El widget colorSecudari funciona igual que _colorPrimari
  _colorSecundari() {
    return ListTile(
      title: Text(
        "Color fons finestra",
        style: TextStyle(fontSize: _tamanyText),
      ),
      trailing: FloatingActionButton(
        backgroundColor: _colorBot,
        heroTag: "colorSecundari",
        child: Icon(Icons.colorize),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Selecciona el color'),
                content: SingleChildScrollView(
                  child: MaterialPicker(
                    // El Material Picker tria games d'un color
                    pickerColor: _colorSec, //default color
                    onColorChanged: (Color color) {
                      //on color picked
                      setState(() {
                        _colorSec = color;
                      });
                    },
                  ),
                ),
                actions: <Widget>[
                  FloatingActionButton(
                    child: Icon(Icons.color_lens_outlined),
                    onPressed: () {
                      Navigator.of(context).pop(); //dismiss the color picker
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  // El widget colorBotons funciona igual que _colorPrimari
  _colorBotons() {
    return ListTile(
      title: Text(
        "Color dels botons",
        style: TextStyle(fontSize: _tamanyText),
      ),
      trailing: FloatingActionButton(
        backgroundColor: _colorBot,
        heroTag: "colorBotons",
        child: Icon(Icons.colorize),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Selecciona el color'),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    // El ColoPicker tria tot l'espectre
                    pickerColor: _colorBot, //default color
                    onColorChanged: (Color color) {
                      //on color picked
                      setState(() {
                        _colorBot = color;
                      });
                    },
                  ),
                ),
                actions: <Widget>[
                  FloatingActionButton(
                    backgroundColor: _colorBot,
                    child: Icon(Icons.color_lens_outlined),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
