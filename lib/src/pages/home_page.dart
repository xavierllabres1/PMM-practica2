import 'package:flutter/material.dart';
import 'package:practica2/models/user.dart';
import 'package:practica2/models/preferences.dart';
import 'package:practica2/models/userPref.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Variables
  User _persona = User(
    nom: "Xavier",
    llinatge: "Llabrés Drover",
    email: "xavierllabres1@paucasesnovescifp.cat",
    password: "1234",
    dataNaixament: "15/12/1982",
  );

  // Objecte Preferences -> Preferencies. Agafa uns valors fixes
  Preferences _preferencies = Preferences();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SPPMMD"),
        backgroundColor: _preferencies.primari,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    // Al haver d'enviar un objecte amb els parametres de persona i
                    // els parametres de les preferencies, ho englobam a un objecte
                    // contenidor.
                    UserPref userPref = UserPref(_persona, _preferencies);

                    // s'envia l'objecte contenidor.
                    Navigator.pushNamed(context, 'personal',
                            arguments: userPref)
                        .then((value) {
                      // Es recupera l'objecte nomes si s'envia
                      if (value != null) {
                        print(value);
                        _persona = value as User;
                        setState(() {});
                      } else {
                        //print("value = NULL");
                      }
                    });
                  },
                  iconSize: 70.0,
                  icon: Icon(
                    Icons.account_circle,
                  ),
                ),
                SizedBox(
                  width: 20.0,
                  height: 20.0,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'widget',
                            arguments: _preferencies)
                        .then((value) {
                      //print(value);

                      if (value != null) {
                        setState(() {
                          _preferencies = value as Preferences;
                          //print("pri" + _preferencies.primari.toString());
                          //print("sec" + _preferencies.secundari.toString());
                        });
                      } else {
                        print("value = NULL");
                      }
                    });
                  },
                  iconSize: 70.0,
                  icon: Icon(
                    Icons.settings,
                  ),
                ),
              ],
            ),
            SizedBox(height: 100.0),

            // Frasse que s'havia de posar segons l'enunciat.
            Text("Seleccioni la opció.",
                style: TextStyle(fontSize: _preferencies.tamanyText)),
          ],
        ),
      ),
      backgroundColor: _preferencies.secundari,
    );
  }
}
