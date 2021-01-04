import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Usuario {
  String USERNAME, EMAIL, TELEFONE;
  TimeOfDay HORARIOPREFERIDO;

  Usuario(
      {@required this.EMAIL,
      this.HORARIOPREFERIDO,
      this.TELEFONE,
      this.USERNAME}) {}

  Usuario.fromMap(Map<String, dynamic> map) {
    USERNAME = map['NOME'];
    EMAIL = map['EMAIL'];
    TELEFONE = map['TELEFONE'];
    HORARIOPREFERIDO = map['HORARIOPREFERIDO'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'NOME': USERNAME,
      'EMAIL': EMAIL,
      'TELEFONE': TELEFONE,
      'HORARIOPREFERIDO': HORARIOPREFERIDO
    };
    return map;
  }
}
