import 'package:flutter/material.dart';
import 'package:practica2/models/preferences.dart';
import 'package:practica2/models/user.dart';
import 'package:practica2/models/userPref.dart';

class PersonalPage extends StatefulWidget {
  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  // Varibales
  late TextEditingController _controllerNom;
  late TextEditingController _controllerLlinatge;
  late TextEditingController _controllerCorreu;
  late TextEditingController _controllerPassword;
  late TextEditingController _controllerData;
  late String? _nom;
  late String? _llinatge;
  late String? _email;
  late String? _password;
  late String? _dataNaixament;
  late String? _inicials;

  late User persRet = User.buit(); //Persona de retorn
  late Preferences _localPreferencies = Preferences.buit();

  @override
  void didChangeDependencies() {
    // Recuperar objecte del home page
    final _userPref = ModalRoute.of(context)!.settings.arguments as UserPref;

    // Es separa l'objecte contenidor
    final User _persona = _userPref.persona!;

    // Assignar valors a variables locals
    _nom = _persona.nom;
    _llinatge = _persona.llinatge;
    _email = _persona.email;
    _password = _persona.password;

    generarInicials(); // Cridar al mètode per generar les inicials

    print(_inicials);

    // Identificam si l'objecte de retorn (persRet te valor)
    // Així al haver-hi hagut un canvi al es repintarà amb el valor correte
    (persRet.dataNaixament == null)
        ? _dataNaixament = _persona.dataNaixament
        : _dataNaixament = persRet.dataNaixament;

    // Assignar contingut als quadres de text
    _controllerNom = TextEditingController(text: _nom);
    _controllerLlinatge = TextEditingController(text: _llinatge);
    _controllerCorreu = TextEditingController(text: _email);
    _controllerPassword = TextEditingController(text: _password);
    _controllerData = TextEditingController(text: _dataNaixament);

    // Extreire objecte de preferencies
    final Preferences _preferences = _userPref.preferencies!;
    _localPreferencies = _preferences;

    super.didChangeDependencies();
  }

  // Metode per generar les inicials del avatar.
  void generarInicials() {
    _inicials = ((_nom!.isNotEmpty) ? _nom!.substring(0, 1) : '') +
        ((_llinatge!.isNotEmpty) ? _llinatge!.substring(0, 1) : '');
  }

  //Metode per comprovar que es un email
  bool validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value))
      return false;
    else
      return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _localPreferencies.primari,
        title: Text(_llinatge.toString()), //S'agafa el llinatge del User
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10.0),
            child: CircleAvatar(
              child:
                  Text(_inicials.toString()), // s'agafen les inicials del User
              backgroundColor: _localPreferencies.secundari,
            ),
          ),
        ],
      ),
      body: ListView(
        //Es mostra una llista d'elements al body, que s'implementen per separat
        /* Llista d'elements al body */
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        children: [
          _textNom(),
          Divider(),
          _textLlinatge(),
          Divider(),
          _textEmail(),
          Divider(),
          _textPassword(),
          Divider(),
          _textData(context),
        ],
      ),
      backgroundColor: _localPreferencies.secundari,
      /* Boto de guarda dades i retornar a la pantalla inicial */
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: _localPreferencies.botons,
        onPressed: () {
          // Emplenar l'objecte perRet per retornar a la pantalla inicial.

          if (_nom!.isEmpty) {
            //Alerta de nom buid
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('No pots deixar el camp del nom en blanc'),
                  actions: <Widget>[
                    FloatingActionButton(
                      child: Icon(Icons.check),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          } else {
            if (!validateEmail(_email)) {
              // Alerta de mail
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Has d\'introduir un correu electrònic vàlid'),
                    actions: <Widget>[
                      FloatingActionButton(
                        child: Icon(Icons.check),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            } else {
              // Tot Ok
              // Es permet el guardar una persona sense llinatges ni sense contrasenya
              // Emplenar l'objecte perRet per retornar a la pantalla inicial.
              persRet.nom = _controllerNom.text;
              persRet.llinatge = _controllerLlinatge.text;
              persRet.email = _controllerCorreu.text;
              persRet.password = _controllerPassword.text;
              persRet.dataNaixament = _controllerData.text;
              // Retornar l'objecte emplenat
              Navigator.of(context).pop(persRet);
            }
          }
        },
        child: Icon(Icons.save),
      ),
    );
  }

  // Es retorna un TextField, on es demana el nom
  _textNom() {
    return TextField(
      controller: _controllerNom,
      //autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        hintText: 'Nom de l\'usuari',
        icon: Icon(Icons.account_circle),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
      onChanged: (valor) {
        setState(() {
          // Al canviar el valor, es guarda a un objecte User que es retornarà al Home
          // També es regeneren les inicials
          _nom = valor;
          persRet.nom = _nom;
          generarInicials();
        });
      },
    );
  }

  // Es retorna un TextField, on es demana el llinatge
  _textLlinatge() {
    return TextField(
      controller: _controllerLlinatge,
      //autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        hintText: 'Llinatge de l\'usuari',
        icon: Icon(Icons.account_circle_outlined),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
      onChanged: (valor) {
        setState(
          () {
            // Al canviar el valor, es guarda a un objecte User que es retornarà al Home
            // També es regeneren les inicials
            _llinatge = valor;
            persRet.llinatge = _llinatge;
            generarInicials();
            //print(_inicials);
          },
        );
      },
    );
  }

  // Es retorna un TextField, on es demana el correu electronic
  _textEmail() {
    return TextField(
      controller: _controllerCorreu,
      //autofocus: true,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Correu Electronic',
        icon: Icon(Icons.email),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
      onChanged: (valor) => setState(() {
        _email = valor;
        persRet.email = _email;
      }),
    );
  }

  // Es retorna un TextField, on es demana la contrasenya
  // La contrasenya es manto obscura
  _textPassword() {
    return TextField(
      controller: _controllerPassword,
      //autofocus: true,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Contrasenya',
        icon: Icon(Icons.lock),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
      onChanged: (valor) {
        _password = valor;
        persRet.password = _password;
      },
    );
  }

  // Per seleccionar la data de naixament sortirà un calendari
  Widget _textData(BuildContext context) {
    return TextField(
      enableInteractiveSelection: false,
      controller: _controllerData,
      decoration: InputDecoration(
        hintText: 'Data naixement',
        icon: Icon(Icons.calendar_today),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _seleccionaData(context);
      },
    );
  }

  //
  void _seleccionaData(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      locale: Locale('ca', 'ES'), //Incicam que el format es catala a Espanya
      initialDate: DateTime.now(), // data màxima, avui
      firstDate: DateTime(1900),
      lastDate:
          DateTime.now(), // La data de neixement no podra ser superior a avui
    );
    if (picked != null) {
      _controllerData = TextEditingController(text: _dataNaixament);
      print(_dataNaixament);

      setState(() {
        //_dataNaixament = picked.toString();
        DateTime data = picked;

        // Passar de format DateTime a string amb format dd/mm/yyyy
        _dataNaixament = data.day.toString() +
            "/" +
            data.month.toString() +
            "/" +
            data.year.toString();
        persRet.dataNaixament = _dataNaixament;
      });
    }
  }
}
