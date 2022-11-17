import 'package:practica2/models/preferences.dart';
import 'package:practica2/models/user.dart';

// Aquest objecte servirà per passar tant els parametres User
// com els parametres de preferencies a la pàgina Personal

class UserPref {
  User? persona;
  Preferences? preferencies;

  // Constructor
  UserPref(this.persona, this.preferencies);
}
