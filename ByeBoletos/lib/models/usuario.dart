import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Usuario {
  String USERNAME, EMAIL, TELEFONE;
  TimeOfDay HORARIOPREFERIDO;

  Usuario(
      {@required this.EMAIL,
      @required this.HORARIOPREFERIDO,
      @required this.TELEFONE,
      @required this.USERNAME}) {}

  Usuario.fromMap(Map<String, dynamic> map) {
    USERNAME = map['NOME'];
    EMAIL = map['EMAIL'];
    TELEFONE = map['TELEFONE'];
    HORARIOPREFERIDO = TimeOfDay(
        hour: int.parse(map['HORARIOPREFERIDO'].split(':')[0]),
        minute: int.parse(map['HORARIOPREFERIDO'].split(':')[1]));
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'NOME': USERNAME,
      'EMAIL': EMAIL,
      'TELEFONE': TELEFONE,
      'HORARIOPREFERIDO': '${HORARIOPREFERIDO.hour}:${HORARIOPREFERIDO.minute}'
    };
    return map;
  }
}
