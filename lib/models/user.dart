// Classe User.
// Aquesta classe crearà objectes que serà el que s'encarregarà de passar les dades d'usuari

class User {
  String? nom;
  String? llinatge;
  String? email;
  String? password;
  String? dataNaixament;

  User(
      {this.nom, this.llinatge, this.email, this.password, this.dataNaixament});

  User.buit();
}
